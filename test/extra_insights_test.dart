import 'package:flutter_test/flutter_test.dart';
import '../lib/core/extra_insights.dart';

void main() {
  test('repeat pattern 777', () {
    final r = NumberPatterns.analyze('777');
    expect(r.total, 21);
    expect(r.root, 3);
    expect(r.findings.any((f) => f.id == 'repeat'), true);
  });

  test('rising chain 1234', () {
    final r = NumberPatterns.analyze('1234');
    expect(r.total, 10);
    expect(r.root, 1);
    expect(r.findings.any((f) => f.id == 'ascending'), true);
  });

  test('mirror 4554', () {
    final r = NumberPatterns.analyze('4554');
    expect(r.findings.any((f) => f.id == 'palindrome'), true);
  });

  test('alternating 1212', () {
    final r = NumberPatterns.analyze('1212');
    expect(r.findings.any((f) => f.id == 'alternating'), true);
  });

  test('no digits', () {
    final r = NumberPatterns.analyze('abc');
    expect(r.digits, '');
    expect(r.isSpecial, false);
  });

  test('time energy', () {
    expect(TimeEnergy.forTime(DateTime(2026, 10, 25, 11, 11)), isNotNull);
    expect(TimeEnergy.forTime(DateTime(2026, 10, 25, 9, 9)), isNotNull);
    expect(TimeEnergy.forTime(DateTime(2026, 10, 25, 9, 41)), isNull);
  });

  test('name score ANKDHARA', () {
    final s = NameScore.of('ANKDHARA')!;
    expect(s.compound, 21);
    expect(s.root, 3);
    expect(s.luck, 85);
    expect(s.wealth, 85);
    expect(NameScore.of('1234'), isNull);
  });
}
