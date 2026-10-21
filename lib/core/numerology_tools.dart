import 'numerology_engine.dart';

/// How two numbers relate in traditional Chaldean / Cheiro-style guidance.
enum Relation { friend, neutral, enemy }

class YearTheme {
  final String title;
  final String theme;
  final String focus;
  final String caution;
  const YearTheme(this.title, this.theme, this.focus, this.caution);
}

class RemedyInfo {
  final String planet;
  final String colours;
  final String day;
  final String gemstone;
  final String metal;
  final String charity;
  final String practice;
  const RemedyInfo(
    this.planet,
    this.colours,
    this.day,
    this.gemstone,
    this.metal,
    this.charity,
    this.practice,
  );
}

class BabyName {
  final String name;
  final String meaning;
  final bool boy;
  const BabyName(this.name, this.meaning, this.boy);
}

class NameSuggestion {
  final BabyName baby;
  final NumerologyResult result;
  final int score;
  const NameSuggestion(this.baby, this.result, this.score);
}

class CompatibilityResult {
  final int score;
  final int maxScore;
  final String label;
  final String advice;
  final List<String> lines;
  const CompatibilityResult(
    this.score,
    this.maxScore,
    this.label,
    this.advice,
    this.lines,
  );
}

class DateSuggestion {
  final DateTime date;
  final int dayNumber;
  final int fullNumber;
  final int score;
  const DateSuggestion(this.date, this.dayNumber, this.fullNumber, this.score);
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int answer;
  final String explanation;
  const QuizQuestion(this.question, this.options, this.answer, this.explanation);
}

class Lesson {
  final String title;
  final String body;
  const Lesson(this.title, this.body);
}

/// Pure-Dart helpers used by the module screens. No Flutter imports so that
/// everything here can be unit tested.
class NumerologyTools {
  // ---------------------------------------------------------------- planets

  static const Map<int, String> planets = {
    1: 'Sun',
    2: 'Moon',
    3: 'Jupiter',
    4: 'Uranus / Rahu',
    5: 'Mercury',
    6: 'Venus',
    7: 'Neptune / Ketu',
    8: 'Saturn',
    9: 'Mars',
  };

  static String planetOf(int root) => planets[root] ?? '-';

  // ------------------------------------------------------------ relations

  static const Set<String> _friendPairs = {
    '1-2', '1-3', '1-5', '1-7', '1-9', '2-3', '2-5', '2-7', '3-9',
    '4-8', '5-6', '5-7', '6-8',
  };

  static const Set<String> _enemyPairs = {
    '1-8', '2-4', '2-8', '3-5', '3-6', '4-9', '8-9',
  };

  static Relation relation(int a, int b) {
    if (a == b) return Relation.friend;
    final key = a < b ? '$a-$b' : '$b-$a';
    if (_friendPairs.contains(key)) return Relation.friend;
    if (_enemyPairs.contains(key)) return Relation.enemy;
    return Relation.neutral;
  }

  static int points(Relation r) {
    switch (r) {
      case Relation.friend:
        return 2;
      case Relation.neutral:
        return 1;
      case Relation.enemy:
        return 0;
    }
  }

  static String relationLabel(Relation r) {
    switch (r) {
      case Relation.friend:
        return 'Friendly';
      case Relation.neutral:
        return 'Neutral';
      case Relation.enemy:
        return 'Challenging';
    }
  }

  // ------------------------------------------------------- compatibility

  static CompatibilityResult compatibility(DateTime a, DateTime b) {
    final na = NumerologyEngine.birth(a);
    final nb = NumerologyEngine.birth(b);
    final pairs = <List<int>>[
      [na.psychic.root, nb.psychic.root],
      [na.destiny.root, nb.destiny.root],
      [na.psychic.root, nb.destiny.root],
      [na.destiny.root, nb.psychic.root],
    ];
    const names = [
      'Psychic with Psychic',
      'Destiny with Destiny',
      'First psychic with second destiny',
      'First destiny with second psychic',
    ];
    var score = 0;
    final lines = <String>[];
    for (var i = 0; i < pairs.length; i++) {
      final r = relation(pairs[i][0], pairs[i][1]);
      score += points(r);
      lines.add('${names[i]}: ${pairs[i][0]} and ${pairs[i][1]} - '
          '${relationLabel(r)}');
    }
    String label;
    String advice;
    if (score >= 6) {
      label = 'Strong harmony';
      advice = 'Your numbers support each other well. Natural understanding '
          'is likely, so keep communication open and do not take the ease '
          'for granted.';
    } else if (score >= 4) {
      label = 'Balanced';
      advice = 'There is a healthy mix of support and difference. Respect '
          'each other\'s style and use the differences to cover each '
          'other\'s gaps.';
    } else {
      label = 'Needs conscious effort';
      advice = 'The numbers pull in different directions. This is not a '
          'verdict on the relationship; patience, clear talk and shared '
          'goals matter far more than any number.';
    }
    return CompatibilityResult(score, 8, label, advice, lines);
  }

  // ------------------------------------------------------ personal cycles

  /// Personal year = root of (day digits + month digits + year digits).
  static int personalYear(DateTime birth, int year) {
    final sum = NumerologyEngine.digitSum(birth.day) +
        NumerologyEngine.digitSum(birth.month) +
        NumerologyEngine.digitSum(year);
    return NumerologyEngine.root(sum);
  }

  /// Personal month = root of (personal year + calendar month).
  static int personalMonth(DateTime birth, int year, int month) {
    return NumerologyEngine.root(personalYear(birth, year) + month);
  }

  static const Map<int, YearTheme> yearThemes = {
    1: YearTheme(
      'A year of new beginnings',
      'A fresh nine-year cycle starts. Seeds planted now, such as a new '
          'job, project, habit or decision, tend to shape the years ahead.',
      'Take initiative, start what you have been postponing, and stand on '
          'your own judgement.',
      'Impatience and going it alone. Avoid rushing into commitments only '
          'to prove a point.',
    ),
    2: YearTheme(
      'A year of patience and partnership',
      'Progress is slower and quieter. The emphasis is on cooperation, '
          'listening and letting earlier efforts mature.',
      'Build relationships, work in teams, and pay attention to details and '
          'timing.',
      'Over-sensitivity and indecision. Do not push for results before they '
          'are ready.',
    ),
    3: YearTheme(
      'A year of expression and growth',
      'Communication, creativity and social life come forward. Opportunities '
          'often arrive through people and ideas.',
      'Share your work, learn, travel short distances and widen your circle.',
      'Scattered energy and spending on show. Finish what you start.',
    ),
    4: YearTheme(
      'A year of foundations and discipline',
      'A practical, hard-working year. Structure, paperwork, health routines '
          'and long-term planning are rewarded.',
      'Organise finances, improve systems and build steadily.',
      'Rigidity and burnout. Schedule rest and stay flexible when plans '
          'change.',
    ),
    5: YearTheme(
      'A year of change and movement',
      'Expect variety, travel, new contacts and sudden turns. Freedom and '
          'adaptability are the keywords.',
      'Be open to change, update your skills and make use of new '
          'opportunities.',
      'Restlessness and impulsive decisions. Keep a safety margin with '
          'money and promises.',
    ),
    6: YearTheme(
      'A year of home and responsibility',
      'Family, home, commitments and relationships take centre stage. Care '
          'for others is a major theme.',
      'Strengthen family bonds, improve your living space and honour '
          'commitments.',
      'Over-giving and worrying about others. Keep healthy boundaries.',
    ),
    7: YearTheme(
      'A year of reflection and study',
      'A more inward year. Learning, research, rest and spiritual interests '
          'matter more than outer speed.',
      'Study, plan, review the past and spend time alone to think clearly.',
      'Withdrawal and doubt. Do not force big launches; prepare instead.',
    ),
    8: YearTheme(
      'A year of authority and results',
      'Work, money and responsibility are in focus. Effort made earlier can '
          'bring recognition, along with heavier duties.',
      'Lead with fairness, manage money carefully and aim for solid '
          'achievements.',
      'Pressure, control and workaholism. Avoid risky shortcuts.',
    ),
    9: YearTheme(
      'A year of completion',
      'A cycle closes. Finishing old matters, letting go and helping others '
          'prepare the ground for the next cycle.',
      'Complete pending work, forgive, clear clutter and give generously.',
      'Clinging to what is ending. Avoid starting major long-term ventures '
          'if they can wait.',
    ),
  };

  static const Map<int, String> monthHints = {
    1: 'Good month to start or decide something.',
    2: 'Go slowly; cooperate and wait for the right moment.',
    3: 'Good for communication, creative work and meeting people.',
    4: 'Focus on routine, paperwork and steady effort.',
    5: 'Expect change; stay flexible and keep options open.',
    6: 'Family and responsibilities need attention.',
    7: 'Quiet month for study, rest and thinking.',
    8: 'Work and money matters are active; act carefully.',
    9: 'Wrap up pending tasks; avoid fresh big commitments.',
  };

  // ------------------------------------------------------------- remedies

  static const Map<int, RemedyInfo> remedies = {
    1: RemedyInfo(
      'Sun',
      'Gold, orange, warm yellow',
      'Sunday',
      'Ruby (traditional); garnet is a milder alternative',
      'Gold or copper',
      'Offer wheat or jaggery; help those in authority-related need',
      'Start the day with sunlight and a few minutes of quiet planning.',
    ),
    2: RemedyInfo(
      'Moon',
      'White, cream, silver, pale green',
      'Monday',
      'Pearl or moonstone',
      'Silver',
      'Offer milk, rice or water to those in need',
      'Keep a regular sleep time and spend a few minutes near water or '
          'greenery.',
    ),
    3: RemedyInfo(
      'Jupiter',
      'Yellow, saffron, deep gold',
      'Thursday',
      'Yellow sapphire or citrine',
      'Gold',
      'Support teachers, students or books for learning',
      'Study something daily, even for ten minutes, and share what you '
          'learn.',
    ),
    4: RemedyInfo(
      'Uranus / Rahu',
      'Blue-grey, electric blue, earthy tones',
      'Saturday',
      'Hessonite (gomed) in the Indian tradition',
      'Mixed metal or silver',
      'Feed birds or help with practical needs of workers',
      'Keep your space orderly and write plans down before acting.',
    ),
    5: RemedyInfo(
      'Mercury',
      'Green, light grey, white',
      'Wednesday',
      'Emerald or green tourmaline',
      'Bronze or silver',
      'Donate books, stationery or support a child\'s education',
      'Keep a small journal and review decisions before committing.',
    ),
    6: RemedyInfo(
      'Venus',
      'White, pink, soft blue, pastel shades',
      'Friday',
      'Diamond, white sapphire or opal',
      'Silver or platinum',
      'Help with weddings, family needs or women\'s welfare causes',
      'Add beauty and cleanliness to your home; make time for loved ones.',
    ),
    7: RemedyInfo(
      'Neptune / Ketu',
      'Sea green, light grey, smoky shades',
      'Monday or Thursday',
       'Cat\'s eye (traditional); moonstone is gentler',
      'Silver',
      'Support spiritual or learning centres',
      'Meditate or walk in silence for ten minutes each day.',
    ),
    8: RemedyInfo(
      'Saturn',
      'Dark blue, black, deep grey',
      'Saturday',
      'Blue sapphire in tradition; strong effects are claimed, so avoid '
          'wearing it without expert advice. Amethyst is a milder choice',
      'Iron or steel',
      'Help workers, the elderly or the disabled; keep promises on time',
      'Follow a fixed routine and finish tasks on schedule.',
    ),
    9: RemedyInfo(
      'Mars',
      'Red, maroon, coral pink',
      'Tuesday',
      'Red coral or carnelian',
      'Copper',
      'Support blood donation drives or help those in distress',
      'Channel energy into exercise and keep your temper in check.',
    ),
  };

  // ---------------------------------------------------------- professions

  static const Map<int, List<String>> professions = {
    1: [
      'Management and leadership roles',
      'Government and administration',
      'Entrepreneurship and own business',
      'Politics and public service',
      'Sales leadership, directing and producing',
    ],
    2: [
      'Counselling, hospitality and care work',
      'Teaching and training',
      'Arts, music and design',
      'Diplomacy, negotiation and partnerships',
      'Nutrition, dairy and water-related business',
    ],
    3: [
      'Teaching, law and advisory work',
      'Writing, speaking and media',
      'Banking, finance and consulting',
      'Religious or educational institutions',
      'Event and communication management',
    ],
    4: [
      'Engineering, construction and real estate',
      'Technology and systems work',
      'Accounting, auditing and compliance',
      'Research and investigation',
      'Unconventional or technical start-ups',
    ],
    5: [
      'Trading, marketing and advertising',
      'Travel, transport and logistics',
      'Journalism, writing and communication',
      'Finance, stock markets and analytics',
      'Sales and customer-facing roles',
    ],
    6: [
      'Fashion, beauty, art and design',
      'Hospitality, food and entertainment',
      'Healthcare and wellness support',
      'Luxury goods, jewellery and interiors',
      'Family business and service roles',
    ],
    7: [
      'Research, science and analysis',
      'Philosophy, spirituality and counselling',
      'Writing, editing and technical specialities',
      'Software, data and investigation',
      'Healing and alternative therapies',
    ],
    8: [
      'Large organisations and administration',
      'Law, justice and property',
      'Mining, iron, oil and heavy industry',
      'Finance, banking and management',
      'Long-term business building',
    ],
    9: [
      'Defence, police, sports and fitness',
      'Surgery, engineering and technical trades',
      'Real estate and construction',
      'Social work, activism and leadership of causes',
      'Energy and action-oriented ventures',
    ],
  };

  // ------------------------------------------------------------- business

  /// 0-4: friendliness of a business name root with the owner's psychic and
  /// destiny numbers (2 points for friend, 1 neutral, 0 challenging each).
  static int businessScore(int businessRoot, int psychic, int destiny) {
    return points(relation(businessRoot, psychic)) +
        points(relation(businessRoot, destiny));
  }

  static String businessVerdict(int score) {
    if (score >= 3) {
      return 'Supportive match with the owner\'s numbers.';
    }
    if (score == 2) {
      return 'Acceptable match. Check the compound number below as well.';
    }
    return 'Weak match with the owner\'s numbers. Consider alternate '
        'spellings or a different name.';
  }

  // ------------------------------------------------------------ baby names

  static const List<BabyName> babyNames = [
    BabyName('Aarav', 'Peaceful, calm', true),
    BabyName('Advik', 'Unique', true),
    BabyName('Arjun', 'Bright, shining', true),
    BabyName('Aryan', 'Noble', true),
    BabyName('Ayaan', 'Gift of God', true),
    BabyName('Dev', 'Divine', true),
    BabyName('Dhruv', 'Pole star, steady', true),
    BabyName('Harsh', 'Joy', true),
    BabyName('Ishaan', 'The sun, lord Shiva', true),
    BabyName('Kabir', 'Great, powerful', true),
    BabyName('Karan', 'Ear; a warrior hero', true),
    BabyName('Krish', 'Dark; a name of Krishna', true),
    BabyName('Lakshya', 'Goal, aim', true),
    BabyName('Manav', 'Human, kind', true),
    BabyName('Mohan', 'Charming', true),
    BabyName('Nikhil', 'Complete, whole', true),
    BabyName('Pranav', 'The sacred sound Om', true),
    BabyName('Rahul', 'Efficient, capable', true),
    BabyName('Rohan', 'Ascending', true),
    BabyName('Sahil', 'Guide, shore', true),
    BabyName('Samar', 'Battle; lively', true),
    BabyName('Shaurya', 'Bravery', true),
    BabyName('Tanmay', 'Absorbed', true),
    BabyName('Veer', 'Brave', true),
    BabyName('Vihaan', 'Dawn, new beginning', true),
    BabyName('Yash', 'Fame, glory', true),
    BabyName('Aadhya', 'First power', false),
    BabyName('Aanya', 'Graceful, caring', false),
    BabyName('Aditi', 'Boundless', false),
    BabyName('Anika', 'Grace', false),
    BabyName('Anvi', 'Gentle, a goddess', false),
    BabyName('Diya', 'Lamp', false),
    BabyName('Ira', 'Earth, speech', false),
    BabyName('Ishita', 'Desired, superior', false),
    BabyName('Kavya', 'Poetry', false),
    BabyName('Kiara', 'Bright, clear', false),
    BabyName('Meera', 'Devotee, prosperous', false),
    BabyName('Myra', 'Beloved, admirable', false),
    BabyName('Navya', 'New, young', false),
    BabyName('Nisha', 'Night', false),
    BabyName('Pari', 'Fairy', false),
    BabyName('Priya', 'Beloved', false),
    BabyName('Riya', 'Singer; graceful', false),
    BabyName('Saanvi', 'Goddess Lakshmi', false),
    BabyName('Sara', 'Princess; essence', false),
    BabyName('Tara', 'Star', false),
    BabyName('Vanya', 'Gracious, forest', false),
    BabyName('Zoya', 'Alive, loving', false),
  ];

  /// Names whose root is not challenging for either birth number, best first.
  static List<NameSuggestion> suggestNames(
    DateTime baby, {
    required bool boy,
    String startsWith = '',
  }) {
    final birth = NumerologyEngine.birth(baby);
    final prefix = startsWith.trim().toUpperCase();
    final out = <NameSuggestion>[];
    for (final b in babyNames) {
      if (b.boy != boy) continue;
      if (prefix.isNotEmpty && !b.name.toUpperCase().startsWith(prefix)) {
        continue;
      }
      final result = NumerologyEngine.name(b.name);
      final r1 = relation(result.root, birth.psychic.root);
      final r2 = relation(result.root, birth.destiny.root);
      if (r1 == Relation.enemy || r2 == Relation.enemy) continue;
      out.add(NameSuggestion(b, result, points(r1) + points(r2)));
    }
    out.sort((x, y) {
      final c = y.score.compareTo(x.score);
      return c != 0 ? c : x.baby.name.compareTo(y.baby.name);
    });
    return out;
  }

  // -------------------------------------------------------- date selection

  static const Map<String, Set<int>> purposeFavoured = {
    'Marriage': {2, 6, 3},
    'Business start': {1, 3, 5, 6},
    'Property / vehicle': {4, 6, 8},
    'Travel': {5, 3},
    'Signing papers': {1, 3, 5, 8},
    'Study or exam': {3, 5, 1},
  };

  static List<DateSuggestion> suggestDates(
    DateTime birth,
    String purpose,
    DateTime from, {
    int days = 45,
    int top = 8,
  }) {
    final b = NumerologyEngine.birth(birth);
    final favoured = purposeFavoured[purpose] ?? const <int>{};
    final start = DateTime(from.year, from.month, from.day);
    final out = <DateSuggestion>[];
    for (var i = 0; i < days; i++) {
      final d = start.add(Duration(days: i));
      final dayNum = NumerologyEngine.root(d.day);
      final full = NumerologyEngine.date(d).root;
      final r1 = relation(dayNum, b.psychic.root);
      final r2 = relation(full, b.destiny.root);
      if (r1 == Relation.enemy || r2 == Relation.enemy) continue;
      var score = points(r1) + points(r2);
      if (favoured.contains(dayNum)) score += 1;
      if (favoured.contains(full)) score += 1;
      out.add(DateSuggestion(d, dayNum, full, score));
    }
    out.sort((x, y) {
      final c = y.score.compareTo(x.score);
      return c != 0 ? c : x.date.compareTo(y.date);
    });
    final best = out.take(top).toList();
    best.sort((x, y) => x.date.compareTo(y.date));
    return best;
  }

  // ----------------------------------------------------------------- learn

  static const List<Lesson> lessons = [
    Lesson(
      '1. What is numerology?',
      'Numerology studies the symbolism of numbers connected to a person: '
          'birth date, name, mobile and vehicle numbers. It is a traditional '
          'interpretive system for reflection, not a science, and it does '
          'not predict or guarantee outcomes. Use it as one lens for '
          'self-understanding alongside your own judgement and professional '
          'advice where needed.',
    ),
    Lesson(
      '2. The Chaldean letter values',
      'In the Chaldean system letters carry values from 1 to 8. The number 9 '
          'is considered sacred and is not given to any letter. For example, '
          'A, I, J, Q, Y are 1; B, K, R are 2; C, G, L, S are 3; D, M, T are '
          '4; E, H, N, X are 5; U, V, W are 6; O, Z are 7; F and P are 8.',
    ),
    Lesson(
      '3. Root and compound numbers',
      'A raw total such as 32 is the compound number. Adding its digits '
          'gives the root number: 3 + 2 = 5. Cheiro gave special meaning to '
          'compound numbers from 10 to 52, so this app reads the compound '
          'first and then the root.',
    ),
    Lesson(
      '4. Psychic and destiny numbers',
      'The psychic number comes from the day of birth only and describes '
          'your inner nature and how you see yourself. The destiny number '
          'comes from every digit of day, month and year and describes the '
          'path and lessons of life. Born on 6 April 1988: psychic is 6; '
          'destiny is 6+4+1+9+8+8 = 36, which reduces to 9.',
    ),
    Lesson(
      '5. Numbers and their planets',
      '1 Sun, 2 Moon, 3 Jupiter, 4 Uranus (Rahu), 5 Mercury, 6 Venus, '
          '7 Neptune (Ketu), 8 Saturn, 9 Mars. These associations give each '
          'number its character: for example the Sun for leadership and '
          'Venus for harmony and relationships.',
    ),
    Lesson(
      '6. Name numbers',
      'Your name is the vibration others call you by. The compound number '
          'of the full name shows how you are perceived and how you act in '
          'daily life. Name correction compares small spelling changes and '
          'checks that the new total suits your birth numbers. Choose a '
          'spelling you are comfortable using consistently.',
    ),
    Lesson(
      '7. Using numerology wisely',
      'Numbers describe tendencies, not fate. Do not make medical, legal or '
          'major financial decisions on numerology alone. A challenging '
          'number is simply an area where extra awareness helps, and every '
          'number has strengths.',
    ),
  ];

  static const List<QuizQuestion> quiz = [
    QuizQuestion(
      'Which number is NOT assigned to any letter in the Chaldean system?',
      ['5', '8', '9', '1'],
      2,
      'The number 9 is considered sacred and is left out of the letter table.',
    ),
    QuizQuestion(
      'What is the root number of 32?',
      ['3', '5', '2', '7'],
      1,
      '3 + 2 = 5.',
    ),
    QuizQuestion(
      'The psychic number is calculated from...',
      [
        'The full birth date',
        'The month only',
        'The day of birth only',
        'The name',
      ],
      2,
      'The psychic number uses the day of the month only.',
    ),
    QuizQuestion(
      'Which planet is associated with number 1?',
      ['Moon', 'Sun', 'Mars', 'Venus'],
      1,
      'The Sun rules number 1.',
    ),
    QuizQuestion(
      'Which letter has the Chaldean value 8?',
      ['F', 'M', 'S', 'E'],
      0,
      'F and P carry the value 8.',
    ),
    QuizQuestion(
      'What compound range does this app use?',
      ['1 to 99', '10 to 54', '10 to 52', '1 to 9'],
      2,
      'The Cheiro original series of compound numbers runs from 10 to 52.',
    ),
    QuizQuestion(
      'What is the destiny number of someone born on 6 April 1988?',
      ['6', '9', '8', '5'],
      1,
      '6+4+1+9+8+8 = 36, and 3 + 6 = 9.',
    ),
    QuizQuestion(
      'Which planet is linked with number 6?',
      ['Saturn', 'Jupiter', 'Venus', 'Mercury'],
      2,
      'Venus rules number 6.',
    ),
    QuizQuestion(
      'What is the root of 99?',
      ['9', '18', '1', '0'],
      0,
      '9 + 9 = 18, then 1 + 8 = 9.',
    ),
    QuizQuestion(
      'Numerology is best used as...',
      [
        'A guarantee of results',
        'A replacement for professional advice',
        'A tool for reflection',
        'A medical diagnosis',
      ],
      2,
      'It is an interpretive lens for reflection, not a guarantee.',
    ),
  ];
}
