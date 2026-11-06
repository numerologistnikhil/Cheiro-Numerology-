import 'root_profiles.dart' show L;

/// Western (Pythagorean) numerology: Life Path, Expression, Soul Urge,
/// Personality, Maturity, Birthday number and karmic debt numbers.
/// Master numbers 11, 22 and 33 are kept (not reduced) as Western
/// numerologists do. Pure Dart so it can be unit tested.
class WesternChart {
  final int lifePath;
  final int lifePathRaw; // total before the last reduction
  final int birthday;
  final int? expression;
  final int? expressionRaw;
  final int? soulUrge;
  final int? personality;
  final int? maturity;
  final List<int> karmicDebts;

  const WesternChart({
    required this.lifePath,
    required this.lifePathRaw,
    required this.birthday,
    this.expression,
    this.expressionRaw,
    this.soulUrge,
    this.personality,
    this.maturity,
    this.karmicDebts = const [],
  });
}

class Pythagorean {
  static const Set<int> masters = {11, 22, 33};
  static const Set<int> karmic = {13, 14, 16, 19};

  static const Map<String, int> _letters = {
    'A': 1, 'J': 1, 'S': 1,
    'B': 2, 'K': 2, 'T': 2,
    'C': 3, 'L': 3, 'U': 3,
    'D': 4, 'M': 4, 'V': 4,
    'E': 5, 'N': 5, 'W': 5,
    'F': 6, 'O': 6, 'X': 6,
    'G': 7, 'P': 7, 'Y': 7,
    'H': 8, 'Q': 8, 'Z': 8,
    'I': 9, 'R': 9,
  };
  static const Set<String> _vowels = {'A', 'E', 'I', 'O', 'U'};

  static int digitSum(int n) {
    var s = 0;
    var x = n.abs();
    while (x > 0) {
      s += x % 10;
      x ~/= 10;
    }
    return s;
  }

  /// Reduce to one digit but keep master numbers 11, 22, 33.
  static int reduceKeep(int n) {
    var x = n;
    while (x > 9 && !masters.contains(x)) {
      x = digitSum(x);
    }
    return x;
  }

  /// Reduce to one digit always.
  static int reduceAll(int n) {
    var x = n;
    while (x > 9) {
      x = digitSum(x);
    }
    return x;
  }

  static int letterValue(String ch) => _letters[ch.toUpperCase()] ?? 0;

  static String _clean(String name) =>
      name.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');

  /// Sum of letter values. [only]: null = all letters, true = vowels,
  /// false = consonants. Y is counted as a consonant.
  static int nameTotal(String name, {bool? vowels}) {
    var sum = 0;
    for (final ch in _clean(name).split('')) {
      final isV = _vowels.contains(ch);
      if (vowels == null || vowels == isV) sum += letterValue(ch);
    }
    return sum;
  }

  static int lifePathRaw(DateTime d) =>
      reduceKeep(d.month) + reduceKeep(d.day) + reduceKeep(digitSum(d.year));

  static WesternChart chart(DateTime dob, String name) {
    final raw = lifePathRaw(dob);
    final lp = reduceKeep(raw);
    final debts = <int>[];
    if (karmic.contains(raw)) debts.add(raw);
    final clean = _clean(name);
    int? exp, expRaw, soul, pers, mat;
    if (clean.isNotEmpty) {
      expRaw = nameTotal(name);
      exp = reduceKeep(expRaw);
      if (karmic.contains(expRaw) && !debts.contains(expRaw)) debts.add(expRaw);
      final v = nameTotal(name, vowels: true);
      final c = nameTotal(name, vowels: false);
      soul = v == 0 ? null : reduceKeep(v);
      pers = c == 0 ? null : reduceKeep(c);
      mat = reduceKeep(lp + exp);
    }
    return WesternChart(
      lifePath: lp,
      lifePathRaw: raw,
      birthday: reduceKeep(dob.day),
      expression: exp,
      expressionRaw: expRaw,
      soulUrge: soul,
      personality: pers,
      maturity: mat,
      karmicDebts: debts,
    );
  }

  /// Personal year (1-9) for the given calendar year.
  static int personalYear(DateTime dob, int year) =>
      reduceAll(reduceAll(dob.day) + reduceAll(dob.month) + reduceAll(digitSum(year)));
}

class WesternText {
  static const L title = L('Western Chart (Pythagorean)', 'पश्चिमी चार्ट (पाइथागोरस)');
  static const L intro = L(
    'Western numerology uses the Pythagorean letter table (A=1 ... I=9) and keeps the master numbers 11, 22 and 33. '
    'Ank Dhara also gives you the Indian Chaldean reading, so you can compare both. Different systems give different results, and that is normal. '
    'Both are traditions for reflection, not science.',
    'पश्चिमी अंकशास्त्र में पाइथागोरस अक्षर तालिका (A=1 ... I=9) चलती है और मास्टर अंक 11, 22, 33 को घटाया नहीं जाता। '
    'अंक धारा आपको भारतीय कैल्डियन पाठ भी देता है ताकि आप दोनों की तुलना कर सकें। अलग पद्धतियों के नतीजे अलग होते हैं, यह सामान्य है। '
    'दोनों चिंतन की परंपराएँ हैं, विज्ञान नहीं।');
  static const L nameLabel = L('Full name (as on birth certificate)', 'पूरा नाम (जन्म प्रमाणपत्र के अनुसार)');
  static const L dobLabel = L('Your date of birth', 'आपकी जन्म तिथि');
  static const L lifePath = L('Life Path', 'जीवन पथ');
  static const L birthday = L('Birthday number', 'जन्मदिन अंक');
  static const L expression = L('Expression (Destiny)', 'एक्सप्रेशन (भाग्य)');
  static const L soul = L('Soul Urge (Heart\'s Desire)', 'सोल अर्ज (हृदय की चाह)');
  static const L personality = L('Personality', 'व्यक्तित्व');
  static const L maturity = L('Maturity', 'परिपक्वता');
  static const L lifePathHow = L('From your date of birth: month + day + year, each reduced.', 'जन्म तिथि से: महीना + दिन + साल, हर एक घटाकर।');
  static const L expressionHow = L('From all letters of your full name.', 'पूरे नाम के सभी अक्षरों से।');
  static const L soulHow = L('From the vowels of your name (A E I O U).', 'नाम के स्वरों (A E I O U) से।');
  static const L personalityHow = L('From the consonants of your name.', 'नाम के व्यंजनों से।');
  static const L maturityHow = L('Life Path + Expression. Shows after about age 35 to 40.', 'जीवन पथ + एक्सप्रेशन। लगभग 35-40 वर्ष की उम्र के बाद उभरता है।');
  static const L birthdayHow = L('From your day of birth: a special talent.', 'जन्म के दिन से: एक ख़ास प्रतिभा।');
  static const L master = L('Master number', 'मास्टर अंक');
  static const L masterNote = L(
    'Master numbers carry bigger potential and bigger pressure. If it feels heavy, read the single-digit meaning too (11 as 2, 22 as 4, 33 as 6).',
    'मास्टर अंक बड़ी संभावना और बड़ा दबाव साथ लाते हैं। भारी लगे तो एक अंक वाला अर्थ भी पढ़ें (11 को 2, 22 को 4, 33 को 6)।');
  static const L karmicTitle = L('Karmic debt numbers', 'कार्मिक ऋण अंक');
  static const L karmicNone = L('No karmic debt number found in your Life Path or name total.', 'आपके जीवन पथ या नाम के जोड़ में कोई कार्मिक ऋण अंक नहीं मिला।');
  static const L karmicNote = L(
    'In Western tradition 13, 14, 16 and 19 are seen as lessons carried from past choices. Read them as a call to build a habit, not as a curse.',
    'पश्चिमी परंपरा में 13, 14, 16 और 19 को पुराने चुनावों से आए सबक माना जाता है। इन्हें श्राप नहीं, आदत बनाने के बुलावे की तरह पढ़ें।');
  static const L eastWest = L('East meets West: your numbers side by side', 'पूरब और पश्चिम: आपके अंक साथ-साथ');
  static const L eastWestBody = L(
    'Indian (Chaldean/Vedic) reading uses your Mulank (day of birth) and Bhagyank (full date). Western reading uses Life Path (date, with masters kept) and your name numbers. '
    'When both point the same way, take it as a strong theme. When they differ, each is showing a different side of you.',
    'भारतीय (कैल्डियन/वैदिक) पाठ मूलांक (जन्म का दिन) और भाग्यांक (पूरी तारीख) लेता है। पश्चिमी पाठ जीवन पथ (मास्टर अंक रखकर) और नाम के अंक लेता है। '
    'दोनों एक ही दिशा दिखाएँ तो उसे मज़बूत थीम मानें। अलग हों तो हर एक आपका अलग पहलू दिखा रहा है।');
  static const L mulank = L('Mulank (Indian)', 'मूलांक (भारतीय)');
  static const L bhagyank = L('Bhagyank (Indian)', 'भाग्यांक (भारतीय)');
  static const L py = L('Personal year', 'व्यक्तिगत वर्ष');
  static const L missingName = L('Enter your full name to see Expression, Soul Urge, Personality and Maturity.', 'एक्सप्रेशन, सोल अर्ज, व्यक्तित्व और परिपक्वता देखने के लिए पूरा नाम लिखें।');
  static const L note = L(
    'Use this as one lens for reflection. It does not predict or guarantee outcomes. Names written in different spellings change the name numbers.',
    'इसे चिंतन के एक नज़रिये की तरह लें। यह नतीजों की भविष्यवाणी या गारंटी नहीं देता। नाम की स्पेलिंग बदलने से नाम के अंक बदलते हैं।');

  /// Core theme of each number.
  static const Map<int, L> core = {
    1: L('Independent, original and born to lead. You learn by starting things and standing on your own feet.', 'स्वतंत्र, मौलिक और नेतृत्व के लिए बने। आप नई शुरुआत करके और अपने पैरों पर खड़े होकर सीखते हैं।'),
    2: L('Gentle, tactful and cooperative. You grow through partnership, patience and listening.', 'कोमल, व्यवहार-कुशल और सहयोगी। आप साझेदारी, धैर्य और सुनने से आगे बढ़ते हैं।'),
    3: L('Creative, expressive and joyful. You grow by sharing ideas, words and talent with others.', 'रचनात्मक, अभिव्यक्त करने वाले और आनंदित। आप विचार, शब्द और प्रतिभा बाँटकर आगे बढ़ते हैं।'),
    4: L('Practical, steady and hard-working. You build lasting things through discipline and order.', 'व्यावहारिक, स्थिर और मेहनती। आप अनुशासन और व्यवस्था से टिकाऊ चीज़ें बनाते हैं।'),
    5: L('Curious, free and adaptable. You learn through change, travel and new experience.', 'जिज्ञासु, स्वतंत्र और ढल जाने वाले। आप बदलाव, यात्रा और नए अनुभव से सीखते हैं।'),
    6: L('Caring, responsible and family-minded. You grow through love, service and creating harmony.', 'देखभाल करने वाले, ज़िम्मेदार और परिवार-प्रिय। आप प्रेम, सेवा और तालमेल बनाकर आगे बढ़ते हैं।'),
    7: L('Thoughtful, spiritual and analytical. You grow through study, solitude and seeking the truth.', 'विचारशील, आध्यात्मिक और विश्लेषणात्मक। आप अध्ययन, एकांत और सच की खोज से आगे बढ़ते हैं।'),
    8: L('Ambitious, strong and result-oriented. You learn about power, money and fairness through effort.', 'महत्वाकांक्षी, मज़बूत और नतीजे चाहने वाले। आप मेहनत से ताकत, पैसे और न्याय के बारे में सीखते हैं।'),
    9: L('Compassionate, wise and generous. You grow by giving, forgiving and finishing cycles.', 'करुणामय, समझदार और उदार। आप देकर, माफ़ करके और चक्र पूरे करके आगे बढ़ते हैं।'),
    11: L('Master 11: intuitive, inspiring and sensitive. A teacher or messenger who must learn to stay calm and grounded.', 'मास्टर 11: अंतर्ज्ञानी, प्रेरक और संवेदनशील। शिक्षक या संदेशवाहक, जिसे शांत और संतुलित रहना सीखना है।'),
    22: L('Master 22: the master builder. Big practical vision that needs patience, planning and steady work.', 'मास्टर 22: महान निर्माता। बड़ी व्यावहारिक सोच जिसे धैर्य, योजना और लगातार मेहनत चाहिए।'),
    33: L('Master 33: the healing teacher. Deep love and service for others, with a need to protect your own energy.', 'मास्टर 33: उपचारक शिक्षक। दूसरों के लिए गहरा प्रेम और सेवा, साथ में अपनी ऊर्जा बचाने की ज़रूरत।'),
  };

  /// What the heart wants (Soul Urge).
  static const Map<int, L> inner = {
    1: L('You secretly want independence and to do things your own way.', 'आप भीतर से आज़ादी चाहते हैं और काम अपने तरीके से करना चाहते हैं।'),
    2: L('You secretly want peace, closeness and to be understood.', 'आप भीतर से शांति, नज़दीकी और समझे जाने की चाह रखते हैं।'),
    3: L('You secretly want to express yourself, create and be appreciated.', 'आप भीतर से खुद को व्यक्त करना, रचना और सराहे जाना चाहते हैं।'),
    4: L('You secretly want security, order and something solid to rely on.', 'आप भीतर से सुरक्षा, व्यवस्था और भरोसे लायक ठोस आधार चाहते हैं।'),
    5: L('You secretly want freedom, variety and adventure.', 'आप भीतर से आज़ादी, विविधता और रोमांच चाहते हैं।'),
    6: L('You secretly want a loving home and to care for people.', 'आप भीतर से प्यार भरा घर और लोगों की देखभाल करना चाहते हैं।'),
    7: L('You secretly want answers, quiet time and inner truth.', 'आप भीतर से जवाब, शांत समय और भीतरी सच चाहते हैं।'),
    8: L('You secretly want achievement, respect and financial strength.', 'आप भीतर से उपलब्धि, सम्मान और आर्थिक मज़बूती चाहते हैं।'),
    9: L('You secretly want to make a difference and serve a larger cause.', 'आप भीतर से बदलाव लाना और किसी बड़े उद्देश्य की सेवा करना चाहते हैं।'),
    11: L('You secretly want to inspire and to live a meaningful, spiritual life.', 'आप भीतर से प्रेरित करना और अर्थपूर्ण, आध्यात्मिक जीवन जीना चाहते हैं।'),
    22: L('You secretly want to build something big that helps many people.', 'आप भीतर से कुछ बड़ा बनाना चाहते हैं जो कई लोगों की मदद करे।'),
    33: L('You secretly want to heal and uplift others through love.', 'आप भीतर से प्रेम के ज़रिए दूसरों को सँवारना और उठाना चाहते हैं।'),
  };

  /// How others first see you (Personality).
  static const Map<int, L> outer = {
    1: L('Others see a confident, direct person who takes charge.', 'लोग आपको आत्मविश्वासी, सीधे और ज़िम्मेदारी लेने वाला देखते हैं।'),
    2: L('Others see a kind, calm and approachable person.', 'लोग आपको दयालु, शांत और सहज उपलब्ध व्यक्ति देखते हैं।'),
    3: L('Others see a friendly, lively and charming person.', 'लोग आपको मिलनसार, जीवंत और आकर्षक व्यक्ति देखते हैं।'),
    4: L('Others see a reliable, serious and organised person.', 'लोग आपको भरोसेमंद, गंभीर और व्यवस्थित व्यक्ति देखते हैं।'),
    5: L('Others see an energetic, interesting and restless person.', 'लोग आपको ऊर्जावान, दिलचस्प और बेचैन व्यक्ति देखते हैं।'),
    6: L('Others see a warm, responsible and nurturing person.', 'लोग आपको गर्मजोशी वाला, ज़िम्मेदार और पालन करने वाला व्यक्ति देखते हैं।'),
    7: L('Others see a reserved, thoughtful and mysterious person.', 'लोग आपको संकोची, विचारशील और रहस्यमय व्यक्ति देखते हैं।'),
    8: L('Others see a powerful, professional and capable person.', 'लोग आपको प्रभावशाली, पेशेवर और सक्षम व्यक्ति देखते हैं।'),
    9: L('Others see a generous, wise and caring person.', 'लोग आपको उदार, समझदार और परवाह करने वाला व्यक्ति देखते हैं।'),
    11: L('Others see an inspiring, intuitive and slightly unusual person.', 'लोग आपको प्रेरक, अंतर्ज्ञानी और थोड़ा अलग व्यक्ति देखते हैं।'),
    22: L('Others see a capable person with big plans and a steady manner.', 'लोग आपको बड़ी योजनाओं और स्थिर स्वभाव वाला सक्षम व्यक्ति देखते हैं।'),
    33: L('Others see a gentle, giving and deeply caring person.', 'लोग आपको सौम्य, देने वाला और गहराई से परवाह करने वाला व्यक्ति देखते हैं।'),
  };

  static const Map<int, L> karmicText = {
    13: L('13/4: lessons about laziness and shortcuts. Steady, honest work turns it into real strength.', '13/4: आलस्य और शॉर्टकट के सबक। स्थिर, ईमानदार मेहनत इसे असली ताकत बना देती है।'),
    14: L('14/5: lessons about freedom and excess. Balance, commitment and moderation are the answer.', '14/5: आज़ादी और अति के सबक। संतुलन, प्रतिबद्धता और संयम इसका जवाब हैं।'),
    16: L('16/7: lessons about ego and pride. Humility and learning from setbacks open the way.', '16/7: अहं और घमंड के सबक। विनम्रता और झटकों से सीखना राह खोलता है।'),
    19: L('19/1: lessons about independence and sharing power. Learn to ask for help and to give credit.', '19/1: आत्मनिर्भरता और शक्ति बाँटने के सबक। मदद माँगना और श्रेय देना सीखें।'),
  };

  static const Map<int, L> yearTheme = {
    1: L('A year to start fresh and take the lead.', 'नई शुरुआत करने और नेतृत्व लेने का साल।'),
    2: L('A year for patience, partnership and small steady steps.', 'धैर्य, साझेदारी और छोटे स्थिर कदमों का साल।'),
    3: L('A year for creativity, social life and expressing yourself.', 'रचनात्मकता, मेलजोल और खुद को व्यक्त करने का साल।'),
    4: L('A year for building, order and hard work.', 'निर्माण, व्यवस्था और मेहनत का साल।'),
    5: L('A year of change, movement and new chances.', 'बदलाव, गति और नए मौकों का साल।'),
    6: L('A year for family, home and responsibility.', 'परिवार, घर और ज़िम्मेदारी का साल।'),
    7: L('A year for rest, study and inner growth.', 'विश्राम, अध्ययन और भीतरी विकास का साल।'),
    8: L('A year for results, money and recognition.', 'नतीजों, पैसे और पहचान का साल।'),
    9: L('A year to finish, let go and prepare for a new cycle.', 'चीज़ें पूरी करने, छोड़ने और नए चक्र की तैयारी का साल।'),
  };
}
