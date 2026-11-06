import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/cheiro_timing.dart';

void main() {
  final dob = DateTime(1988, 4, 6); // Mulank 6, Bhagyank 9

  test('year total adds every digit of day, month and year', () {
    expect(CheiroTiming.yearTotal(dob, 2026), 6 + 4 + 2 + 0 + 2 + 6);
    final y = CheiroTiming.year(dob, 2026, 6, 9);
    expect(y.total, 20);
    expect(y.root, 2);
    expect(y.steps, '6 + 4 + 2+0+2+6 = 20');
    expect(y.entry, isNotNull);
  });

  test('month and day build on the year total', () {
    final m = CheiroTiming.month(dob, 2026, 11, 6, 9); // 20 + 1+1 = 22
    expect(m.total, 22);
    expect(m.root, 4);
    final d = CheiroTiming.day(dob, DateTime(2026, 11, 6), 6, 9); // 22 + 6 = 28
    expect(d.total, 28);
    expect(d.root, 1);
  });

  test('day 29 of month 12 uses digit sums', () {
    final d = CheiroTiming.day(dob, DateTime(2026, 12, 29), 6, 9);
    // year 20, month +1+2 = 23, day +2+9 = 34
    expect(d.total, 34);
  });

  test('mood follows friend and enemy relations', () {
    // 8 against Mulank 1 and Bhagyank 8 is mixed or same number; 8 vs 1 is opposed
    expect(CheiroTiming.mood(8, 1, 1), TimingMood.careful);
    expect(CheiroTiming.mood(3, 1, 9), TimingMood.favourable);
  });

  test('heavy total is flagged', () {
    // find a date whose day total is 35
    var found = false;
    for (var i = 0; i < 366 && !found; i++) {
      final dt = DateTime(2026, 1, 1).add(Duration(days: i));
      final p = CheiroTiming.day(dob, dt, 6, 9);
      if (p.total == 35) {
        expect(p.heavy, isTrue);
        found = true;
      }
    }
    expect(found, isTrue);
  });

  test('every root has tone and moods have text', () {
    for (var r = 1; r <= 9; r++) {
      expect(CheiroTiming.rootTone[r]!.hi.isNotEmpty, isTrue);
    }
    for (final m in TimingMood.values) {
      expect(CheiroTiming.moodName[m]!.en.isNotEmpty, isTrue);
      expect(CheiroTiming.moodLine[m]!.hi.isNotEmpty, isTrue);
    }
  });
}
