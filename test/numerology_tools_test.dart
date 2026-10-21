import 'package:cheiro_numerology/core/numerology_engine.dart';
import 'package:cheiro_numerology/core/numerology_tools.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final dob = DateTime(1988, 4, 6);

  group('personal cycles', () {
    test('personal year for 6 April in 2026 is 2', () {
      expect(NumerologyTools.personalYear(dob, 2026), 2);
    });

    test('personal year for 6 April in 2027 is 3', () {
      expect(NumerologyTools.personalYear(dob, 2027), 3);
    });

    test('personal month adds the calendar month', () {
      expect(NumerologyTools.personalMonth(dob, 2026, 10), 3);
    });

    test('every personal year 1-9 has a theme and every month hint exists', () {
      for (var n = 1; n <= 9; n++) {
        expect(NumerologyTools.yearThemes[n], isNotNull);
        expect(NumerologyTools.monthHints[n], isNotNull);
      }
    });
  });

  group('relations', () {
    test('same numbers are friendly', () {
      expect(NumerologyTools.relation(3, 3), Relation.friend);
    });

    test('1 and 8 are challenging in both directions', () {
      expect(NumerologyTools.relation(1, 8), Relation.enemy);
      expect(NumerologyTools.relation(8, 1), Relation.enemy);
    });

    test('4 and 8 are friendly', () {
      expect(NumerologyTools.relation(4, 8), Relation.friend);
    });

    test('unlisted pairs are neutral', () {
      expect(NumerologyTools.relation(6, 9), Relation.neutral);
    });

    test('relation is symmetric for all pairs', () {
      for (var a = 1; a <= 9; a++) {
        for (var b = 1; b <= 9; b++) {
          expect(
            NumerologyTools.relation(a, b),
            NumerologyTools.relation(b, a),
            reason: '$a and $b',
          );
        }
      }
    });
  });

  group('compatibility', () {
    test('same birth date scores 6 of 8 and is strong harmony', () {
      final r = NumerologyTools.compatibility(dob, dob);
      expect(r.score, 6);
      expect(r.maxScore, 8);
      expect(r.label, 'Strong harmony');
      expect(r.lines.length, 4);
    });

    test('score is always within range', () {
      for (var d = 1; d <= 28; d++) {
        final r = NumerologyTools.compatibility(dob, DateTime(1990, 5, d));
        expect(r.score, inInclusiveRange(0, 8));
      }
    });
  });

  group('business', () {
    test('score combines psychic and destiny relations', () {
      expect(NumerologyTools.businessScore(1, 1, 8), 2);
      expect(NumerologyTools.businessScore(1, 1, 1), 4);
      expect(NumerologyTools.businessScore(1, 8, 8), 0);
    });
  });

  group('baby names', () {
    test('no suggestion is challenging for the birth numbers', () {
      final birth = NumerologyEngine.birth(dob);
      final list = NumerologyTools.suggestNames(dob, boy: true);
      expect(list, isNotEmpty);
      for (final s in list) {
        expect(
          NumerologyTools.relation(s.result.root, birth.psychic.root),
          isNot(Relation.enemy),
        );
        expect(
          NumerologyTools.relation(s.result.root, birth.destiny.root),
          isNot(Relation.enemy),
        );
        expect(s.baby.boy, isTrue);
      }
    });

    test('starting letter filter works', () {
      final list =
          NumerologyTools.suggestNames(dob, boy: false, startsWith: 'a');
      for (final s in list) {
        expect(s.baby.name.toUpperCase().startsWith('A'), isTrue);
        expect(s.baby.boy, isFalse);
      }
    });

    test('built-in list has both boy and girl names', () {
      expect(NumerologyTools.babyNames.where((b) => b.boy), isNotEmpty);
      expect(NumerologyTools.babyNames.where((b) => !b.boy), isNotEmpty);
    });
  });

  group('date selection', () {
    test('results stay in range, sorted by date and not challenging', () {
      final from = DateTime(2026, 11, 1);
      final birth = NumerologyEngine.birth(dob);
      final list =
          NumerologyTools.suggestDates(dob, 'Business start', from);
      expect(list.length, lessThanOrEqualTo(8));
      for (var i = 0; i < list.length; i++) {
        final s = list[i];
        expect(s.date.isBefore(from), isFalse);
        expect(s.date.isBefore(from.add(const Duration(days: 45))), isTrue);
        expect(
          NumerologyTools.relation(s.dayNumber, birth.psychic.root),
          isNot(Relation.enemy),
        );
        if (i > 0) {
          expect(s.date.isBefore(list[i - 1].date), isFalse);
        }
      }
    });
  });

  group('content tables', () {
    test('remedies and professions exist for every number', () {
      for (var n = 1; n <= 9; n++) {
        expect(NumerologyTools.remedies[n], isNotNull);
        expect(NumerologyTools.professions[n], isNotEmpty);
        expect(NumerologyTools.planetOf(n), isNot('-'));
      }
    });

    test('quiz answers point to a real option', () {
      for (final q in NumerologyTools.quiz) {
        expect(q.answer, inInclusiveRange(0, q.options.length - 1));
      }
    });

    test('quiz facts match the engine', () {
      expect(NumerologyEngine.root(32), 5);
      expect(NumerologyEngine.letters['F'], 8);
      expect(NumerologyEngine.birth(dob).destiny.root, 9);
      expect(NumerologyEngine.root(99), 9);
    });
  });
}
