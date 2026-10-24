import 'package:shared_preferences/shared_preferences.dart';

/// What the app knows about how often the person uses it.
class StreakInfo {
  /// Days in a row up to today.
  final int current;

  /// Longest run of days in a row so far.
  final int best;

  /// Number of different days the app was opened.
  final int totalDays;

  /// Feature keys the person has opened at least once.
  final Set<String> visited;

  const StreakInfo(this.current, this.best, this.totalDays, this.visited);
}

/// Daily streak and visited-feature tracking, stored on the phone only.
class Streaks {
  static const String _kLast = 'streak_last';
  static const String _kCount = 'streak_count';
  static const String _kBest = 'streak_best';
  static const String _kTotal = 'streak_total';
  static const String _kVisited = 'streak_visited';

  static String dayKey(DateTime d) => '${d.year}-${d.month}-${d.day}';

  /// Streak length after opening the app on [now].
  /// [last] is the day key of the previous visit (null if none).
  static int nextCount(String? last, int count, DateTime now) {
    final today = dayKey(now);
    if (last == today) return count;
    final yesterday = dayKey(DateTime(now.year, now.month, now.day - 1));
    return last == yesterday ? count + 1 : 1;
  }

  static StreakInfo _read(SharedPreferences p) {
    return StreakInfo(
      p.getInt(_kCount) ?? 0,
      p.getInt(_kBest) ?? 0,
      p.getInt(_kTotal) ?? 0,
      (p.getStringList(_kVisited) ?? const <String>[]).toSet(),
    );
  }

  /// Reads the saved numbers without changing anything.
  static Future<StreakInfo> load() async {
    try {
      final p = await SharedPreferences.getInstance();
      return _read(p);
    } catch (_) {
      return const StreakInfo(0, 0, 0, {});
    }
  }

  /// Call once when the app opens. Counts today and returns the new numbers.
  static Future<StreakInfo> touch() async {
    try {
      final p = await SharedPreferences.getInstance();
      final now = DateTime.now();
      final today = dayKey(now);
      final last = p.getString(_kLast);
      if (last != today) {
        final count = nextCount(last, p.getInt(_kCount) ?? 0, now);
        final best = p.getInt(_kBest) ?? 0;
        final total = (p.getInt(_kTotal) ?? 0) + 1;
        await p.setString(_kLast, today);
        await p.setInt(_kCount, count);
        await p.setInt(_kBest, count > best ? count : best);
        await p.setInt(_kTotal, total);
      }
      return _read(p);
    } catch (_) {
      return const StreakInfo(0, 0, 0, {});
    }
  }

  /// Remembers that a feature was opened.
  static Future<void> visit(String key) async {
    try {
      final p = await SharedPreferences.getInstance();
      final list = p.getStringList(_kVisited) ?? <String>[];
      if (!list.contains(key)) {
        await p.setStringList(_kVisited, [...list, key]);
      }
    } catch (_) {
      // Tracking is optional.
    }
  }
}
