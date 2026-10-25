import 'package:flutter_test/flutter_test.dart';
import '../lib/core/report_options.dart';

void main() {
  test('12 borders and 12 colour combinations', () {
    expect(ReportOptions.borders.length, 12);
    expect(ReportOptions.palettes.length, 12);
  });

  test('black and white overrides colour', () {
    const o = ReportOptions(paletteId: 5, blackWhite: true);
    expect(o.palette.id, 99);
    expect(const ReportOptions(paletteId: 5).palette.id, 5);
  });

  test('footer is cleaned and limited', () {
    final long = 'a' * 200;
    expect(ReportOptions.cleanFooter(long).length, ReportOptions.maxFooterChars);
    const o = ReportOptions(footerLine1: '  Hello   World ', footerLine2: '');
    expect(o.footerLines, ['Hello World']);
    expect(const ReportOptions().hasFooter, false);
  });

  test('json round trip', () {
    const o = ReportOptions(hindi: true, borderId: 7, paletteId: 3, footerLine1: 'Raj Numerology');
    final r = ReportOptions.fromJson(o.toJson());
    expect(r.hindi, true);
    expect(r.borderId, 7);
    expect(r.paletteId, 3);
    expect(r.footerLine1, 'Raj Numerology');
  });
}
