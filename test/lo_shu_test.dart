import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/lo_shu.dart';

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
}
