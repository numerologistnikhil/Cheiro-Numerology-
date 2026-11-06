import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/pythagorean.dart';

void main() {
  test('reduction keeps master numbers', () {
    expect(Pythagorean.reduceKeep(29), 11);
    expect(Pythagorean.reduceKeep(38), 11);
    expect(Pythagorean.reduceKeep(22), 22);
    expect(Pythagorean.reduceKeep(33), 33);
    expect(Pythagorean.reduceKeep(32), 5);
    expect(Pythagorean.reduceAll(29), 2);
  });

  test('life path of 6 April 1988', () {
    // 4 + 6 + (1+9+8+8=26->8) = 18 -> 9
    final c = Pythagorean.chart(DateTime(1988, 4, 6), '');
    expect(c.lifePathRaw, 18);
    expect(c.lifePath, 9);
    expect(c.expression, isNull);
  });

  test('life path with master and karmic examples', () {
    // 29 Nov 1999: 11 + 11 + (28->1 ... 1+9+9+9=28->10->1) = 23 -> 5
    expect(Pythagorean.chart(DateTime(1999, 11, 29), '').lifePath, 5);
    // 4 Sep 1990: 9 + 4 + (19->10->1) = 14 karmic 14/5
    final k = Pythagorean.chart(DateTime(1990, 9, 4), '');
    expect(k.lifePathRaw, 14);
    expect(k.karmicDebts, [14]);
    expect(k.lifePath, 5);
  });

  test('name numbers with the Pythagorean table', () {
    // ANNU: A1 N5 N5 U3 = 14 -> 5, vowels A1 U3 = 4, consonants N5 N5 = 10 -> 1
    final c = Pythagorean.chart(DateTime(1988, 4, 6), 'Annu');
    expect(c.expressionRaw, 14);
    expect(c.expression, 5);
    expect(c.soulUrge, 4);
    expect(c.personality, 1);
    expect(c.karmicDebts, [14]);
    expect(c.maturity, Pythagorean.reduceKeep(9 + 5));
  });

  test('letters ignore spaces and symbols', () {
    expect(Pythagorean.nameTotal('A n-n U'), 14);
  });

  test('personal year is one digit', () {
    final py = Pythagorean.personalYear(DateTime(1988, 4, 6), 2026);
    expect(py, 2); // 6 + 4 + 1(2026->10->1) = 11 -> 2
  });

  test('all numbers have texts', () {
    for (final n in [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33]) {
      for (final m in [WesternText.core, WesternText.inner, WesternText.outer]) {
        expect(m[n]!.en.isNotEmpty && m[n]!.hi.isNotEmpty, isTrue);
      }
    }
    for (final k in [13, 14, 16, 19]) {
      expect(WesternText.karmicText.containsKey(k), isTrue);
    }
  });
}
