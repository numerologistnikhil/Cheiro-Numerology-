import 'package:flutter_test/flutter_test.dart';
import '../lib/core/month_details.dart';

void main() {
  test('every personal month 1 to 9 has full English and Hindi text', () {
    for (var m = 1; m <= 9; m++) {
      final d = MonthDetails.all[m];
      expect(d, isNotNull, reason: 'month $m missing');
      for (final p in [d!.word, d.story, d.work, d.love, d.health, d.tip]) {
        expect(p.en.trim().isNotEmpty, true);
        expect(p.hi.trim().isNotEmpty, true);
      }
      expect(d.story.en.length > 80, true);
    }
  });
}
