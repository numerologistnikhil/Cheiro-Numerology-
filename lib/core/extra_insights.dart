// Ank Dhara - extra insights (pure Dart, no packages needed).
// 1) NumberPatterns: pattern check for mobile / vehicle numbers
// 2) TimeEnergy:     small message for special times (11:11, 22:22 ...)
// 3) NameScore:      simple wealth + luck guide for a name / business name
//
// Every text has English (en) and Hindi (hi). Use .of(isHindi) to pick one.

class Bi {
  final String en;
  final String hi;
  const Bi(this.en, this.hi);
  String of(bool hindi) => hindi ? hi : en;
}

int _digitSum(int n) {
  var s = 0;
  var x = n;
  while (x > 0) {
    s += x % 10;
    x ~/= 10;
  }
  return s;
}

/// Reduces a number to a single digit (1-9). 0 stays 0.
int digitRoot(int n) {
  var x = n;
  while (x > 9) {
    x = _digitSum(x);
  }
  return x;
}

const Map<int, Bi> rootQuality = {
  1: Bi('leadership and new beginnings', 'नेतृत्व और नई शुरुआत'),
  2: Bi('peace and partnership', 'शांति और साथ'),
  3: Bi('wisdom and growth', 'ज्ञान और तरक्की'),
  4: Bi('hard work and an unusual path', 'मेहनत और अलग राह'),
  5: Bi('communication and quick gains', 'बातचीत और तेज़ फ़ायदा'),
  6: Bi('love, comfort and luxury', 'प्यार, आराम और सुख'),
  7: Bi('inner peace and spirituality', 'मन की शांति और अध्यात्म'),
  8: Bi('discipline, patience and karma', 'अनुशासन, सब्र और कर्म'),
  9: Bi('courage and energy', 'हिम्मत और जोश'),
};

Bi _digitQuality(String d) {
  final n = int.tryParse(d) ?? 0;
  if (n == 0) {
    return const Bi('silence and a fresh start', 'ठहराव और नई शुरुआत');
  }
  return rootQuality[n]!;
}

// ---------------------------------------------------------------------------
// 1) NUMBER PATTERNS
// ---------------------------------------------------------------------------

class PatternFinding {
  final String id; // repeat, ascending, descending, palindrome, alternating, dominant
  final Bi title;
  final Bi message;
  const PatternFinding(this.id, this.title, this.message);
}

class PatternReport {
  final String digits;
  final int total; // sum of all digits
  final int root; // total reduced to 1-9 (0 if empty)
  final List<PatternFinding> findings;
  final Bi summary;
  const PatternReport({
    required this.digits,
    required this.total,
    required this.root,
    required this.findings,
    required this.summary,
  });

  bool get isSpecial => findings.isNotEmpty;
}

class NumberPatterns {
  /// Works for a mobile number, vehicle number or any text with digits.
  /// Non-digit characters are ignored.
  static PatternReport analyze(String input) {
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const PatternReport(
        digits: '',
        total: 0,
        root: 0,
        findings: [],
        summary: Bi('Please enter a number.', 'कृपया नंबर डालें।'),
      );
    }

    var total = 0;
    for (var i = 0; i < digits.length; i++) {
      total += digits.codeUnitAt(i) - 48;
    }
    final root = digitRoot(total);
    final findings = <PatternFinding>[];

    // Repeating run (777, 5555 ...)
    var run = 1;
    var bestRun = 1;
    var runDigit = digits[0];
    for (var i = 1; i < digits.length; i++) {
      if (digits[i] == digits[i - 1]) {
        run++;
        if (run > bestRun) {
          bestRun = run;
          runDigit = digits[i];
        }
      } else {
        run = 1;
      }
    }
    if (bestRun >= 3) {
      final q = _digitQuality(runDigit);
      findings.add(PatternFinding(
        'repeat',
        Bi('Repeating digit $runDigit', 'अंक $runDigit बार-बार'),
        Bi(
          'The digit $runDigit comes $bestRun times in a row. This makes its energy very strong: ${q.en}.',
          'अंक $runDigit लगातार $bestRun बार आया है। इससे इसकी ऊर्जा बहुत तेज़ हो जाती है: ${q.hi}।',
        ),
      ));
    }

    // Rising / falling chains (123, 654 ...)
    var up = 1;
    var bestUp = 1;
    var down = 1;
    var bestDown = 1;
    for (var i = 1; i < digits.length; i++) {
      final d = digits.codeUnitAt(i) - digits.codeUnitAt(i - 1);
      if (d == 1) {
        up++;
        if (up > bestUp) bestUp = up;
      } else {
        up = 1;
      }
      if (d == -1) {
        down++;
        if (down > bestDown) bestDown = down;
      } else {
        down = 1;
      }
    }
    if (bestUp >= 3) {
      findings.add(PatternFinding(
        'ascending',
        const Bi('Rising chain', 'बढ़ती कड़ी'),
        Bi(
          'A rising chain of $bestUp digits (like 123). It shows steady growth, step by step.',
          '$bestUp अंकों की बढ़ती कड़ी (जैसे 123)। यह कदम-दर-कदम तरक्की दिखाती है।',
        ),
      ));
    }
    if (bestDown >= 3) {
      findings.add(PatternFinding(
        'descending',
        const Bi('Falling chain', 'घटती कड़ी'),
        Bi(
          'A falling chain of $bestDown digits (like 321). It shows letting go and slowing down: good for calm, less for fast growth.',
          '$bestDown अंकों की घटती कड़ी (जैसे 321)। यह छोड़ने और ठहराव का संकेत है: शांति के लिए अच्छा, तेज़ तरक्की के लिए कम।',
        ),
      ));
    }

    // Mirror number (4554, 12321 ...)
    if (digits.length >= 4 && digits == digits.split('').reversed.join()) {
      findings.add(const PatternFinding(
        'palindrome',
        Bi('Mirror number', 'शीशे जैसा नंबर'),
        Bi(
          'This number reads the same from both sides. It is seen as balance, and results that come back to you.',
          'यह नंबर दोनों तरफ़ से एक जैसा है। इसे संतुलन और लौटकर आने वाले फल का संकेत माना जाता है।',
        ),
      ));
    }

    // Alternating pattern (1212, 3434 ...)
    if (digits.length >= 4 && digits[0] != digits[1]) {
      var alt = true;
      for (var i = 2; i < digits.length; i++) {
        if (digits[i] != digits[i - 2]) {
          alt = false;
          break;
        }
      }
      if (alt) {
        findings.add(const PatternFinding(
          'alternating',
          Bi('Alternating pattern', 'बारी-बारी का पैटर्न'),
          Bi(
            'Two digits take turns (like 1212). It shows a steady rhythm and repeating cycles.',
            'दो अंक बारी-बारी से आते हैं (जैसे 1212)। यह तय लय और दोहराते चक्र दिखाता है।',
          ),
        ));
      }
    }

    // Dominant digit (one digit appears many times, not always in a row)
    final counts = List<int>.filled(10, 0);
    for (var i = 0; i < digits.length; i++) {
      counts[digits.codeUnitAt(i) - 48]++;
    }
    var domDigit = 0;
    for (var d = 1; d < 10; d++) {
      if (counts[d] > counts[domDigit]) domDigit = d;
    }
    final need = digits.length >= 8 ? 5 : 3;
    final alreadyRun = findings.any((f) => f.id == 'repeat') && runDigit == '$domDigit';
    if (counts[domDigit] >= need && !alreadyRun) {
      final q = _digitQuality('$domDigit');
      findings.add(PatternFinding(
        'dominant',
        Bi('Strong digit $domDigit', 'ताकतवर अंक $domDigit'),
        Bi(
          'The digit $domDigit appears ${counts[domDigit]} times, so its qualities lead this number: ${q.en}.',
          'अंक $domDigit ${counts[domDigit]} बार आया है, इसलिए इस नंबर पर इसके गुण हावी रहते हैं: ${q.hi}।',
        ),
      ));
    }

    final rq = rootQuality[root] ?? _digitQuality('0');
    final summary = Bi(
      'Total $total, root number $root: ${rq.en}.',
      'कुल जोड़ $total, मूलांक $root: ${rq.hi}।',
    );

    return PatternReport(
      digits: digits,
      total: total,
      root: root,
      findings: findings,
      summary: summary,
    );
  }
}

// ---------------------------------------------------------------------------
// 2) TIME ENERGY
// ---------------------------------------------------------------------------

class TimeEnergy {
  static String _two(int n) => n.toString().padLeft(2, '0');

  static const Map<String, Bi> _special = {
    '1111': Bi(
      '11:11 - a moment of alignment. Make one clear wish in your mind.',
      '11:11 - तालमेल का पल। मन में एक साफ़ इच्छा रखो।',
    ),
    '2222': Bi(
      '22:22 - intention meets action. A good time to start building.',
      '22:22 - इरादा और कर्म मिलते हैं। काम शुरू करने का अच्छा समय।',
    ),
    '0000': Bi(
      '00:00 - a fresh start. The day has reset.',
      '00:00 - नई शुरुआत। दिन नया हो गया है।',
    ),
    '1234': Bi(
      '12:34 - step by step, things are moving forward.',
      '12:34 - कदम-दर-कदम सब आगे बढ़ रहा है।',
    ),
  };

  /// Returns a small message for special times, or null for ordinary times.
  static Bi? forTime(DateTime t) {
    final hh = t.hour;
    final mm = t.minute;
    final key = '${_two(hh)}${_two(mm)}';
    final s = _special[key];
    if (s != null) return s;
    if (hh == mm && hh > 0) {
      final r = digitRoot(hh);
      final q = rootQuality[r] ?? _digitQuality('0');
      final label = '${_two(hh)}:${_two(mm)}';
      return Bi(
        '$label - double time with number $r energy: ${q.en}.',
        '$label - दोहरा समय, अंक $r की ऊर्जा: ${q.hi}।',
      );
    }
    return null;
  }
}

// ---------------------------------------------------------------------------
// 3) NAME SCORE (simple guide)
// ---------------------------------------------------------------------------

class NameScore {
  final String name;
  final int compound; // 1-52 (long totals are reduced until they are 52 or less)
  final int root; // 1-9
  final int wealth; // 0-100
  final int luck; // 0-100
  final Bi label;
  const NameScore({
    required this.name,
    required this.compound,
    required this.root,
    required this.wealth,
    required this.luck,
    required this.label,
  });

  // Chaldean letter values (the same table Cheiro used).
  static const Map<String, int> _letters = {
    'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5, 'F': 8, 'G': 3, 'H': 5, 'I': 1,
    'J': 1, 'K': 2, 'L': 3, 'M': 4, 'N': 5, 'O': 7, 'P': 8, 'Q': 1, 'R': 2,
    'S': 3, 'T': 4, 'U': 6, 'V': 6, 'W': 6, 'X': 5, 'Y': 1, 'Z': 7,
  };

  // Simple tones, please cross-check with knowledge_pack.dart.
  static const Set<int> _fortunate = {10, 15, 17, 19, 21, 23, 24, 25, 27, 32};
  static const Set<int> _warning = {11, 16, 18, 22, 26, 29};

  static const Map<int, int> _rootWealth = {
    1: 75, 2: 60, 3: 80, 4: 55, 5: 80, 6: 75, 7: 55, 8: 60, 9: 70,
  };

  /// Returns null when the text has no English letters.
  static NameScore? of(String name) {
    var total = 0;
    final up = name.toUpperCase();
    for (var i = 0; i < up.length; i++) {
      total += _letters[up[i]] ?? 0;
    }
    if (total == 0) return null;

    var compound = total;
    while (compound > 52) {
      compound = _digitSum(compound);
    }
    final root = digitRoot(compound);

    var luck = 60;
    var wealth = _rootWealth[root] ?? 60;
    if (_fortunate.contains(compound)) {
      luck = 85;
      wealth += 5;
    } else if (_warning.contains(compound)) {
      luck = 35;
      wealth -= 10;
    }
    if (wealth > 100) wealth = 100;
    if (wealth < 10) wealth = 10;

    final avg = (wealth + luck) / 2;
    final Bi label;
    if (avg >= 75) {
      label = const Bi('Very favourable', 'बहुत शुभ');
    } else if (avg >= 55) {
      label = const Bi('Moderate', 'मध्यम');
    } else {
      label = const Bi('Needs care', 'सावधानी ज़रूरी');
    }

    return NameScore(
      name: name,
      compound: compound,
      root: root,
      wealth: wealth,
      luck: luck,
      label: label,
    );
  }
}
