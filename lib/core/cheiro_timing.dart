import 'heavy_numbers.dart';
import 'knowledge_pack.dart';
import 'numerology_tools.dart';
import 'root_profiles.dart' show L;

/// Mood of a period, worked out from how its number sits with the person's
/// Mulank and Bhagyank.
enum TimingMood { favourable, steady, careful }

/// One year, month or day with every step of its calculation.
class TimingPeriod {
  final String steps; // e.g. "6 + 4 + 2+0+2+6 = 20"
  final int total; // compound total
  final int root; // single digit
  final TimingMood mood;
  final bool heavy;
  final CompoundEntry? entry;
  const TimingPeriod(this.steps, this.total, this.root, this.mood, this.heavy, this.entry);
}

/// Cheiro-style timing. The year number follows Cheiro: all digits of the
/// birth day, birth month and the year are added. The month and day numbers
/// extend the same idea (year total + month digits, month total + day digits)
/// as many numerologists do. The arithmetic is exact and repeatable. What a
/// number means is traditional interpretation, not a certain prediction.
class CheiroTiming {
  static int digitSum(int n) {
    var s = 0;
    var x = n.abs();
    while (x > 0) {
      s += x % 10;
      x ~/= 10;
    }
    return s;
  }

  static int root(int n) {
    var x = n;
    while (x > 9) {
      x = digitSum(x);
    }
    return x;
  }

  static String _digits(int n) => n.toString().split('').join('+');

  static TimingMood mood(int periodRoot, int mulank, int bhagyank) {
    final a = NumerologyTools.relation(periodRoot, mulank);
    final b = NumerologyTools.relation(periodRoot, bhagyank);
    if (a == Relation.enemy && b == Relation.enemy) return TimingMood.careful;
    if (a == Relation.enemy || b == Relation.enemy) {
      return (a == Relation.friend || b == Relation.friend) ? TimingMood.steady : TimingMood.careful;
    }
    if (a == Relation.friend || b == Relation.friend || periodRoot == mulank || periodRoot == bhagyank) {
      return TimingMood.favourable;
    }
    return TimingMood.steady;
  }

  static TimingPeriod _make(String steps, int total, int mulank, int bhagyank) {
    final r = root(total);
    return TimingPeriod(
      steps,
      total,
      r,
      mood(r, mulank, bhagyank),
      HeavyNumbers.isHeavy(total),
      KnowledgePack.compoundEntry(total),
    );
  }

  static int yearTotal(DateTime dob, int year) =>
      digitSum(dob.day) + digitSum(dob.month) + digitSum(year);

  static TimingPeriod year(DateTime dob, int year, int mulank, int bhagyank) {
    final t = yearTotal(dob, year);
    final steps = '${_digits(dob.day)} + ${_digits(dob.month)} + ${_digits(year)} = $t';
    return _make(steps, t, mulank, bhagyank);
  }

  static TimingPeriod month(DateTime dob, int year, int month, int mulank, int bhagyank) {
    final y = yearTotal(dob, year);
    final t = y + digitSum(month);
    return _make('$y + ${_digits(month)} = $t', t, mulank, bhagyank);
  }

  static TimingPeriod day(DateTime dob, DateTime date, int mulank, int bhagyank) {
    final m = yearTotal(dob, date.year) + digitSum(date.month);
    final t = m + digitSum(date.day);
    return _make('$m + ${_digits(date.day)} = $t', t, mulank, bhagyank);
  }

  // ---------------------------------------------------------------- texts
  static const L title = L('Cheiro Timing', 'कीरो टाइमिंग');
  static const L intro = L(
    'This page works out your year, month and day numbers the Cheiro way and shows every step of the sum, so you can check it yourself. '
    'The calculation is exact and repeatable. What a number means is traditional interpretation: it shows the tone of a period and where to be careful or bold. '
    'It does not promise that a particular event will happen on a particular day. Use it to plan, not to fear.',
    'यह पन्ना आपके वर्ष, महीने और दिन के अंक कीरो की विधि से निकालता है और जोड़ का हर चरण दिखाता है, ताकि आप खुद जाँच सकें। '
    'गणना सटीक और दोहराने योग्य है। अंक का अर्थ पारंपरिक व्याख्या है: वह किसी समय का स्वर बताता है और कहाँ सावधान या साहसी रहना है। '
    'यह वादा नहीं करता कि किसी ख़ास दिन कोई ख़ास घटना होगी। योजना बनाने के लिए इस्तेमाल करें, डरने के लिए नहीं।');
  static const L method = L('How it is worked out', 'यह कैसे निकलता है');
  static const L methodBody = L(
    'Year number: add every digit of your birth day, birth month and the year. Month number: year total plus the digits of the month. Day number: month total plus the digits of the day. '
    'If the total is between 10 and 52, the compound number has its own meaning. The single digit it reduces to shows the planet-like tone.',
    'वर्ष अंक: जन्म के दिन, जन्म के महीने और वर्ष के सभी अंक जोड़ें। महीने का अंक: वर्ष का जोड़ + महीने के अंक। दिन का अंक: महीने का जोड़ + दिन के अंक। '
    'जोड़ 10 से 52 के बीच हो तो संयुक्त अंक का अपना अर्थ है। जिस एक अंक पर वह घटता है वह ग्रह जैसा स्वर बताता है।');
  static const L pickYear = L('Year', 'वर्ष');
  static const L yearHead = L('Your year number', 'आपका वर्ष अंक');
  static const L monthsHead = L('Month by month', 'महीने दर महीने');
  static const L daysHead = L('Next 30 days', 'अगले 30 दिन');
  static const L bestDays = L('Best days to start important work', 'ज़रूरी काम शुरू करने के सबसे अच्छे दिन');
  static const L careDays = L('Days to go slowly', 'धीरे चलने वाले दिन');
  static const L tone = L('Tone of this period', 'इस समय का स्वर');
  static const L compoundHead = L('Compound number meaning', 'संयुक्त अंक का अर्थ');
  static const L englishNote = L('(compound texts are in English)', '(संयुक्त अंक के पाठ अंग्रेज़ी में हैं)');
  static const L heavyNote = L('This total is on the heavy-number list, so go slowly and plan extra effort.', 'यह जोड़ भारी अंकों की सूची में है, इसलिए धीरे चलें और अतिरिक्त मेहनत की योजना बनाएँ।');
  static const L cautions = L('Take care of', 'ध्यान रखें');
  static const L advice = L('Advice', 'सलाह');
  static const L closing = L(
    'A number is one lens. Money, health, people and your own effort also decide how a period goes. For big decisions, take professional advice as well.',
    'अंक एक नज़रिया है। पैसा, सेहत, लोग और आपकी अपनी मेहनत भी तय करते हैं कि समय कैसा जाएगा। बड़े फ़ैसलों में पेशेवर सलाह भी लें।');

  static const Map<TimingMood, L> moodName = {
    TimingMood.favourable: L('Favourable', 'अनुकूल'),
    TimingMood.steady: L('Steady', 'सामान्य'),
    TimingMood.careful: L('Go carefully', 'सावधानी से'),
  };

  static const Map<TimingMood, L> moodLine = {
    TimingMood.favourable: L('The number is friendly with your Mulank or Bhagyank. A good time to start, ask and push forward.', 'यह अंक आपके मूलांक या भाग्यांक का मित्र है। शुरुआत करने, माँगने और आगे बढ़ने का अच्छा समय।'),
    TimingMood.steady: L('Neither helped nor opposed. Results come from steady effort, so keep to your plan.', 'न मदद, न विरोध। नतीजे लगातार मेहनत से आते हैं, इसलिए योजना पर टिके रहें।'),
    TimingMood.careful: L('The number clashes with your own numbers. Avoid rushing big moves, double-check papers and money, and be patient with people.', 'यह अंक आपके अपने अंकों से टकराता है। बड़े कदमों में जल्दबाज़ी न करें, कागज़ और पैसे दोबारा जाँचें, और लोगों के साथ धैर्य रखें।'),
  };

  /// Tone of each root as a period (1 to 9).
  static const Map<int, L> rootTone = {
    1: L('A period of new starts, leadership and being noticed.', 'नई शुरुआत, नेतृत्व और ध्यान में आने का समय।'),
    2: L('A period of patience, partnership and gentle progress.', 'धैर्य, साझेदारी और धीमी प्रगति का समय।'),
    3: L('A period of learning, advice, growth and good company.', 'सीखने, सलाह, बढ़त और अच्छी संगति का समय।'),
    4: L('A period of hard work, building and unusual turns. Keep records clean.', 'मेहनत, निर्माण और अप्रत्याशित मोड़ का समय। हिसाब साफ़ रखें।'),
    5: L('A period of movement, deals, travel and quick decisions.', 'हलचल, सौदे, यात्रा और तेज़ फ़ैसलों का समय।'),
    6: L('A period of family, comfort, love and creative work.', 'परिवार, सुख, प्रेम और रचनात्मक काम का समय।'),
    7: L('A period of study, rest and inner work. Do not force results.', 'अध्ययन, विश्राम और भीतरी काम का समय। नतीजों को ज़बरदस्ती न खींचें।'),
    8: L('A period of effort, responsibility and slow but solid results.', 'मेहनत, ज़िम्मेदारी और धीमे पर ठोस नतीजों का समय।'),
    9: L('A period of energy, courage and finishing what is pending.', 'ऊर्जा, साहस और अधूरे काम पूरे करने का समय।'),
  };
}
