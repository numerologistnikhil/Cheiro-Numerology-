import 'root_profiles.dart' show L;

/// What Cheiro's own "Book of Numbers" says about each compound number,
/// summarised in our own words (not copied). It is shown next to the
/// app's explanation so a reader can see the original verdict.
enum CheiroVerdict { fortunate, mixed, unfortunate }

class CheiroSource {
  /// Cheiro's verdict for compound numbers 10 to 31.
  static const Map<int, CheiroVerdict> base = {
    10: CheiroVerdict.fortunate,
    11: CheiroVerdict.unfortunate,
    12: CheiroVerdict.unfortunate,
    13: CheiroVerdict.mixed,
    14: CheiroVerdict.mixed,
    15: CheiroVerdict.fortunate,
    16: CheiroVerdict.unfortunate,
    17: CheiroVerdict.fortunate,
    18: CheiroVerdict.unfortunate,
    19: CheiroVerdict.fortunate,
    20: CheiroVerdict.mixed,
    21: CheiroVerdict.fortunate,
    22: CheiroVerdict.unfortunate,
    23: CheiroVerdict.fortunate,
    24: CheiroVerdict.fortunate,
    25: CheiroVerdict.mixed,
    26: CheiroVerdict.unfortunate,
    27: CheiroVerdict.fortunate,
    28: CheiroVerdict.unfortunate,
    29: CheiroVerdict.unfortunate,
    30: CheiroVerdict.mixed,
    31: CheiroVerdict.unfortunate,
    // Numbers above 31 with their own description in the book:
    32: CheiroVerdict.fortunate, // if you trust your own judgement
    37: CheiroVerdict.fortunate, // good friendships and partnerships
    43: CheiroVerdict.unfortunate, // upheaval and strife
    50: CheiroVerdict.fortunate, // advance, but with enemies and danger
  };

  /// For numbers above 31 Cheiro says "read it like this lower number".
  static const Map<int, int> sameAs = {
    33: 24,
    34: 25,
    35: 26,
    36: 27,
    38: 29,
    39: 30,
    40: 31,
    41: 32,
    42: 24,
    44: 26,
    45: 27,
    46: 37,
    47: 29,
    48: 30,
    49: 31,
    52: 43,
  };

  static CheiroVerdict? verdict(int total) {
    final s = sameAs[total];
    return base[s ?? total];
  }

  static L _word(CheiroVerdict v) {
    switch (v) {
      case CheiroVerdict.fortunate:
        return const L('fortunate', 'शुभ');
      case CheiroVerdict.mixed:
        return const L('mixed (depends on the person)', 'मिला-जुला (व्यक्ति पर निर्भर)');
      case CheiroVerdict.unfortunate:
        return const L('a warning number', 'सावधानी का अंक');
    }
  }

  /// One short line for the app and the report. Null if the book gives
  /// nothing for this number.
  static L? note(int total) {
    final v = verdict(total);
    if (v == null) return null;
    final w = _word(v);
    final s = sameAs[total];
    if (s != null) {
      return L(
        'In Cheiro\'s own book, $total is read like $s, and he treats it as ${w.en}.',
        'कीरो की अपनी किताब में $total को $s की तरह पढ़ा जाता है, और वे इसे ${w.hi} मानते हैं।',
      );
    }
    return L(
      'In Cheiro\'s own book, $total is treated as ${w.en}.',
      'कीरो की अपनी किताब में $total को ${w.hi} माना गया है।',
    );
  }
}
