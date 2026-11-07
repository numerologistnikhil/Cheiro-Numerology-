import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/year_month_blend.dart';

void main() {
  test('all 81 year and month combinations read differently', () {
    final en = <String>{};
    final hi = <String>{};
    for (var y = 1; y <= 9; y++) {
      for (var m = 1; m <= 9; m++) {
        final l = YearMonthBlend.line(y, m);
        expect(l.en.isNotEmpty && l.hi.isNotEmpty, isTrue);
        en.add(l.en);
        hi.add(l.hi);
      }
    }
    expect(en.length, 81);
    expect(hi.length, 81);
  });

  test('same number combinations mention the doubling', () {
    expect(YearMonthBlend.line(4, 4).en.contains('doubled'), isTrue);
    expect(YearMonthBlend.line(4, 5).en.contains('doubled'), isFalse);
  });
}
