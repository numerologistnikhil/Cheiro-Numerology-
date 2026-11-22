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

/// Cheiro's own table for one birth number (from his "Book of Numbers"),
/// summarised in our own words. Dates are approximate.
class CheiroProfile {
  final L planet;
  final String birthDays;
  final L periods;
  final L days;
  final L colours;
  final L stones;
  final L friends;
  final L body;
  final L guardMonths;
  const CheiroProfile({
    required this.planet,
    required this.birthDays,
    required this.periods,
    required this.days,
    required this.colours,
    required this.stones,
    required this.friends,
    required this.body,
    required this.guardMonths,
  });
}

class CheiroTable {
  static const Map<int, CheiroProfile> byRoot = {
    1: CheiroProfile(
      planet: L('Sun', 'सूर्य'),
      birthDays: '1, 10, 19, 28',
      periods: L('Mid-July to late August; late March to late April', 'जुलाई के बीच से अगस्त के अंत तक; मार्च के अंत से अप्रैल के अंत तक'),
      days: L('Sunday, Monday', 'रविवार, सोमवार'),
      colours: L('Gold, yellow, bronze, golden brown', 'सुनहरा, पीला, काँसे जैसा, सुनहरा भूरा'),
      stones: L('Topaz, amber, yellow diamond', 'पुखराज, अंबर, पीला हीरा'),
      friends: L('2, 4, 7', '2, 4, 7'),
      body: L('Heart, circulation and eyes', 'हृदय, रक्त-संचार और आँखें'),
      guardMonths: L('October, December, January', 'अक्टूबर, दिसंबर, जनवरी'),
    ),
    2: CheiroProfile(
      planet: L('Moon', 'चंद्र'),
      birthDays: '2, 11, 20, 29',
      periods: L('Late June to late July', 'जून के अंत से जुलाई के अंत तक'),
      days: L('Sunday, Monday, Friday', 'रविवार, सोमवार, शुक्रवार'),
      colours: L('Green, cream, white (avoid black, purple, dark red)', 'हरा, क्रीम, सफ़ेद (काला, बैंगनी, गहरा लाल न पहनें)'),
      stones: L('Pearl, moonstone, pale green stones, jade', 'मोती, चंद्रकांत, हल्के हरे रत्न, जेड'),
      friends: L('1, 7 (and 4)', '1, 7 (और 4)'),
      body: L('Stomach and digestion', 'पेट और पाचन'),
      guardMonths: L('January, February, July', 'जनवरी, फ़रवरी, जुलाई'),
    ),
    3: CheiroProfile(
      planet: L('Jupiter', 'गुरु'),
      birthDays: '3, 12, 21, 30',
      periods: L('Late February to late March; late November to late December', 'फ़रवरी के अंत से मार्च के अंत तक; नवंबर के अंत से दिसंबर के अंत तक'),
      days: L('Thursday (most important), Friday, Tuesday', 'गुरुवार (सबसे अहम), शुक्रवार, मंगलवार'),
      colours: L('Mauve, violet, purple', 'हल्का बैंगनी, जामुनी, बैंगनी'),
      stones: L('Amethyst', 'जमुनिया (एमेथिस्ट)'),
      friends: L('6, 9', '6, 9'),
      body: L('Nerves and skin', 'नसें और त्वचा'),
      guardMonths: L('December, February, June, September', 'दिसंबर, फ़रवरी, जून, सितंबर'),
    ),
    4: CheiroProfile(
      planet: L('Uranus', 'अरुण (यूरेनस)'),
      birthDays: '4, 13, 22, 31',
      periods: L('Late June to late July; late July to August', 'जून के अंत से जुलाई के अंत तक; जुलाई के अंत से अगस्त तक'),
      days: L('Saturday, Sunday, Monday', 'शनिवार, रविवार, सोमवार'),
      colours: L('Half-shades, electric blue, grey', 'हल्के मिले-जुले रंग, बिजली जैसा नीला, स्लेटी'),
      stones: L('Sapphire', 'नीलम'),
      friends: L('1, 2, 7 (8 attracts but is not lucky)', '1, 2, 7 (8 खिंचाव देता है पर शुभ नहीं)'),
      body: L('Hard-to-explain aches, low mood, tiredness', 'अजीब दर्द, उदासी, थकान'),
      guardMonths: L('January, February, July, August, September', 'जनवरी, फ़रवरी, जुलाई, अगस्त, सितंबर'),
    ),
    5: CheiroProfile(
      planet: L('Mercury', 'बुध'),
      birthDays: '5, 14, 23',
      periods: L('Late May to late June; late August to late September', 'मई के अंत से जून के अंत तक; अगस्त के अंत से सितंबर के अंत तक'),
      days: L('Wednesday, Friday', 'बुधवार, शुक्रवार'),
      colours: L('Light grey, white, shimmering fabrics', 'हल्का स्लेटी, सफ़ेद, चमकदार कपड़े'),
      stones: L('Diamond (best in platinum)', 'हीरा (प्लैटिनम में सबसे अच्छा)'),
      friends: L('Gets on with almost every number', 'लगभग हर अंक से निभता है'),
      body: L('Nervous strain, sleeplessness', 'नसों का तनाव, नींद की कमी'),
      guardMonths: L('June, September, December', 'जून, सितंबर, दिसंबर'),
    ),
    6: CheiroProfile(
      planet: L('Venus', 'शुक्र'),
      birthDays: '6, 15, 24',
      periods: L('Late April to late May; late September to late October', 'अप्रैल के अंत से मई के अंत तक; सितंबर के अंत से अक्टूबर के अंत तक'),
      days: L('Tuesday, Thursday, Friday', 'मंगलवार, गुरुवार, शुक्रवार'),
      colours: L('Blue, rose, pink (avoid black and dark purple)', 'नीला, गुलाबी (काला और गहरा बैंगनी न पहनें)'),
      stones: L('Turquoise (emerald also lucky)', 'फ़िरोज़ा (पन्ना भी शुभ)'),
      friends: L('3, 9', '3, 9'),
      body: L('Throat, nose, upper chest; heart in later years', 'गला, नाक, ऊपरी छाती; बाद के सालों में हृदय'),
      guardMonths: L('May, October, November', 'मई, अक्टूबर, नवंबर'),
    ),
    7: CheiroProfile(
      planet: L('Neptune', 'वरुण (नेपच्यून)'),
      birthDays: '7, 16, 25',
      periods: L('Late June to late July', 'जून के अंत से जुलाई के अंत तक'),
      days: L('Sunday, Monday', 'रविवार, सोमवार'),
      colours: L('Green, pale shades, white, yellow', 'हरा, हल्के रंग, सफ़ेद, पीला'),
      stones: L('Moonstone, cat\'s eye, moss agate', 'चंद्रकांत, लहसुनिया, मॉस एगेट'),
      friends: L('2 (and 1, 4)', '2 (और 1, 4)'),
      body: L('Worry and skin sensitivity', 'चिंता और त्वचा की संवेदनशीलता'),
      guardMonths: L('January, February, July, August', 'जनवरी, फ़रवरी, जुलाई, अगस्त'),
    ),
    8: CheiroProfile(
      planet: L('Saturn', 'शनि'),
      birthDays: '8, 17, 26',
      periods: L('Late December to mid-February', 'दिसंबर के अंत से फ़रवरी के बीच तक'),
      days: L('Saturday, Sunday, Monday', 'शनिवार, रविवार, सोमवार'),
      colours: L('Dark grey, black, dark blue, purple', 'गहरा स्लेटी, काला, गहरा नीला, बैंगनी'),
      stones: L('Amethyst, dark sapphire, black pearl, black diamond', 'जमुनिया, गहरा नीलम, काला मोती, काला हीरा'),
      friends: L('No clear friend in the book; 4 attracts but is not lucky; avoid 2 and 9', 'किताब में कोई साफ़ मित्र नहीं; 4 खिंचाव देता है पर शुभ नहीं; 2 और 9 से बचें'),
      body: L('Liver, digestion, headaches, joints', 'यकृत, पाचन, सिरदर्द, जोड़'),
      guardMonths: L('December, January, February, July', 'दिसंबर, जनवरी, फ़रवरी, जुलाई'),
    ),
    9: CheiroProfile(
      planet: L('Mars', 'मंगल'),
      birthDays: '9, 18, 27',
      periods: L('Late March to mid-April; late October to late November', 'मार्च के अंत से अप्रैल के बीच तक; अक्टूबर के अंत से नवंबर के अंत तक'),
      days: L('Tuesday (best), Thursday, Friday', 'मंगलवार (सबसे अच्छा), गुरुवार, शुक्रवार'),
      colours: L('Crimson, red, rose, pink', 'गहरा लाल, लाल, गुलाबी'),
      stones: L('Ruby, garnet, bloodstone', 'माणिक, गार्नेट, ब्लडस्टोन'),
      friends: L('1, 3, 5, 6', '1, 3, 5, 6'),
      body: L('Fevers and accidents; many with this number face operations', 'बुख़ार और दुर्घटनाएँ; इस अंक वाले कई लोगों के ऑपरेशन होते हैं'),
      guardMonths: L('April, May, October, November', 'अप्रैल, मई, अक्टूबर, नवंबर'),
    ),
  };
}
