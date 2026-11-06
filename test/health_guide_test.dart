import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/health_guide.dart';

void main() {
  test('every number 1-9 has complete bilingual health guidance', () {
    for (var n = 1; n <= 9; n++) {
      final h = HealthGuide.byRoot[n]!;
      expect(h.root, n);
      for (final l in [h.planet, h.areas, h.watch, h.habits, h.checkup]) {
        expect(l.en.trim().isNotEmpty && l.hi.trim().isNotEmpty, isTrue, reason: 'number $n');
      }
    }
  });

  test('precautions are bilingual and never promise cures', () {
    expect(HealthGuide.precautions.length >= 10, isTrue);
    for (final p in HealthGuide.precautions) {
      expect(p.en.isNotEmpty && p.hi.isNotEmpty, isTrue);
    }
    final all = HealthGuide.byRoot.values.map((h) => '${h.areas.en} ${h.watch.en} ${h.habits.en}').join(' ').toLowerCase();
    for (final bad in ['cure', 'guarantee', 'will get', 'will suffer']) {
      expect(all.contains(bad), isFalse, reason: bad);
    }
  });
}
