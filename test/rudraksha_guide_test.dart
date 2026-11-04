import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/rudraksha_guide.dart';

void main() {
  test('14 mukhi entries are complete in English and Hindi', () {
    expect(RudrakshaGuide.mukhis.length, 14);
    for (var m = 1; m <= 14; m++) {
      final r = RudrakshaGuide.mukhis[m]!;
      expect(r.mukhi, m);
      for (final l in [r.deity, r.planet, r.mantra, r.focus, r.note]) {
        expect(l.en.trim().isNotEmpty, isTrue, reason: 'English $m');
        expect(l.hi.trim().isNotEmpty, isTrue, reason: 'Hindi $m');
      }
    }
  });

  test('every birth number maps to existing mukhi types', () {
    for (var n = 1; n <= 9; n++) {
      final list = RudrakshaGuide.forRoot[n]!;
      expect(list.isNotEmpty, isTrue);
      for (final m in list) {
        expect(RudrakshaGuide.mukhis.containsKey(m), isTrue, reason: 'number $n, mukhi $m');
      }
    }
  });

  test('guide texts exist', () {
    expect(RudrakshaGuide.energise.length, 6);
    expect(RudrakshaGuide.fake.length, 6);
  });
}
