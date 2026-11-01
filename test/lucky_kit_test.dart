import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/lucky_kit.dart';
import 'package:cheiro_numerology/core/numerology_tools.dart';

void main() {
  test('house number: empty or uncountable gives null', () {
    expect(LuckyKit.house('', 6, 9), isNull);
    expect(LuckyKit.house('   ', 6, 9), isNull);
    expect(LuckyKit.house('---', 6, 9), isNull);
  });

  test('house number verdicts follow the friend and enemy table', () {
    // 9 is neutral with 6 (1 point) and the same as 9 (2 points): good.
    final good = LuckyKit.house('9', 6, 9)!;
    expect(good.root, 9);
    expect(good.score, 3);
    expect(good.verdict, HouseVerdict.good);
    // 3 is challenging with 6 (0 points) and friendly with 9 (2): mixed.
    final mixed = LuckyKit.house('12', 6, 9)!;
    expect(mixed.root, 3);
    expect(mixed.verdict, HouseVerdict.mixed);
    // 3 is challenging with 6 and with 6: needs care.
    final careful = LuckyKit.house('3', 6, 6)!;
    expect(careful.verdict, HouseVerdict.careful);
  });

  test('flat numbers with letters count the letters', () {
    final r = LuckyKit.house('B-204', 6, 9)!;
    expect(r.number.total, 8); // B=2, 2+0+4
    expect(r.root, 8);
  });

  test('lucky numbers avoid challenging roots and have no repeats', () {
    final picks = LuckyKit.luckyNumbers(6, 9, count: 6);
    expect(picks.length, 6);
    expect(picks.map((e) => e.number).toSet().length, 6);
    final avoid = LuckyKit.avoidRoots(6, 9);
    expect(avoid, [3, 4, 8]);
    for (final p in picks) {
      expect(avoid.contains(p.root), isFalse);
      expect(p.number >= 1 && p.number <= 99, isTrue);
      expect(LuckyKit.rootOf(p.number), p.root);
    }
  });

  test('every root 1 to 9 has a home description', () {
    for (var i = 1; i <= 9; i++) {
      expect(LuckyKitText.home[i], isNotNull);
    }
    expect(NumerologyTools.relation(3, 6), Relation.enemy);
  });
}
