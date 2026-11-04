import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/gemstone_guide.dart';

void main() {
  test('all nine stones are complete, in English and Hindi', () {
    expect(GemstoneGuide.gems.length, 9);
    final ids = <String>{};
    for (var n = 1; n <= 9; n++) {
      final g = GemstoneGuide.gems[n]!;
      expect(g.root, n);
      expect(ids.add(g.id), isTrue);
      expect(g.finger >= 0 && g.finger <= 4, isTrue);
      for (final l in [g.gem, g.alt, g.planet, g.metal, g.day, g.weight, g.mantra, g.caution]) {
        expect(l.en.trim().isNotEmpty, isTrue, reason: 'English text of stone $n');
        expect(l.hi.trim().isNotEmpty, isTrue, reason: 'Hindi text of stone $n');
      }
    }
  });

  test('guide texts exist for steps, age table and fingers', () {
    expect(GemstoneGuide.steps.length, 7);
    expect(GemstoneGuide.ageTable.length, 4);
    expect(GemstoneGuide.fingerNames.length, 5);
  });
}
