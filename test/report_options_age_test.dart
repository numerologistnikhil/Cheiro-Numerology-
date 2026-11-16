import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/report_options.dart';

void main() {
  test('default is the coming years', () {
    const o = ReportOptions();
    expect(o.byAge, isFalse);
    expect(o.span, 10);
  });

  test('age range 10 to 25 covers 16 years', () {
    final o = const ReportOptions().copyWith(ageFrom: 10, ageTo: 25);
    expect(o.byAge, isTrue);
    expect(o.span, 16);
  });

  test('range is capped at 50 years and a bad range is ignored', () {
    expect(const ReportOptions(ageFrom: 0, ageTo: 90).span, 50);
    expect(const ReportOptions(ageFrom: 30, ageTo: 20).byAge, isFalse);
  });

  test('the age range is saved and loaded', () {
    final o = const ReportOptions(ageFrom: 10, ageTo: 25);
    final back = ReportOptions.fromJson(o.toJson());
    expect(back.ageFrom, 10);
    expect(back.ageTo, 25);
    expect(ReportOptions.fromJson(const {}).byAge, isFalse);
  });
}
