import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/root_profiles.dart';

void main() {
  test('all root profiles 1-9 are complete in English and Hindi', () {
    for (var n = 1; n <= 9; n++) {
      final p = RootProfiles.of(n);
      expect(p, isNotNull, reason: 'missing profile $n');
      final fields = [
        p!.title, p.planet, p.luckyDays, p.colours, p.gemstone, p.overview,
        p.personality, p.strengths, p.challenges, p.career, p.money, p.love,
        p.health, p.advice,
      ];
      for (final f in fields) {
        expect(f.en.trim().isNotEmpty, true);
        expect(f.hi.trim().isNotEmpty, true);
      }
    }
  });
}
