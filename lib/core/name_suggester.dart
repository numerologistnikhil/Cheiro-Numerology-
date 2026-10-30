import 'extra_insights.dart' show NameScore;
import 'name_texts.dart';
import 'numerology_engine.dart';
import 'numerology_tools.dart';
import 'root_profiles.dart';

/// One suggested spelling with everything needed to explain it.
class NameSuggestion {
  final String name;
  final int total;
  final int root;
  final NameScore score;
  final Relation? relMulank;
  final Relation? relBhagyank;
  final int edits;
  final List<String> changes;
  final int points;
  final bool better;

  const NameSuggestion({
    required this.name,
    required this.total,
    required this.root,
    required this.score,
    required this.relMulank,
    required this.relBhagyank,
    required this.edits,
    required this.changes,
    required this.points,
    required this.better,
  });
}

/// The result of looking at one name: the current spelling and the best
/// alternatives, best first.
class NameSuggestions {
  final String original;
  final int originalTotal;
  final int originalRoot;
  final NameScore originalScore;
  final Relation? originalRelMulank;
  final Relation? originalRelBhagyank;
  final int originalPoints;
  final int? mulank;
  final int? bhagyank;
  final List<NameSuggestion> items;

  const NameSuggestions({
    required this.original,
    required this.originalTotal,
    required this.originalRoot,
    required this.originalScore,
    required this.originalRelMulank,
    required this.originalRelBhagyank,
    required this.originalPoints,
    required this.mulank,
    required this.bhagyank,
    required this.items,
  });

  bool get anyBetter => items.any((s) => s.better);
}

/// Finds spellings of a name that sound the same but add up differently.
///
/// Pure Dart. Every spelling is judged the same way as the rest of the app:
/// Chaldean total, the traditional fortune of the compound number
/// ([NameScore]) and how the root sits with Mulank and Bhagyank.
class NameSuggester {
  static const int maxResults = 10;
  static const int _maxPerTotal = 3;

  /// A spelling this many points below the current one is not suggested.
  static const int similarMargin = 10;

  // Sound-preserving spelling swaps (from, to), applied one at a time.
  static const List<List<String>> _swaps = [
    ['ee', 'i'], ['i', 'ee'], ['oo', 'u'], ['u', 'oo'], ['aa', 'a'],
    ['a', 'aa'], ['ai', 'ay'], ['ay', 'ai'], ['ph', 'f'], ['f', 'ph'],
    ['k', 'c'], ['c', 'k'], ['v', 'w'], ['w', 'v'], ['y', 'i'],
    ['i', 'y'], ['ie', 'y'], ['y', 'ie'], ['ck', 'k'], ['ee', 'ea'],
  ];

  static const String _doubleable = 'nlmrtsdp';

  /// Returns null when the name has no English letters.
  static NameSuggestions? suggest(String name, {DateTime? dob}) {
    final clean = _tidy(name);
    if (clean.isEmpty) return null;
    final base = NumerologyEngine.name(clean);
    final baseScore = NameScore.of(clean);
    if (base.total == 0 || baseScore == null) return null;

    final birth = dob == null ? null : NumerologyEngine.birth(dob);
    final int? mulank = birth?.psychic.root;
    final int? bhagyank = birth?.destiny.root;

    final originalPoints =
        _points(baseScore, base.root, mulank, bhagyank, 0);
    final seen = <String>{clean.toLowerCase()};
    final pool = <NameSuggestion>[];

    void consider(String cand, int edits, List<String> changes) {
      final key = cand.toLowerCase();
      if (seen.contains(key)) return;
      if (_ugly(key)) return;
      seen.add(key);
      final r = NumerologyEngine.name(cand);
      final sc = NameScore.of(cand);
      if (r.total == 0 || sc == null) return;
      final pts = _points(sc, r.root, mulank, bhagyank, edits);
      pool.add(NameSuggestion(
        name: cand,
        total: r.total,
        root: r.root,
        score: sc,
        relMulank: mulank == null ? null : NumerologyTools.relation(r.root, mulank),
        relBhagyank:
            bhagyank == null ? null : NumerologyTools.relation(r.root, bhagyank),
        edits: edits,
        changes: changes,
        points: pts,
        better: pts > originalPoints,
      ));
    }

    // One edit.
    final words = clean.split(' ');
    for (var i = 0; i < words.length; i++) {
      for (final v in _wordVariants(words[i])) {
        final w = [...words]..[i] = v.key;
        consider(w.join(' '), 1, [v.value]);
      }
    }

    // Two edits: start from the best single edits only.
    final firstRound = [...pool]..sort((a, b) => b.points.compareTo(a.points));
    for (final s in firstRound.take(25)) {
      final ws = s.name.split(' ');
      for (var i = 0; i < ws.length; i++) {
        for (final v in _wordVariants(ws[i])) {
          final w = [...ws]..[i] = v.key;
          consider(w.join(' '), 2, [...s.changes, v.value]);
        }
      }
    }

    pool.sort((a, b) {
      final c = b.points.compareTo(a.points);
      if (c != 0) return c;
      final e = a.edits.compareTo(b.edits);
      if (e != 0) return e;
      return a.name.compareTo(b.name);
    });

    final picked = <NameSuggestion>[];
    // Never force a list: drop spellings that are clearly worse than now.
    pool.removeWhere((x) => x.points < originalPoints - similarMargin);
    final perTotal = <int, int>{};
    for (final s in pool) {
      final n = perTotal[s.total] ?? 0;
      if (n >= _maxPerTotal) continue;
      perTotal[s.total] = n + 1;
      picked.add(s);
      if (picked.length >= maxResults) break;
    }

    return NameSuggestions(
      original: clean,
      originalTotal: base.total,
      originalRoot: base.root,
      originalScore: baseScore,
      originalRelMulank:
          mulank == null ? null : NumerologyTools.relation(base.root, mulank),
      originalRelBhagyank: bhagyank == null
          ? null
          : NumerologyTools.relation(base.root, bhagyank),
      originalPoints: originalPoints,
      mulank: mulank,
      bhagyank: bhagyank,
      items: picked,
    );
  }

  // ------------------------------------------------------------- helpers

  /// Keeps letters and single spaces, each word as Capitalised.
  static String _tidy(String s) {
    final words = s
        .replaceAll(RegExp(r'[^A-Za-z ]'), ' ')
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .toList();
    return words.join(' ');
  }

  static bool _ugly(String s) {
    if (RegExp(r'(.)\1\1').hasMatch(s)) return true;
    if (RegExp(r'[^aeiou ]{5,}').hasMatch(s)) return true;
    return false;
  }

  static int _points(
      NameScore sc, int root, int? mulank, int? bhagyank, int edits) {
    final pm = mulank == null
        ? 1
        : NumerologyTools.points(NumerologyTools.relation(root, mulank));
    final pb = bhagyank == null
        ? 1
        : NumerologyTools.points(NumerologyTools.relation(root, bhagyank));
    return sc.luck + sc.wealth + 15 * (pm + pb) - 6 * edits;
  }

  /// Sound-keeping one-step variants of a single word, with a short label.
  static List<MapEntry<String, String>> _wordVariants(String word) {
    final out = <MapEntry<String, String>>[];
    if (word.length < 2) return out;
    final w = word.toLowerCase();
    String cap(String x) => x[0].toUpperCase() + x.substring(1);

    for (final sw in _swaps) {
      var from = 0;
      while (true) {
        final i = w.indexOf(sw[0], from);
        if (i < 0) break;
        from = i + 1;
        // Do not change the first letter.
        if (i == 0) continue;
        // 'k' -> 'c' changes the sound before e, i or y (Ken -> Cen).
        if (sw[0] == 'k' && sw[1] == 'c' && i + 1 < w.length && 'eiy'.contains(w[i + 1])) {
          continue;
        }
        final v = w.substring(0, i) + sw[1] + w.substring(i + sw[0].length);
        out.add(MapEntry(cap(v), '${sw[0]} -> ${sw[1]}'));
      }
    }
    for (var i = 1; i < w.length; i++) {
      final ch = w[i];
      if (_doubleable.contains(ch) && w[i - 1] != ch &&
          (i + 1 >= w.length || w[i + 1] != ch)) {
        out.add(MapEntry(cap(w.substring(0, i) + ch + w.substring(i)), '+$ch'));
      }
      if (i + 1 < w.length && w[i] == w[i + 1] && !'aeiou'.contains(ch)) {
        out.add(MapEntry(cap(w.substring(0, i) + w.substring(i + 1)), '-$ch'));
      }
    }
    if (w.length >= 3 && w.endsWith('a')) {
      out.add(MapEntry(cap('${w}h'), '+h'));
    }
    return out;
  }

  // ------------------------------------------------------------ text help

  static String relWord(Relation r, bool hi) {
    switch (r) {
      case Relation.friend:
        return NameTexts.friendly.t(hi);
      case Relation.neutral:
        return NameTexts.neutral.t(hi);
      case Relation.enemy:
        return NameTexts.challenging.t(hi);
    }
  }

  /// One line with the Ankdhara Numerology Compatibility Score.
  static String scoreLine(int points, bool hi) => hi
      ? '${NameTexts.score.t(true)}: $points अंक'
      : '${NameTexts.score.t(false)}: $points points';

  /// A short plain-language explanation of one suggestion.
  static String explain(NameSuggestions all, NameSuggestion s, bool hi) {
    final b = StringBuffer();
    if (hi) {
      b.write('मौजूदा: ${all.original}  ->  सुझाई गई: ${s.name}। ');
      b.write('जोड़ ${s.total} है, जो घटकर ${s.root} बनता है।');
      if (s.relMulank != null && s.relBhagyank != null) {
        b.write(
            ' आपके मूलांक ${all.mulank} के साथ यह ${relWord(s.relMulank!, true)} है और भाग्यांक ${all.bhagyank} के साथ ${relWord(s.relBhagyank!, true)}।');
      }
      b.write(
          ' संयुक्त अंक की परंपरागत व्याख्या: ${s.score.label.of(true)}। ${scoreLine(s.points, true)}।');
    } else {
      b.write('Current: ${all.original}  ->  Suggested: ${s.name}. ');
      b.write('The total is ${s.total}, which reduces to ${s.root}.');
      if (s.relMulank != null && s.relBhagyank != null) {
        b.write(
            ' With your Mulank ${all.mulank} it is ${relWord(s.relMulank!, false)}, and with your Bhagyank ${all.bhagyank} it is ${relWord(s.relBhagyank!, false)}.');
      }
      b.write(
          ' Traditional reading of the compound number: ${s.score.label.of(false)}. ${scoreLine(s.points, false)}.');
    }
    b.write('\n${reason(all, s, hi)}');
    return b.toString();
  }

  /// Why this spelling sits where it does, compared with the current one.
  static String reason(NameSuggestions all, NameSuggestion s, bool hi) {
    final parts = <String>[];
    final dLuck = s.score.luck - all.originalScore.luck;
    final dWealth = s.score.wealth - all.originalScore.wealth;
    if (dLuck > 0 || dWealth > 0) {
      parts.add(hi
          ? 'इसके संयुक्त अंक की परंपरागत व्याख्या मौजूदा से बेहतर है'
          : 'its compound number reads better in the tradition than your current one');
    } else if (dLuck < 0 || dWealth < 0) {
      parts.add(hi
          ? 'इसके संयुक्त अंक की परंपरागत व्याख्या मौजूदा से हल्की है'
          : 'its compound number reads lighter in the tradition than your current one');
    }
    if (s.relMulank != null && all.originalRelMulank != null) {
      final d = NumerologyTools.points(s.relMulank!) -
          NumerologyTools.points(all.originalRelMulank!);
      if (d > 0) {
        parts.add(hi ? 'यह आपके मूलांक के साथ ज़्यादा मेल खाता है' : 'it fits your Mulank better');
      } else if (d < 0) {
        parts.add(hi ? 'यह आपके मूलांक के साथ कम मेल खाता है' : 'it fits your Mulank less');
      }
    }
    if (s.relBhagyank != null && all.originalRelBhagyank != null) {
      final d = NumerologyTools.points(s.relBhagyank!) -
          NumerologyTools.points(all.originalRelBhagyank!);
      if (d > 0) {
        parts.add(hi ? 'यह आपके भाग्यांक के साथ ज़्यादा मेल खाता है' : 'it fits your Bhagyank better');
      } else if (d < 0) {
        parts.add(hi ? 'यह आपके भाग्यांक के साथ कम मेल खाता है' : 'it fits your Bhagyank less');
      }
    }
    parts.add(hi
        ? '${s.edits} बदलाव करने पड़े'
        : '${s.edits} spelling ${s.edits == 1 ? 'change' : 'changes'} needed');
    final head = hi ? 'इस क्रम का कारण: ' : 'Why it is ranked here: ';
    return '$head${parts.join(hi ? '; ' : '; ')}.';
  }

  /// Detail rows for one suggestion (same for the app and the PDF).
  static List<MapEntry<String, String>> details(
      NameSuggestion s, bool hi, {bool withCompound = true}) {
    final rows = <MapEntry<String, String>>[
      MapEntry(NameTexts.changes.t(hi), s.changes.join(', ')),
    ];
    final pp = RootProfiles.of(s.root);
    if (pp != null) {
      rows.add(MapEntry(NameTexts.strengthsL.t(hi), pp.strengths.t(hi)));
      rows.add(MapEntry(NameTexts.carefulL.t(hi), pp.challenges.t(hi)));
      rows.add(MapEntry(NameTexts.workL.t(hi), pp.career.t(hi)));
      rows.add(MapEntry(NameTexts.moneyL.t(hi), pp.money.t(hi)));
      rows.add(MapEntry(NameTexts.adviceL.t(hi), pp.advice.t(hi)));
    }
    return rows;
  }
}
