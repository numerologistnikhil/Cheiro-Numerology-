import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/profession_guide.dart';

void main() {
  test('every number has fields with examples in both languages', () {
    for (var r = 1; r <= 9; r++) {
      final w = ProfessionGuide.byRoot[r];
      expect(w, isNotNull, reason: 'root $r');
      expect(w!.fields.length, greaterThanOrEqualTo(5));
      for (final f in w.fields) {
        expect(f.name.en, isNotEmpty);
        expect(f.name.hi, isNotEmpty);
        expect(f.examples.en.contains(','), isTrue);
        expect(f.examples.hi.contains(','), isTrue);
      }
      expect(w.strength.hi, isNotEmpty);
      expect(w.avoid.en, isNotEmpty);
    }
  });

  test('food and hotel work is listed for the numbers that suit it', () {
    String all(int r) =>
        ProfessionGuide.byRoot[r]!.fields.map((f) => f.examples.en).join(' ').toLowerCase();
    for (final r in [2, 6]) {
      expect(all(r), contains('hotel'));
      expect(all(r), contains('restaurant'));
      expect(all(r), contains('catering'));
    }
  });
}
