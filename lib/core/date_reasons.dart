import 'numerology_tools.dart';
import 'root_profiles.dart' show L;

/// Plain-language reasons for a suggested date, and business ideas that
/// traditionally go with each number. This is traditional numerology, not
/// science: use it as one input next to practical factors.
class DateReason {
  final List<L> lines;
  const DateReason(this.lines);
}

class DateReasons {
  static const L title = L('Date Selection', 'शुभ तिथि चयन');
  static const L pickBirth = L('Birth date of the main person', 'मुख्य व्यक्ति की जन्म तिथि');
  static const L pickDate = L('Select date of birth', 'जन्म तिथि चुनें');
  static const L purposeLabel = L('Purpose', 'उद्देश्य');
  static const L findBtn = L('Find Dates (next 45 days)', 'तिथियाँ खोजें (अगले 45 दिन)');
  static const L noDates = L('No dates matched in the next 45 days. Try another purpose.',
      'अगले 45 दिनों में कोई तिथि नहीं मिली। कोई और उद्देश्य चुनकर देखें।');
  static const L strong = L('Strong', 'मज़बूत');
  static const L dayNo = L('Day number', 'दिन का अंक');
  static const L fullNo = L('Full date number', 'पूरी तिथि का अंक');
  static const L whyTitle = L('Why this date is good', 'यह तिथि अच्छी क्यों है');
  static const L ideasTitle = L('Business that suits this day', 'इस दिन कौन सा काम शुरू करें');
  static const L tapHint = L('Tap a date to see why it is lucky', 'कारण देखने के लिए तिथि पर टैप करें');

  static const Map<String, L> purposeNames = {
    'Marriage': L('Marriage', 'विवाह'),
    'Business start': L('Business start', 'व्यापार शुरू करना'),
    'Property / vehicle': L('Property / vehicle', 'प्रॉपर्टी / गाड़ी'),
    'Travel': L('Travel', 'यात्रा'),
    'Signing papers': L('Signing papers', 'कागज़ों पर हस्ताक्षर'),
    'Study or exam': L('Study or exam', 'पढ़ाई या परीक्षा'),
  };

  /// What the number of the day brings, in simple words.
  static const Map<int, L> dayCharacter = {
    1: L('Number 1 (Sun) gives a strong start, leadership and name. Good for firsts: opening, launching, taking charge.',
        'अंक 1 (सूर्य) मज़बूत शुरुआत, नेतृत्व और नाम देता है। पहली बार की चीज़ों के लिए अच्छा: उद्घाटन, लॉन्च, ज़िम्मेदारी लेना।'),
    2: L('Number 2 (Moon) brings calm, partnership and goodwill. Good for joint work, family matters and gentle beginnings.',
        'अंक 2 (चंद्र) शांति, साझेदारी और सद्भाव लाता है। मिलकर काम, पारिवारिक बातों और नरम शुरुआत के लिए अच्छा।'),
    3: L('Number 3 (Jupiter) brings growth, advice and good luck from elders. Good for teaching, learning, finance and blessings.',
        'अंक 3 (गुरु) बढ़त, सलाह और बड़ों का आशीर्वाद लाता है। पढ़ाने-सीखने, पैसे के काम और शुभ कार्यों के लिए अच्छा।'),
    4: L('Number 4 (Rahu) is about unusual, technical and long-term work. Needs extra care and clear paperwork.',
        'अंक 4 (राहु) हटके, तकनीकी और लंबे काम से जुड़ा है। थोड़ी अतिरिक्त सावधानी और साफ़ कागज़ात चाहिए।'),
    5: L('Number 5 (Mercury) brings quick deals, communication and movement. Good for trade, travel, marketing and signing.',
        'अंक 5 (बुध) तेज़ सौदे, बातचीत और गति लाता है। व्यापार, यात्रा, मार्केटिंग और हस्ताक्षर के लिए अच्छा।'),
    6: L('Number 6 (Venus) brings comfort, beauty and harmony. Good for marriage, home, vehicle, luxury and creative work.',
        'अंक 6 (शुक्र) सुख, सुंदरता और तालमेल लाता है। विवाह, घर, गाड़ी, लग्ज़री और रचनात्मक काम के लिए अच्छा।'),
    7: L('Number 7 (Ketu) favours study, research and quiet focus. Less suited to loud launches.',
        'अंक 7 (केतु) पढ़ाई, शोध और शांत एकाग्रता के लिए ठीक है। ज़ोरदार लॉन्च के लिए कम अनुकूल।'),
    8: L('Number 8 (Saturn) rewards slow, steady, disciplined work. Good for property, iron, land and long contracts.',
        'अंक 8 (शनि) धीमे, स्थिर और अनुशासित काम को फल देता है। प्रॉपर्टी, लोहा, ज़मीन और लंबे अनुबंध के लिए अच्छा।'),
    9: L('Number 9 (Mars) gives energy, courage and drive. Good for action, sport, machines and brave decisions.',
        'अंक 9 (मंगल) ऊर्जा, साहस और जोश देता है। एक्शन, खेल, मशीन और हिम्मत वाले फ़ैसलों के लिए अच्छा।'),
  };

  /// Kinds of business traditionally linked with each number.
  static const Map<int, L> businessIdeas = {
    1: L('Own brand or shop, government or authority-related work, gold, management, politics, leadership roles, startups.',
        'अपना ब्रांड या दुकान, सरकारी या अधिकार वाले काम, सोना, मैनेजमेंट, राजनीति, लीडरशिप, स्टार्टअप।'),
    2: L('Milk and dairy, water, food and hospitality, cloth, silver, pearls, travel agency, counselling, partnerships.',
        'दूध-डेयरी, पानी, खाना और होटल, कपड़ा, चाँदी, मोती, ट्रैवल एजेंसी, काउंसलिंग, साझेदारी।'),
    3: L('Teaching and coaching, books and publishing, banking and finance, advice and consulting, law, temple-related work.',
        'पढ़ाना और कोचिंग, किताबें और प्रकाशन, बैंकिंग और फ़ाइनेंस, सलाह और कंसल्टिंग, कानून, धार्मिक काम।'),
    4: L('IT and software, electronics, technical repair, import-export, research, unusual or online ideas. Keep records very clean.',
        'आईटी और सॉफ़्टवेयर, इलेक्ट्रॉनिक्स, तकनीकी रिपेयर, आयात-निर्यात, शोध, हटके या ऑनलाइन आइडिया। हिसाब बहुत साफ़ रखें।'),
    5: L('Trading, agency and commission work, marketing, media, communication, courier, travel, online selling.',
        'ट्रेडिंग, एजेंसी और कमीशन, मार्केटिंग, मीडिया, कम्युनिकेशन, कूरियर, यात्रा, ऑनलाइन बिक्री।'),
    6: L('Beauty and fashion, jewellery, entertainment, hotels, interiors, vehicles, flowers, perfume, design and art.',
        'ब्यूटी और फ़ैशन, ज्वेलरी, मनोरंजन, होटल, इंटीरियर, गाड़ियाँ, फूल, इत्र, डिज़ाइन और कला।'),
    7: L('Research, writing, spiritual or healing work, online learning, technical consulting, quiet one-person services.',
        'शोध, लेखन, आध्यात्मिक या उपचार का काम, ऑनलाइन शिक्षा, तकनीकी सलाह, शांत एकल सेवाएँ।'),
    8: L('Real estate, construction, iron and steel, oil, mining, transport, factories, labour-based or long-term contracts.',
        'रियल एस्टेट, निर्माण, लोहा-स्टील, तेल, खनन, ट्रांसपोर्ट, फ़ैक्टरी, मज़दूरी या लंबे अनुबंध वाले काम।'),
    9: L('Defence and security, sports and fitness, machines and tools, land, surgery and medical, fire-related or action-based work.',
        'रक्षा और सुरक्षा, खेल और फ़िटनेस, मशीन और औज़ार, ज़मीन, सर्जरी और मेडिकल, आग या एक्शन वाले काम।'),
  };

  static const L launchTitle = L('Launching a business: name, date and logo', 'बिज़नेस शुरू करना: नाम, तारीख और लोगो');
  static const L launchBody = L(
    'Numerologists such as Sanjay B. Jumani teach that a new business works best when three numbers agree with the owner: '
    '(1) the launch date number, (2) the total of the business name, and (3) the main colour and number used in the logo. '
    'The usual method: pick a launch date whose day number and full-date number are friendly to your Mulank and Bhagyank, '
    'keep the business name total friendly to the same numbers (and not a heavy total such as 35 or 44), and use the colours '
    'of your friendly planet in the logo. This is a traditional belief, not proven science. Business success still depends '
    'on product, money, timing and hard work, so treat these numbers as one extra input.',
    'संजय बी. जुमानी जैसे अंकशास्त्री सिखाते हैं कि नया बिज़नेस तब बेहतर चलता है जब तीन अंक मालिक से मेल खाएँ: '
    '(1) शुरू करने की तारीख का अंक, (2) बिज़नेस के नाम का जोड़, और (3) लोगो का मुख्य रंग व अंक। '
    'आम तरीका: ऐसी तारीख चुनें जिसका दिन-अंक और पूरी-तिथि का अंक आपके मूलांक और भाग्यांक के मित्र हों, '
    'बिज़नेस के नाम का जोड़ भी उन्हीं के अनुकूल रखें (35 या 44 जैसा भारी जोड़ न हो), और लोगो में अपने मित्र ग्रह के रंग रखें। '
    'यह परंपरागत मान्यता है, प्रमाणित विज्ञान नहीं। बिज़नेस की सफलता प्रोडक्ट, पैसे, सही समय और मेहनत पर भी निर्भर है, '
    'इसलिए इन अंकों को एक अतिरिक्त आधार की तरह लें।');

  static const L practicalNote = L(
    'Always check practical factors first: availability, legal requirements, weather and family convenience. '
    'Where your family follows a panchang, consult it too.',
    'पहले व्यावहारिक बातें देखें: उपलब्धता, कानूनी ज़रूरतें, मौसम और परिवार की सुविधा। '
    'जहाँ परिवार पंचांग देखता है, उसे भी देखें।');

  static String _rel(Relation r, bool hi) {
    switch (r) {
      case Relation.friend:
        return hi ? 'मित्र' : 'friendly';
      case Relation.neutral:
        return hi ? 'सम' : 'neutral';
      case Relation.enemy:
        return hi ? 'विरोधी' : 'opposed';
    }
  }

  /// Reasons for one suggested date. [psychic] and [destiny] are the owner's
  /// Mulank and Bhagyank roots.
  static List<L> reasons(DateSuggestion s, int psychic, int destiny, String purpose) {
    final r1 = NumerologyTools.relation(s.dayNumber, psychic);
    final r2 = NumerologyTools.relation(s.fullNumber, destiny);
    final out = <L>[
      L(
        'Day number ${s.dayNumber} is ${_rel(r1, false)} with your Mulank $psychic.',
        'दिन का अंक ${s.dayNumber} आपके मूलांक $psychic के साथ ${_rel(r1, true)} है।',
      ),
      L(
        'Full date number ${s.fullNumber} is ${_rel(r2, false)} with your Bhagyank $destiny.',
        'पूरी तिथि का अंक ${s.fullNumber} आपके भाग्यांक $destiny के साथ ${_rel(r2, true)} है।',
      ),
    ];
    final fav = NumerologyTools.purposeFavoured[purpose] ?? const <int>{};
    final hits = <int>{
      if (fav.contains(s.dayNumber)) s.dayNumber,
      if (fav.contains(s.fullNumber)) s.fullNumber,
    };
    if (hits.isNotEmpty) {
      final list = (hits.toList()..sort()).join(', ');
      final pn = purposeNames[purpose] ?? L(purpose, purpose);
      out.add(L(
        'Number $list is traditionally linked with: ${pn.en}.',
        'अंक $list परंपरा में इस उद्देश्य से जुड़ा है: ${pn.hi}।',
      ));
    }
    final dc = dayCharacter[s.dayNumber];
    if (dc != null) out.add(dc);
    return out;
  }
}
