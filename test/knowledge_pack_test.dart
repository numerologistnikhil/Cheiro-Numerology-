import 'package:cheiro_numerology/core/knowledge_pack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('framework range is 10-54 for compounds', () {
    expect(KnowledgePack.minCompound, 10);
    expect(KnowledgePack.maxCompound, 54);
    expect(KnowledgePack.isValidCompound(9), isFalse);
    expect(KnowledgePack.isValidCompound(10), isTrue);
    expect(KnowledgePack.isValidCompound(54), isTrue);
    expect(KnowledgePack.isValidCompound(55), isFalse);
  });

  test('every root 1-9 has a meaning', () {
    for (var n = 1; n <= 9; n++) {
      expect(KnowledgePack.roots[n], isNotNull);
    }
  });

  test('every compound 10-54 has its own entry', () {
    for (var n = 10; n <= 54; n++) {
      final entry = KnowledgePack.compoundNumbers[n];
      expect(entry, isNotNull, reason: 'missing $n');
      expect(entry!.number, n);
    }
    expect(KnowledgePack.compoundNumbers.length, 45);
  });

  test('no placeholder or copied-from-another-number text', () {
    final banned = [
      'same essential interpretation',
      'coming soon',
      'foundation ready',
      'interpretation pending',
    ];
    for (final entry in KnowledgePack.compoundNumbers.values) {
      final text = [
        entry.title,
        entry.summary,
        entry.strengths,
        entry.cautions,
        entry.relationships,
        entry.work,
        entry.money,
        entry.advice,
      ].join(' ').toLowerCase();
      for (final phrase in banned) {
        expect(text.contains(phrase), isFalse,
            reason: '${entry.number} contains "$phrase"');
      }
    }
  });

  test('every field is filled and summaries are unique', () {
    final summaries = <String>{};
    for (final entry in KnowledgePack.compoundNumbers.values) {
      expect(entry.title.trim().length, greaterThan(3),
          reason: 'short title in ${entry.number}');
      for (final field in [
        entry.summary,
        entry.strengths,
        entry.cautions,
        entry.relationships,
        entry.work,
        entry.money,
        entry.advice,
      ]) {
        expect(field.trim().length, greaterThan(15),
            reason: 'short field in ${entry.number}');
      }
      expect(summaries.add(entry.summary), isTrue,
          reason: 'duplicate summary at ${entry.number}');
    }
  });

  test('titles are unique', () {
    final titles = KnowledgePack.compoundNumbers.values.map((e) => e.title);
    expect(titles.toSet().length, titles.length);
  });

  test('entries 10-31 are traditional, 32-54 are editorial guidance', () {
    for (var n = 10; n <= 54; n++) {
      final status = KnowledgePack.compoundNumbers[n]!.status;
      expect(
        status,
        n <= 31
            ? EditorialStatus.traditionalParaphrase
            : EditorialStatus.editorialGuidance,
        reason: 'status of $n',
      );
    }
  });

  test('out-of-range totals get an explanation, not a clamped entry', () {
    expect(KnowledgePack.compoundEntry(9), isNull);
    expect(KnowledgePack.compoundEntry(55), isNull);
    expect(KnowledgePack.compoundMeaning(103), contains('outside'));
  });

  test('compoundMeaning returns the entry summary inside the range', () {
    expect(KnowledgePack.compoundMeaning(19),
        KnowledgePack.compoundNumbers[19]!.summary);
  });
}
