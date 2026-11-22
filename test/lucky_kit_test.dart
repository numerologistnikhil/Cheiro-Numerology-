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
    // 9 is a friend of 6 (2 points) and the same as 9 (2 points): good.
    final good = LuckyKit.house('9', 6, 9)!;
    expect(good.root, 9);
    expect(good.score, 4);
    expect(good.verdict, HouseVerdict.good);
    // 7 is neutral with 6 and neutral with 9 (1 + 1): mixed.
    final mixed = LuckyKit.house('7', 6, 9)!;
    expect(mixed.root, 7);
    expect(mixed.verdict, HouseVerdict.mixed);
    // 8 is neutral with 6 (1) and challenging with 9 (0): needs care.
    final careful = LuckyKit.house('8', 6, 9)!;
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
    expect(avoid, [8]);
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
    expect(NumerologyTools.relation(2, 8), Relation.enemy);
  });
}
