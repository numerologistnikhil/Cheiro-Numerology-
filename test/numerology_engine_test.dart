import 'package:cheiro_numerology/core/numerology_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('reduction', () {
    test('root reduces to a single digit', () {
      expect(NumerologyEngine.root(32), 5);
      expect(NumerologyEngine.root(10), 1);
      expect(NumerologyEngine.root(9), 9);
      expect(NumerologyEngine.root(0), 0);
      expect(NumerologyEngine.root(103), 4);
    });

    test('root ignores sign', () {
      expect(NumerologyEngine.root(-23), 5);
    });

    test('reductionChain shows every step', () {
      expect(NumerologyEngine.reductionChain(32), [32, 5]);
      expect(NumerologyEngine.reductionChain(5), [5]);
      expect(NumerologyEngine.reductionChain(99), [99, 18, 9]);
    });
  });

  group('letter table', () {
    test('all 26 letters are mapped and none maps to 9', () {
      for (var code = 65; code <= 90; code++) {
        final letter = String.fromCharCode(code);
        final value = NumerologyEngine.letters[letter];
        expect(value, isNotNull, reason: 'missing $letter');
        expect(value, inInclusiveRange(1, 8), reason: 'bad value for $letter');
      }
    });
  });

  group('name', () {
    test('ANNU = 1 + 5 + 5 + 6 = 17, root 8', () {
      final r = NumerologyEngine.name('ANNU');
      expect(r.total, 17);
      expect(r.root, 8);
      expect(r.items.length, 4);
      expect(r.items.first.symbol, 'A');
      expect(r.items.first.value, 1);
    });

    test('is case-insensitive and skips spaces silently', () {
      final r = NumerologyEngine.name('an nu');
      expect(r.total, 17);
      expect(r.ignored, isEmpty);
    });

    test('reports unsupported characters instead of hiding them', () {
      final r = NumerologyEngine.name('A. N-nu1');
      expect(r.total, 17);
      expect(r.ignored, ['.', '-', '1']);
    });

    test('raw total above 52 is preserved and never clamped', () {
      final r = NumerologyEngine.name('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
      expect(r.total, 103);
      expect(r.root, 4);
      expect(r.hasCheiroCompound, isFalse);
    });

    test('empty input gives zero', () {
      final r = NumerologyEngine.name('');
      expect(r.total, 0);
      expect(r.root, 0);
    });

    test('keeps the original input', () {
      expect(NumerologyEngine.name(' Annu ').input, ' Annu ');
    });
  });

  group('date', () {
    test('6 April 1988 digits sum to 36', () {
      final r = NumerologyEngine.date(DateTime(1988, 4, 6));
      expect(r.total, 36);
      expect(r.root, 9);
      expect(r.items.map((e) => e.value).toList(), [6, 4, 1, 9, 8, 8]);
    });

    test('birth numbers split psychic (day) and destiny (full date)', () {
      final b = NumerologyEngine.birth(DateTime(1988, 4, 6));
      expect(b.psychic.total, 6);
      expect(b.psychic.root, 6);
      expect(b.destiny.total, 36);
      expect(b.destiny.root, 9);
    });

    test('two-digit day keeps its compound total', () {
      final b = NumerologyEngine.birth(DateTime(1990, 2, 28));
      expect(b.psychic.total, 10);
      expect(b.psychic.root, 1);
    });
  });

  group('mobile', () {
    test('9210896940 sums to 48, root 3', () {
      final r = NumerologyEngine.mobile('9210896940');
      expect(r.total, 48);
      expect(r.root, 3);
    });

    test('formatting characters are reported, digits all counted', () {
      final r = NumerologyEngine.mobile('+91 92108-96940');
      expect(r.total, 58);
      expect(r.ignored, ['+', '-']);
    });

    test('leading zero does not change the total', () {
      expect(NumerologyEngine.mobile('09210896940').total, 48);
    });
  });

  group('vehicle', () {
    test('DL 3C AB 1234 = 26, root 8', () {
      final r = NumerologyEngine.vehicle('DL 3C AB 1234');
      expect(r.total, 26);
      expect(r.root, 8);
    });

    test('lower case works and symbols are reported', () {
      final r = NumerologyEngine.vehicle('dl-3c');
      expect(r.total, 13);
      expect(r.ignored, ['-']);
    });
  });
}
