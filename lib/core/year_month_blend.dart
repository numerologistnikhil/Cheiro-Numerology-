import 'numerology_tools.dart';
import 'report_pages.dart' show PBi;

/// A short line that joins the personal year with the personal month, so each
/// of the 81 combinations (year 1-9 with month 1-9) reads differently.
class YearMonthBlend {
  static const PBi label = PBi('Year and month together', 'वर्ष और महीना मिलकर');

  // How the year feels, used as the first half of the line.
  static const Map<int, PBi> yearPart = {
    1: PBi('In a year of new starts', 'नई शुरुआत के वर्ष में'),
    2: PBi('In a year that asks for patience and partnership', 'धैर्य और साझेदारी माँगने वाले वर्ष में'),
    3: PBi('In a year of learning, growth and expression', 'सीखने, बढ़ने और अभिव्यक्ति के वर्ष में'),
    4: PBi('In a year of building and hard work', 'निर्माण और मेहनत के वर्ष में'),
    5: PBi('In a year of change and movement', 'बदलाव और हलचल के वर्ष में'),
    6: PBi('In a year centred on family and responsibility', 'परिवार और ज़िम्मेदारी वाले वर्ष में'),
    7: PBi('In a year of study, rest and inner work', 'अध्ययन, विश्राम और भीतरी काम के वर्ष में'),
    8: PBi('In a year of effort, results and responsibility', 'मेहनत, नतीजों और ज़िम्मेदारी के वर्ष में'),
    9: PBi('In a year of finishing and letting go', 'पूरा करने और छोड़ने के वर्ष में'),
  };

  // What this month adds.
  static const Map<int, PBi> monthPart = {
    1: PBi('this month gives you a chance to start something and take the lead', 'यह महीना कुछ शुरू करने और आगे बढ़कर नेतृत्व लेने का मौका देता है'),
    2: PBi('this month is soft and slow, so listen, cooperate and do not rush', 'यह महीना नरम और धीमा है, इसलिए सुनिए, सहयोग कीजिए और जल्दबाज़ी न कीजिए'),
    3: PBi('this month brings ideas, advice and good company', 'यह महीना विचार, सलाह और अच्छी संगति लाता है'),
    4: PBi('this month asks for discipline, order and steady work', 'यह महीना अनुशासन, व्यवस्था और लगातार काम माँगता है'),
    5: PBi('this month brings quick news, travel and deals', 'यह महीना जल्दी खबरें, यात्रा और सौदे लाता है'),
    6: PBi('this month turns attention to home, love and comfort', 'यह महीना घर, प्रेम और सुख की ओर ध्यान मोड़ता है'),
    7: PBi('this month favours quiet thinking, study and rest', 'यह महीना शांत सोच, अध्ययन और विश्राम के अनुकूल है'),
    8: PBi('this month brings responsibility, money matters and slow but solid results', 'यह महीना ज़िम्मेदारी, पैसे के मामले और धीमे पर ठोस नतीजे लाता है'),
    9: PBi('this month brings energy and the push to finish what is pending', 'यह महीना ऊर्जा और अधूरे काम निपटाने का जोश लाता है'),
  };

  static const PBi same = PBi(
    'Because the year and the month carry the same number, its message is doubled. Use the strengths freely and watch its weak side more closely.',
    'वर्ष और महीना एक ही अंक के हैं, इसलिए उसका संदेश दोगुना हो जाता है। ताकत खुलकर इस्तेमाल कीजिए और उसके कमज़ोर पहलू पर ज़्यादा नज़र रखिए।');
  static const PBi friend = PBi(
    'The two numbers are friendly, so this is a smoother, more supportive time to move ahead.',
    'दोनों अंक मित्र हैं, इसलिए आगे बढ़ने के लिए यह ज़्यादा सहज और सहयोगी समय है।');
  static const PBi neutral = PBi(
    'The two numbers neither help nor oppose each other, so steady effort decides the result.',
    'दोनों अंक न एक-दूसरे की मदद करते हैं, न विरोध, इसलिए नतीजा लगातार मेहनत से तय होगा।');
  static const PBi enemy = PBi(
    'The two numbers pull in different directions, so go a little slower, double-check papers and money, and be patient with people.',
    'दोनों अंक अलग दिशाओं में खींचते हैं, इसलिए थोड़ा धीमे चलिए, कागज़ और पैसे दोबारा जाँचिए और लोगों के साथ धैर्य रखिए।');

  static PBi relationPart(int year, int month) {
    if (year == month) return same;
    switch (NumerologyTools.relation(year, month)) {
      case Relation.friend:
        return friend;
      case Relation.enemy:
        return enemy;
      case Relation.neutral:
        return neutral;
    }
  }

  /// One line for the given personal year and personal month (1 to 9 each).
  static PBi line(int year, int month) {
    final y = yearPart[year] ?? yearPart[1]!;
    final m = monthPart[month] ?? monthPart[1]!;
    final r = relationPart(year, month);
    return PBi(
      '${y.en}, ${m.en}. ${r.en}',
      '${y.hi}, ${m.hi}। ${r.hi}',
    );
  }
}
