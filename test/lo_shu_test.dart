import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/lo_shu.dart';
import 'package:cheiro_numerology/core/lo_shu_more.dart';

void main() {
  test('Lo Shu counts for 6 April 1988', () {
    // Digits 6,4,1,9,8,8 plus psychic 6 and destiny 9.
    final c = LoShu.counts(DateTime(1988, 4, 6));
    expect(c[1], 1);
    expect(c[4], 1);
    expect(c[6], 2);
    expect(c[8], 2);
    expect(c[9], 2);
    expect(LoShu.missing(c), [2, 3, 5, 7]);
    // Only the 8-1-6 line (index 2) is complete.
    expect(LoShu.completePlanes(c), [2]);
  });

  test('Lo Shu ignores zeros in the date', () {
    final c = LoShu.counts(DateTime(2000, 10, 20));
    expect(c.containsKey(0), false);
    expect(c.values.every((v) => v >= 0), true);
  });

  test('Lo Shu line, row and repeat helpers for 6 April 1988', () {
    final c = LoShu.counts(DateTime(1988, 4, 6));
    expect(LoShu.lineCount(c, 2), 3); // 8-1-6
    expect(LoShu.lineCount(c, 1), 0); // 3-5-7 missing arrow
    expect(LoShu.rowCount(c, 0), 2); // 4, 9 present; 2 missing
    expect(LoShu.repeated(c), [6, 8, 9]);
    expect(LoShu.dominantRow(c), 2);
    expect(LoShu.dateDigits(DateTime(1988, 4, 6)), '6 4 1 9 8 8');
  });

  test('Lo Shu more texts exist for every number and line state', () {
    for (var n = 1; n <= 9; n++) {
      expect(LoShuMore.excess[n], isNotNull);
      expect(LoShuMore.remedy[n], isNotNull);
    }
    expect(LoShuMore.lineState.length, 4);
    expect(LoShuMore.groupLevel.length, 4);
    expect(LoShuMore.groupNames.length, 3);
    expect(LoShuMore.dominant.length, 3);
  });
}
