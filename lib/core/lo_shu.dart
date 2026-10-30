import 'numerology_engine.dart';

/// Lo Shu grid maths. Pure numbers only, no screen code.
///
/// The grid holds the non-zero digits of the birth date (day, month, year)
/// plus the psychic and destiny numbers.
class LoShu {
  /// How the nine numbers sit in the grid.
  static const List<List<int>> rows = [
    [4, 9, 2],
    [3, 5, 7],
    [8, 1, 6],
  ];

  /// The eight traditional named lines of the grid, in a fixed order:
  /// 0 mental, 1 emotional, 2 practical, 3 thought, 4 willpower,
  /// 5 action, 6 determination, 7 inner balance.
  static const List<List<int>> planes = [
    [4, 9, 2],
    [3, 5, 7],
    [8, 1, 6],
    [4, 3, 8],
    [9, 5, 1],
    [2, 7, 6],
    [4, 5, 6],
    [2, 5, 8],
  ];

  /// How many times each number 1-9 appears for [dob].
  static Map<int, int> counts(DateTime dob) {
    final birth = NumerologyEngine.birth(dob);
    final m = <int, int>{for (var i = 1; i <= 9; i++) i: 0};
    for (final ch in '${dob.day}${dob.month}${dob.year}'.split('')) {
      final v = int.parse(ch);
      if (v > 0) m[v] = m[v]! + 1;
    }
    for (final extra in [birth.psychic.root, birth.destiny.root]) {
      if (extra > 0) m[extra] = m[extra]! + 1;
    }
    return m;
  }

  /// Numbers 1-9 that do not appear at all.
  static List<int> missing(Map<int, int> c) => [
        for (var i = 1; i <= 9; i++)
          if ((c[i] ?? 0) == 0) i,
      ];

  /// Indexes (into [planes]) of lines where all three numbers are present.
  static List<int> completePlanes(Map<int, int> c) => [
        for (var i = 0; i < planes.length; i++)
          if (planes[i].every((n) => (c[n] ?? 0) > 0)) i,
      ];

  /// How many of the three numbers of line [i] are present (0 to 3).
  static int lineCount(Map<int, int> c, int i) =>
      planes[i].where((n) => (c[n] ?? 0) > 0).length;

  /// How many numbers of row [g] (0 top, 1 middle, 2 bottom) are present.
  static int rowCount(Map<int, int> c, int g) => lineCount(c, g);

  /// Row with clearly the most numbers (counting repeats), or -1 if the
  /// rows are about equal.
  static int dominantRow(Map<int, int> c) {
    final t = [
      for (final r in rows) r.fold<int>(0, (a, n) => a + (c[n] ?? 0)),
    ];
    var best = 0;
    for (var i = 1; i < 3; i++) {
      if (t[i] > t[best]) best = i;
    }
    final sorted = [...t]..sort();
    return sorted[2] - sorted[1] >= 2 ? best : -1;
  }

  /// Numbers that appear two or more times.
  static List<int> repeated(Map<int, int> c) => [
        for (var i = 1; i <= 9; i++)
          if ((c[i] ?? 0) >= 2) i,
      ];

  /// The digits taken from the date itself, before psychic/destiny are added.
  static String dateDigits(DateTime dob) => [
        for (final ch in '${dob.day}${dob.month}${dob.year}'.split(''))
          if (ch != '0') ch,
      ].join(' ');
}
