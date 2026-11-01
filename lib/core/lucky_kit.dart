import 'numerology_engine.dart';
import 'numerology_tools.dart';
import 'root_profiles.dart' show L;

/// How well a house or flat number suits the owner.
enum HouseVerdict { good, mixed, careful }

/// Result for one house / flat number.
class HouseResult {
  final String input;
  final NumerologyResult number;
  final int psychic;
  final int destiny;
  final Relation withPsychic;
  final Relation withDestiny;
  final int score; // 0 to 4
  final HouseVerdict verdict;

  const HouseResult({
    required this.input,
    required this.number,
    required this.psychic,
    required this.destiny,
    required this.withPsychic,
    required this.withDestiny,
    required this.score,
    required this.verdict,
  });

  int get root => number.root;
}

/// One suggested lucky number (for a jersey, a shirt, a locker and so on).
class LuckyPick {
  final int number;
  final int root;
  final L why;
  const LuckyPick(this.number, this.root, this.why);
}

/// Lucky Number Kit: house / flat number check and lucky numbers.
///
/// This is traditional numerology, not science. The calculation is the same
/// idea used everywhere in the app: a number is "friendly", "neutral" or
/// "challenging" with the owner's Mulank and Bhagyank, using the friend and
/// enemy table in [NumerologyTools].
class LuckyKit {
  static int rootOf(int n) {
    var x = n.abs();
    while (x > 9) {
      x = NumerologyEngine.digitSum(x);
    }
    return x;
  }

  /// Checks a house, flat or plot number such as "12", "B-204" or "7/A".
  /// Digits count at face value and letters use Chaldean values.
  /// Returns null when nothing countable was typed.
  static HouseResult? house(String input, int psychic, int destiny) {
    final text = input.trim();
    if (text.isEmpty) return null;
    final r = NumerologyEngine.vehicle(text);
    if (r.items.isEmpty || r.total == 0) return null;
    final a = NumerologyTools.relation(r.root, psychic);
    final b = NumerologyTools.relation(r.root, destiny);
    final score = NumerologyTools.points(a) + NumerologyTools.points(b);
    final HouseVerdict v;
    if (score >= 3) {
      v = HouseVerdict.good;
    } else if (score == 2) {
      v = HouseVerdict.mixed;
    } else {
      v = HouseVerdict.careful;
    }
    return HouseResult(
      input: text,
      number: r,
      psychic: psychic,
      destiny: destiny,
      withPsychic: a,
      withDestiny: b,
      score: score,
      verdict: v,
    );
  }

  /// Numbers from 1 to 99 that are not challenging with the Mulank or the
  /// Bhagyank. Best first, at most two with the same root so the list has
  /// variety. Always returns at least a few numbers.
  static List<LuckyPick> luckyNumbers(int psychic, int destiny,
      {int count = 6}) {
    final all = <_Cand>[];
    for (var n = 1; n <= 99; n++) {
      final root = rootOf(n);
      final a = NumerologyTools.relation(root, psychic);
      final b = NumerologyTools.relation(root, destiny);
      if (a == Relation.enemy || b == Relation.enemy) continue;
      var score = 3 * NumerologyTools.points(a) + 2 * NumerologyTools.points(b);
      if (root == psychic) score += 2;
      if (root == destiny) score += 1;
      all.add(_Cand(n, root, score));
    }
    all.sort((x, y) {
      final c = y.score.compareTo(x.score);
      return c != 0 ? c : x.n.compareTo(y.n);
    });
    final perRoot = <int, int>{};
    final out = <LuckyPick>[];
    for (final c in all) {
      final used = perRoot[c.root] ?? 0;
      if (used >= 2) continue;
      perRoot[c.root] = used + 1;
      out.add(LuckyPick(c.n, c.root, _why(c.n, c.root, psychic, destiny)));
      if (out.length >= count) break;
    }
    return out;
  }

  /// Roots (1 to 9) that are challenging with the Mulank or the Bhagyank.
  static List<int> avoidRoots(int psychic, int destiny) {
    final out = <int>[];
    for (var r = 1; r <= 9; r++) {
      if (NumerologyTools.relation(r, psychic) == Relation.enemy ||
          NumerologyTools.relation(r, destiny) == Relation.enemy) {
        out.add(r);
      }
    }
    return out;
  }

  static L _why(int n, int root, int psychic, int destiny) {
    final sum = n > 9 ? '$n adds up to $root' : '$n';
    final sumHi = n > 9 ? '$n का जोड़ $root बनता है' : '$n';
    if (root == psychic && root == destiny) {
      return L('$sum: the same as both your Mulank and Bhagyank.',
          '$sumHi: आपके मूलांक और भाग्यांक दोनों के बराबर।');
    }
    if (root == psychic) {
      return L('$sum: the same as your Mulank $psychic.',
          '$sumHi: आपके मूलांक $psychic के बराबर।');
    }
    if (root == destiny) {
      return L('$sum: the same as your Bhagyank $destiny.',
          '$sumHi: आपके भाग्यांक $destiny के बराबर।');
    }
    return L(
        '$sum: friendly or neutral with your Mulank $psychic and Bhagyank $destiny.',
        '$sumHi: आपके मूलांक $psychic और भाग्यांक $destiny के साथ अनुकूल या सामान्य।');
  }

  static String relWord(Relation r, bool hindi) {
    switch (r) {
      case Relation.friend:
        return hindi ? 'अनुकूल' : 'Friendly';
      case Relation.neutral:
        return hindi ? 'सामान्य' : 'Neutral';
      case Relation.enemy:
        return hindi ? 'चुनौतीपूर्ण' : 'Challenging';
    }
  }
}

class _Cand {
  final int n;
  final int root;
  final int score;
  _Cand(this.n, this.root, this.score);
}

/// What a house number with root 1 to 9 feels like (traditional view).
class HomeInfo {
  final L theme;
  final L suits;
  final L watch;
  final L tip;
  const HomeInfo(this.theme, this.suits, this.watch, this.tip);
}

class LuckyKitText {
  static const L title = L('Lucky Number Kit', 'शुभ अंक किट');
  static const L intro = L(
    'Check if your house or flat number suits you, and find lucky numbers for a jersey, shirt, locker or anything you choose. This is a traditional numerology guide, not a scientific fact and not a promise.',
    'देखिए आपके मकान या फ़्लैट का नंबर आपके लिए कैसा है, और जर्सी, शर्ट, लॉकर या किसी भी चीज़ के लिए शुभ अंक पाइए। यह पारंपरिक अंक-ज्योतिष का मार्गदर्शन है, कोई वैज्ञानिक तथ्य या वादा नहीं।',
  );
  static const L dobLabel = L('Your date of birth', 'आपकी जन्म तिथि');
  static const L houseSection = L('House / flat number', 'मकान / फ़्लैट नंबर');
  static const L houseLabel =
      L('House or flat number (like 12, B-204, 7/A)', 'मकान या फ़्लैट नंबर (जैसे 12, B-204, 7/A)');
  static const L check = L('Check my number', 'मेरा नंबर जाँचिए');
  static const L needDob = L('Please choose your date of birth first.',
      'पहले अपनी जन्म तिथि चुनिए।');
  static const L badHouse = L('Nothing countable was found. Please type digits or English letters.',
      'गिनने लायक कुछ नहीं मिला। कृपया अंक या अंग्रेज़ी अक्षर लिखिए।');
  static const L total = L('Total', 'कुल जोड़');
  static const L root = L('Root', 'मूलांक');
  static const L withMulank = L('With your Mulank', 'आपके मूलांक के साथ');
  static const L withBhagyank = L('With your Bhagyank', 'आपके भाग्यांक के साथ');
  static const L homeNature = L('How this home feels', 'यह घर कैसा महसूस होता है');
  static const L suitsLabel = L('Suits', 'किसके लिए अच्छा');
  static const L watchLabel = L('Be careful about', 'किस बात का ध्यान रखें');
  static const L tipLabel = L('A simple tip', 'एक आसान सुझाव');
  static const L compoundLabel = L('Compound number', 'कंपाउंड नंबर');
  static const L stepsTitle = L('If it is not fully favourable', 'अगर पूरी तरह अनुकूल न हो');
  static const L luckyTitle = L('Your lucky numbers', 'आपके शुभ अंक');
  static const L luckyIntro = L(
    'Use these for a jersey or shirt number, a locker, a seat or a wallet note. Two-digit numbers are added down to one digit, and that digit is what counts.',
    'इन्हें जर्सी या शर्ट के नंबर, लॉकर, सीट या पर्स के नोट के लिए इस्तेमाल करिए। दो अंकों वाले नंबर को जोड़कर एक अंक बनाया जाता है, और वही गिना जाता है।',
  );
  static const L avoidTitle = L('Numbers to avoid', 'किन अंकों से बचें');
  static const L avoidNone = L('No number is strongly challenging for you.',
      'आपके लिए कोई अंक बहुत चुनौतीपूर्ण नहीं है।');
  static const L kitTitle = L('Your colour, day and stone', 'आपका रंग, दिन और रत्न');
  static const L note = L(
    'This is a traditional guide. A house depends on much more: location, safety, budget and family needs. Do not buy, sell or move house only because of a number. Gemstones and colours are traditional beliefs and no replacement for medical, legal or financial advice.',
    'यह पारंपरिक मार्गदर्शन है। घर कई और बातों पर निर्भर करता है: जगह, सुरक्षा, बजट और परिवार की ज़रूरतें। केवल किसी नंबर की वजह से घर न खरीदिए, न बेचिए, न बदलिए। रत्न और रंग पारंपरिक मान्यताएँ हैं, ये चिकित्सा, कानूनी या आर्थिक सलाह की जगह नहीं लेते।',
  );

  static const Map<HouseVerdict, L> verdictTitle = {
    HouseVerdict.good: L('Good match', 'अच्छा मेल'),
    HouseVerdict.mixed: L('Mixed match', 'मिला-जुला मेल'),
    HouseVerdict.careful: L('Needs some care', 'थोड़ी सावधानी चाहिए'),
  };

  static const Map<HouseVerdict, L> verdictBody = {
    HouseVerdict.good: L(
      'This number is friendly with your birth numbers. Traditionally, such a home supports your natural way of living, so everyday life feels smoother.',
      'यह नंबर आपके जन्म के अंकों से मेल खाता है। परंपरा के अनुसार ऐसा घर आपके स्वभाव का साथ देता है, इसलिए रोज़ का जीवन आसान लगता है।',
    ),
    HouseVerdict.mixed: L(
      'This number is partly friendly and partly neutral or challenging with your birth numbers. It can work well. You may feel supported in some areas of life and need patience in others.',
      'यह नंबर आपके जन्म के अंकों से कुछ हद तक मेल खाता है और कुछ हद तक सामान्य या चुनौतीपूर्ण है। यह अच्छा चल सकता है। जीवन के कुछ पहलुओं में सहारा और कुछ में धैर्य चाहिए होगा।',
    ),
    HouseVerdict.careful: L(
      'This number is not very friendly with your birth numbers. This does not mean bad luck. It means you may need more patience and some small habits that balance the home.',
      'यह नंबर आपके जन्म के अंकों से बहुत मेल नहीं खाता। इसका मतलब बुरी क़िस्मत नहीं है। इसका मतलब है कि आपको ज़्यादा धैर्य और घर को संतुलित करने वाली कुछ छोटी आदतें चाहिए होंगी।',
    ),
  };

  static const L steps = L(
    '1) Put your own lucky colour at the entrance: a doormat, a nameplate or a small decoration.\n'
        '2) Keep the entrance clean, bright and free of clutter.\n'
        '3) Keep a fresh plant or a small lamp near the door.\n'
        '4) Start important family work on one of your lucky days.\n'
        '5) Keep a lucky number in your own life, such as a lucky number in your phone or a lucky date for big decisions.\n'
        'These are gentle traditional habits. They are not a reason to change your house.',
    '1) अपना शुभ रंग प्रवेश द्वार पर रखिए: पायदान, नेमप्लेट या छोटी सजावट में।\n'
        '2) प्रवेश द्वार साफ़, रोशन और बिना कबाड़ के रखिए।\n'
        '3) दरवाज़े के पास ताज़ा पौधा या छोटा दीया रखिए।\n'
        '4) परिवार के ज़रूरी काम अपने शुभ दिन पर शुरू कीजिए।\n'
        '5) अपने जीवन में कोई शुभ अंक रखिए, जैसे बड़े फ़ैसलों के लिए शुभ तारीख़।\n'
        'ये हल्की पारंपरिक आदतें हैं। इन्हें घर बदलने का कारण न बनाइए।',
  );

  static const Map<int, HomeInfo> home = {
    1: HomeInfo(
      L('Bright, independent and full of fresh starts. A home that gives confidence and a feeling of leading your own life.',
          'रोशन, आज़ाद और नई शुरुआतों से भरा। ऐसा घर आत्मविश्वास देता है और अपनी राह खुद चुनने का एहसास कराता है।'),
      L('People who build their own work or business, and those who want to take decisions with confidence.',
          'जो अपना काम या व्यापार बनाते हैं और आत्मविश्वास से फ़ैसले लेना चाहते हैं।'),
      L('Ego clashes. One strong voice can dominate the house.',
          'अहंकार का टकराव। एक तेज़ आवाज़ पूरे घर पर हावी हो सकती है।'),
      L('Take big family decisions together, over a shared meal.',
          'परिवार के बड़े फ़ैसले साथ बैठकर, खाने के समय लीजिए।'),
    ),
    2: HomeInfo(
      L('Calm, soft and family-centred. A peaceful home that favours sharing and emotional comfort.',
          'शांत, कोमल और परिवार-केंद्रित। ऐसा घर आपसी सहयोग और मन की शांति देता है।'),
      L('Couples, joint families, and people who value peace and rest.',
          'दंपत्ति, संयुक्त परिवार और वे लोग जो शांति और आराम की क़द्र करते हैं।'),
      L('Over-sensitivity and mood swings. Small things can feel big.',
          'ज़्यादा संवेदनशीलता और मूड का उतार-चढ़ाव। छोटी बातें बड़ी लग सकती हैं।'),
      L('Keep soft light and white or cream shades in the living area.',
          'बैठक में हल्की रोशनी और सफ़ेद या क्रीम रंग रखिए।'),
    ),
    3: HomeInfo(
      L('Open, cheerful and growing. A home that attracts guests, learning, children and good conversation.',
          'खुला, हँसमुख और बढ़ता हुआ। ऐसा घर मेहमान, पढ़ाई, बच्चे और अच्छी बातचीत को खींचता है।'),
      L('Families with children, teachers, students and people who like to host.',
          'बच्चों वाले परिवार, शिक्षक, विद्यार्थी और मेहमाननवाज़ी पसंद करने वाले।'),
      L('Scattered energy and spending on show.',
          'बिखरी हुई ऊर्जा और दिखावे का खर्च।'),
      L('Keep a small reading or study corner. It keeps the energy focused.',
          'पढ़ने या पढ़ाई का एक छोटा कोना रखिए। इससे ऊर्जा एक जगह टिकती है।'),
    ),
    4: HomeInfo(
      L('Practical and unusual. A home of hard work, planning and sudden changes. It teaches discipline.',
          'व्यावहारिक और अलग तरह का। मेहनत, योजना और अचानक बदलावों का घर। यह अनुशासन सिखाता है।'),
      L('Practical, hard-working people and those who like order and rules.',
          'व्यावहारिक, मेहनती लोग और वे जो व्यवस्था और नियम पसंद करते हैं।'),
      L('Delays, restlessness and surprise expenses.',
          'देरी, बेचैनी और अचानक खर्च।'),
      L('Repair small things on time and keep the house tidy. It keeps the mind steady.',
          'छोटी चीज़ें समय पर ठीक करवाइए और घर व्यवस्थित रखिए। इससे मन स्थिर रहता है।'),
    ),
    5: HomeInfo(
      L('Lively, moving and sociable. A home with many visitors, calls, ideas and plans.',
          'चहल-पहल वाला, गतिशील और मिलनसार। ऐसा घर जिसमें मेहमान, फ़ोन, विचार और योजनाएँ रहती हैं।'),
      L('Business people, traders, media and communication work, and people who enjoy company.',
          'व्यापारी, मीडिया और संवाद का काम करने वाले, और लोगों के बीच रहना पसंद करने वाले।'),
      L('Restlessness. It can be hard to settle and to rest.',
          'बेचैनी। टिककर बैठना और आराम करना मुश्किल हो सकता है।'),
      L('Keep one quiet corner where phones stay away.',
          'एक शांत कोना रखिए जहाँ फ़ोन न जाए।'),
    ),
    6: HomeInfo(
      L('Warm, comfortable and beautiful. A home of love, family harmony, good food and care.',
          'गर्मजोशी भरा, आरामदायक और सुंदर। प्रेम, पारिवारिक सामंजस्य, अच्छे खाने और देखभाल का घर।'),
      L('Families, newly married couples and artistic people.',
          'परिवार, नवविवाहित जोड़े और कलाकार स्वभाव के लोग।'),
      L('Too much comfort and spending on luxury.',
          'ज़्यादा आराम और विलासिता पर खर्च।'),
      L('Keep the house clean and fresh. Fresh flowers suit this number.',
          'घर साफ़ और ताज़ा रखिए। ताज़े फूल इस अंक पर जँचते हैं।'),
    ),
    7: HomeInfo(
      L('Quiet, thoughtful and inward. A home that supports study, prayer, writing and rest.',
          'शांत, विचारशील और अंतर्मुखी। ऐसा घर पढ़ाई, पूजा, लेखन और आराम में मदद करता है।'),
      L('Students, writers, researchers and spiritual people.',
          'विद्यार्थी, लेखक, शोध करने वाले और आध्यात्मिक लोग।'),
      L('Feeling distant from people and spending too much time alone.',
          'लोगों से दूरी महसूस होना और बहुत अकेले रहना।'),
      L('Plan regular time with family and friends so the quiet does not turn into loneliness.',
          'परिवार और दोस्तों के साथ नियमित समय तय कीजिए ताकि शांति अकेलेपन में न बदले।'),
    ),
    8: HomeInfo(
      L('Serious, strong and slow-building. A home of discipline, responsibility and long-term results.',
          'गंभीर, मज़बूत और धीरे-धीरे बनने वाला। अनुशासन, ज़िम्मेदारी और लंबे समय के नतीजों का घर।'),
      L('Patient, hard-working people and those building something for the long run.',
          'धैर्यवान, मेहनती लोग और वे जो लंबे समय के लिए कुछ बना रहे हैं।'),
      L('A heavy mood, delays and loneliness if work takes over life.',
          'काम हावी होने पर भारीपन, देरी और अकेलापन।'),
      L('Clear clutter, respect elders and keep a steady daily routine.',
          'कबाड़ हटाइए, बड़ों का सम्मान कीजिए और रोज़ की एक नियमित दिनचर्या रखिए।'),
    ),
    9: HomeInfo(
      L('Energetic, brave and active. A home of movement, courage, protection and strong feelings.',
          'ऊर्जावान, साहसी और सक्रिय। गति, हिम्मत, सुरक्षा और तेज़ भावनाओं का घर।'),
      L('Active families, sports people, and those who work in service, defence or help for others.',
          'सक्रिय परिवार, खिलाड़ी, और सेवा, सुरक्षा या दूसरों की मदद का काम करने वाले।'),
      L('Anger, hurry and arguments.',
          'गुस्सा, जल्दबाज़ी और बहस।'),
      L('Keep the house airy. Use the extra energy in exercise or a walk.',
          'घर में हवा आने दीजिए। अतिरिक्त ऊर्जा को कसरत या सैर में लगाइए।'),
    ),
  };
}
