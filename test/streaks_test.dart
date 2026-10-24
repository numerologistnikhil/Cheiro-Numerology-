import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/streaks.dart';

void main() {
  test('next day adds one to the streak', () {
    final now = DateTime(2026, 10, 24, 9);
    expect(Streaks.nextCount('2026-10-23', 3, now), 4);
  });

  test('same day keeps the streak', () {
    final now = DateTime(2026, 10, 24, 20);
    expect(Streaks.nextCount('2026-10-24', 3, now), 3);
  });

  test('a missed day restarts the streak', () {
    final now = DateTime(2026, 10, 24);
    expect(Streaks.nextCount('2026-10-20', 5, now), 1);
  });

  test('first visit starts at one', () {
    expect(Streaks.nextCount(null, 0, DateTime(2026, 10, 24)), 1);
  });

  test('works across a month end', () {
    final now = DateTime(2026, 11, 1);
    expect(Streaks.nextCount('2026-10-31', 2, now), 3);
  });
}
