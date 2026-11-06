import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/famous_people.dart';
import 'package:cheiro_numerology/core/numerology_engine.dart';

void main() {
  test('100 famous people with valid dates and categories', () {
    expect(FamousPeople.people.length, 100);
    final names = <String>{};
    for (final p in FamousPeople.people) {
      expect(names.add(p.name), isTrue, reason: p.name);
      expect(p.category >= 0 && p.category < FamousPeople.categories.length, isTrue);
      final d = p.dob;
      expect(d.year, p.year);
      expect(d.month, p.month);
      expect(d.day, p.day);
      expect(NumerologyEngine.name(p.name).total > 0, isTrue, reason: p.name);
      final b = NumerologyEngine.birth(d);
      expect(b.psychic.root >= 1 && b.psychic.root <= 9, isTrue);
    }
  });
}
