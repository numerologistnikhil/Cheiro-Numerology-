import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/date_reasons.dart';
import 'package:cheiro_numerology/core/numerology_tools.dart';

void main() {
  test('every number has a day character and a business idea in both languages', () {
    for (var n = 1; n <= 9; n++) {
      expect(DateReasons.dayCharacter[n]!.hi.isNotEmpty, isTrue);
      expect(DateReasons.businessIdeas[n]!.hi.isNotEmpty, isTrue);
      expect(DateReasons.businessIdeas[n]!.en.isNotEmpty, isTrue);
    }
  });

  test('suggested dates get reasons', () {
    final list = NumerologyTools.suggestDates(
        DateTime(1988, 4, 6), 'Business start', DateTime(2026, 11, 4));
    for (final d in list) {
      final r = DateReasons.reasons(d, 6, 1, 'Business start');
      expect(r.length >= 3, isTrue);
      for (final l in r) {
        expect(l.en.isNotEmpty && l.hi.isNotEmpty, isTrue);
      }
    }
  });

  test('every purpose has a translated name', () {
    for (final p in NumerologyTools.purposeFavoured.keys) {
      expect(DateReasons.purposeNames.containsKey(p), isTrue);
    }
  });
}
