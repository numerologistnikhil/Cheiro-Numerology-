import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/screens/daily_lucky_screen.dart';

void main() {
  test('daily number is always between 1 and 9', () {
    for (var y = 1980; y <= 2000; y += 3) {
      for (var m = 1; m <= 12; m++) {
        final birth = DateTime(y, m, 6);
        for (var d = 1; d <= 28; d++) {
          final n = dailyNumber(birth, DateTime(2026, m, d));
          expect(n >= 1 && n <= 9, isTrue, reason: '$birth $d gave $n');
        }
      }
    }
  });
}
