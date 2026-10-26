import 'package:flutter_test/flutter_test.dart';

import '../lib/core/report_options.dart';
import '../lib/core/story_report.dart';

// English only: Hindi text is drawn with Flutter fonts, which a plain unit
// test does not have. Footer lines are also left empty for the same reason.
void main() {
  final dob = DateTime(1988, 4, 6);

  bool isPdf(List<int> b) =>
      b.length > 5000 && String.fromCharCodes(b.sublist(0, 4)) == '%PDF';

  test('report builds with every border and colour combination', () async {
    for (final b in ReportOptions.borders) {
      final doc = await StoryReport.build(
        name: 'Annu Test',
        dob: dob,
        mobile: '9876543210',
        options: ReportOptions(
          borderId: b.id,
          paletteId: b.id % ReportOptions.palettes.length,
          years: 3,
        ),
      );
      final bytes = await doc.save();
      expect(isPdf(bytes), true, reason: 'border ${b.nameEn}');
    }
  });

  test('black and white, no angel numbers, 12 years', () async {
    final doc = await StoryReport.build(
      name: 'Annu Test',
      dob: dob,
      options: const ReportOptions(
        blackWhite: true,
        includeAngelNumbers: false,
        years: 12,
      ),
    );
    expect(isPdf(await doc.save()), true);
  });

  test('free sample report builds and is smaller than the full one', () async {
    const o = ReportOptions(years: 10);
    final full = await (await StoryReport.build(name: 'Annu Test', dob: dob, options: o)).save();
    final sample = await (await StoryReport.build(name: 'Annu Test', dob: dob, options: o, sample: true)).save();
    expect(isPdf(sample), true);
    expect(sample.length < full.length, true);
  });

  test('old call style still works (hindi false, years 2)', () async {
    final doc = await StoryReport.build(name: 'Annu Test', dob: dob, years: 2);
    expect(isPdf(await doc.save()), true);
  });
}
