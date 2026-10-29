import 'package:flutter_test/flutter_test.dart';
import '../lib/core/name_suggester.dart';
import '../lib/core/numerology_engine.dart';

void main() {
  final dob = DateTime(1988, 4, 6);

  test('gives up to 10 different spellings, none equal to the original', () {
    final r = NameSuggester.suggest('Nikhil Gulati', dob: dob);
    expect(r, isNotNull);
    expect(r!.items.isNotEmpty, true);
    expect(r.items.length <= NameSuggester.maxResults, true);
    final seen = <String>{};
    for (final s in r.items) {
      expect(s.name.toLowerCase() == 'nikhil gulati', false);
      expect(seen.add(s.name.toLowerCase()), true, reason: 'duplicate ${s.name}');
      expect(s.total > 0, true);
      expect(s.root >= 1 && s.root <= 9, true);
      expect(s.changes.isNotEmpty, true);
    }
  });

  test('suggestions are ordered best first', () {
    final r = NameSuggester.suggest('Annu Sharma', dob: dob)!;
    for (var i = 1; i < r.items.length; i++) {
      expect(r.items[i - 1].points >= r.items[i].points, true);
    }
  });

  test('totals match the engine', () {
    final r = NameSuggester.suggest('Ravi Kumar', dob: dob)!;
    for (final s in r.items) {
      expect(NumerologyEngine.name(s.name).total, s.total);
    }
  });

  test('works without a date of birth', () {
    final r = NameSuggester.suggest('Priya Singh');
    expect(r, isNotNull);
    expect(r!.mulank, isNull);
    expect(r.items.isNotEmpty, true);
  });

  test('no English letters gives null', () {
    expect(NameSuggester.suggest('नमस्ते', dob: dob), isNull);
    expect(NameSuggester.suggest('   ', dob: dob), isNull);
  });

  test('explanations exist in both languages', () {
    final r = NameSuggester.suggest('Nikhil Gulati', dob: dob)!;
    final s = r.items.first;
    expect(NameSuggester.explain(r, s, false).isNotEmpty, true);
    expect(NameSuggester.explain(r, s, true).isNotEmpty, true);
    expect(NameSuggester.details(s, false).length > 1, true);
    expect(NameSuggester.details(s, true).length > 1, true);
  });
}
