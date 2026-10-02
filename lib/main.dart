import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const CheiroNumerologyApp());
}

class CheiroNumerologyApp extends StatelessWidget {
  const CheiroNumerologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheiro Numerology Elite Master',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        primaryColor: const Color(0xFFD4AF37),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4AF37),
          primary: const Color(0xFFD4AF37),
          surface: Colors.white,
        ),
      ),
      home: const SelectionContainer.disabled(
        child: HomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _partnerNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();

  int? _compoundNumber;
  int? _singleNumber;
  int? _personalYear;
  int? _mobileCompound;
  int? _vehicleCompound;
  String _title = '';
  String _description = '';
  String _planet = '';
  String _dobAnalysis = '';
  String _compatibilityResult = '';
  String _mobileResult = '';
  String _vehicleResult = '';
  Map<int, int> _loShuCounts = {};
  List<int> _missingNumbers = [];
  List<Map<String, dynamic>> _luckyVariations = [];

  final Map<String, int> chaldeanMap = {
    'A': 1, 'I': 1, 'J': 1, 'Q': 1, 'Y': 1,
    'B': 2, 'K': 2, 'R': 2,
    'C': 3, 'G': 3, 'L': 3, 'S': 3,
    'D': 4, 'M': 4, 'T': 4,
    'E': 5, 'H': 5, 'N': 5, 'X': 5,
    'U': 6, 'V': 6, 'W': 6,
    'O': 7, 'Z': 7,
    'F': 8, 'P': 8,
  };

  // Exhaustive Comprehensive Local Database (10 to 98)
  final Map<int, Map<String, String>> eliteDatabase = {
    10: {
      'title': 'The Wheel of Fortune (10)',
      'planet': 'Ruling Energy: Surya (The Sun)',
      'desc': 'Represents honor, faith, self-elevation, and supreme confidence. A highly fortunate number where plans are successfully carried out.'
    },
    11: {
      'title': 'Hidden Trials & Secrets (11)',
      'planet': 'Ruling Energy: Karmic Test Matrix',
      'desc': 'Carries hidden trials, treachery from false friends, and tests of endurance. Requires careful name balancing.'
    },
    12: {
      'title': 'The Sacrifice & Anxiety (12)',
      'planet': 'Ruling Energy: Trial Vibration',
      'desc': 'Often indicates being used or sacrificed for the plans of others. Requires conscious fortification and boundary setting.'
    },
    13: {
      'title': 'Transformation & Upheaval (13)',
      'planet': 'Ruling Energy: Radical Shift Energy',
      'desc': 'Associated with powerful transformation, destruction of old structures, and rebuilding. Brings immense inner power if handled wisely.'
    },
    14: {
      'title': 'Motion, Combination & Commerce (14)',
      'planet': 'Ruling Energy: Mercury & Venus Synergy',
      'desc': 'Fortunate for dealings involving money, commerce, and exchange. Warns against risks from speculation and elements.'
    },
    15: {
      'title': 'The Number of Magicians & Magnetism (15)',
      'planet': 'Ruling Energy: Venus & Mercury Matrix',
      'desc': 'Extremely fortunate for acquiring wealth, eloquence, art, and public magnetism. Brings unexpected alliances and influential support.'
    },
    16: {
      'title': 'The Shattered Citadel (16)',
      'planet': 'Ruling Energy: Karmic Warning Vibration',
      'desc': 'Warns of sudden downfall, accidents, or misplaced trust. Strongly advises name correction to a fortunate compound.'
    },
    17: {
      'title': 'The Star of the Magi (17)',
      'planet': 'Ruling Energy: Venus & Jupiter Spiritual Grace',
      'desc': 'Highly spiritual and fortunate. Represents immortality of name, peace after struggle, and divine protection.'
    },
    18: {
      'title': 'Commercial Bitterness & Deception (18)',
      'planet': 'Ruling Energy: Material Conflict Matrix',
      'desc': 'Associated with inner turmoil, family betrayal, or deceit in business dealings. Requires strong protective balancing.'
    },
    19: {
      'title': 'The Sun of Success (19)',
      'planet': 'Ruling Energy: Surya (The Sun)',
      'desc': 'One of the most auspicious numbers. Represents happiness, honor, supreme confidence, and ultimate victory over obstacles.'
    },
    20: {
      'title': 'The Awakening & Awakening Call (20)',
      'planet': 'Ruling Energy: Moon & Judgment Matrix',
      'desc': 'Represents new purpose, awakening of new plans, and mental grit, though marked by severe tests before final success.'
    },
    21: {
      'title': 'The Crown of the Magi (21)',
      'planet': 'Ruling Energy: Jupiter & Sun Mastery',
      'desc': 'Symbolizes advancement, honors, victory after long struggle, and a universally respected career trajectory.'
    },
    22: {
      'title': 'The Blind Ambition & Illusion (22)',
      'planet': 'Ruling Energy: Karmic Illusion Matrix',
      'desc': 'Warns against false judgments, blind trust in bad advice, and sudden loss through over-optimism.'
    },
    23: {
      'title': 'The Royal Star of the Lion (23)',
      'planet': 'Ruling Energy: Mars & Jupiter Protection',
      'desc': 'Promises success, help from superiors, protection from major disasters, and widespread recognition.'
    },
    24: {
      'title': 'The Love and Alliance Vibration (24)',
      'planet': 'Ruling Energy: Venus & Moon Harmony',
      'desc': 'Brings powerful assistance, social prestige, financial growth, and highly harmonious professional partnerships.'
    },
    25: {
      'title': 'Strength Through Experience (25)',
      'planet': 'Ruling Energy: Mars & Mercury Wisdom',
      'desc': 'Success gained through observation, past errors, and practical experience. Brings ultimate peace in later years.'
    },
    26: {
      'title': 'Partnership Caution & Partnerships (26)',
      'planet': 'Ruling Energy: Saturn & Venus Warning',
      'desc': 'Frought with financial disasters if trusting wrong business partners. Demands extreme caution in contracts.'
    },
    27: {
      'title': 'The Sceptre of Authority (27)',
      'planet': 'Ruling Energy: Jupiter & Mars Power',
      'desc': 'Productive of creative intellect, executive ability, writing success, and authority in command.'
    },
    28: {
      'title': 'Trust and Trial in Enterprise (28)',
      'planet': 'Ruling Energy: Sun & Saturn Conflict',
      'desc': 'Great potential for business, but warns against losing everything through lack of legal caution or partner betrayal.'
    },
    29: {
      'title': 'Uncertainty and Treachery (29)',
      'planet': 'Ruling Energy: Karmic Uncertainty Matrix',
      'desc': 'Indicates heavy trials, false friends, unreliable alliances, and emotional ups and downs.'
    },
    30: {
      'title': 'The Thoughtful Planner (30)',
      'planet': 'Ruling Energy: Jupiter & Mental Focus',
      'desc': 'Represents high mental faculties, independence, and analytical depth. Success depends on ethical execution.'
    },
    31: {
      'title': 'The Solitary Thinker (31)',
      'planet': 'Ruling Energy: Sun & Saturn Isolation',
      'desc': 'Similar to 22 and 13, tends toward isolation, self-containment, and intense focus away from public clamor.'
    },
    32: {
      'title': 'The Magic Cycle of Communication (32)',
      'planet': 'Ruling Energy: Mercury & Venus Flow',
      'desc': 'Magical balance when diplomacy is maintained. Success depends on believing in one’s original judgment.'
    },
    33: {
      'title': 'The Blessings of Grace (33)',
      'planet': 'Ruling Energy: Jupiter & Universal Grace',
      'desc': 'Carries high spiritual vibration, teaching capability, mentorship, and protection from grave misfortunes.'
    },
    34: {
      'title': 'The Cycle of Merited Success (34)',
      'planet': 'Ruling Energy: Saturn & Sun Balance',
      'desc': 'First half may carry hard work and trials, but second half brings rich material rewards and settled status.'
    },
    35: {
      'title': 'The Diplomatic & Protective Path (35)',
      'planet': 'Ruling Energy: Mercury & Mars Shield',
      'desc': 'Favorable for business negotiations, leadership, and legal matters. Offers hidden protection against financial loss.'
    },
    36: {
      'title': 'The Artistry & Commerce Bond (36)',
      'planet': 'Ruling Energy: Venus & Mars Creation',
      'desc': 'Excellent for artistic ventures, public speaking, trading, and building independent enterprises.'
    },
    37: {
      'title': 'The Fortunate Enterprise (37)',
      'planet': 'Ruling Energy: Sun & Jupiter Blessing',
      'desc': 'Indicates strong intuitive power, success in enterprise, and faithful connections that uplift your destiny.'
    },
    38: {
      'title': 'The Financial Evaluation Matrix (38)',
      'planet': 'Ruling Energy: Saturn & Mercury Caution',
      'desc': 'Requires careful financial auditing and avoiding speculative schemes to ensure steady growth.'
    },
    39: {
      'title': 'The Executive Command (39)',
      'planet': 'Ruling Energy: Jupiter & Sun Authority',
      'desc': 'Favorable for commanding large teams, administrative leadership, and major structural projects.'
    },
    40: {
      'title': 'The Systematic Strategist (40)',
      'planet': 'Ruling Energy: Rahu & Saturn Discipline',
      'desc': 'Brings methodical patience, systemic planning, and long-term goal realization.'
    },
    41: {
      'title': 'The Magnetic Leader (41)',
      'planet': 'Ruling Energy: Venus & Sun Magnetism',
      'desc': 'Attracts public fame, strong social backing, and massive commercial recognition.'
    },
    42: {
      'title': 'The Global Authority Vibration (42)',
      'planet': 'Ruling Energy: Jupiter & Venus Power',
      'desc': 'Excellent for high-level administration, international dealings, public acclaim, and massive material achievement.'
    },
    43: {
      'title': 'The Revolutionary Reformer (43)',
      'planet': 'Ruling Energy: Mars & Uranus Shift',
      'desc': 'Brings radical ideas, engineering prowess, and breakthrough technical solutions.'
    },
    44: {
      'title': 'The Material Builder (44)',
      'planet': 'Ruling Energy: Saturn & Rahu Stability',
      'desc': 'Strong grounding for real estate, infrastructure, and heavy industrial enterprises.'
    },
    45: {
      'title': 'The Fortunate Accumulator (45)',
      'planet': 'Ruling Energy: Venus & Jupiter Wealth',
      'desc': 'Extremely favorable for building long-term wealth, happy family life, and legacy assets.'
    },
    46: {
      'title': 'The Path of Public Acclaim (46)',
      'planet': 'Ruling Energy: Jupiter & Sun Recognition',
      'desc': 'Brings high public regard, leadership in social or organizational causes, and lasting achievements.'
    },
    47: {
      'title': 'The Intuitive Counselor (47)',
      'planet': 'Ruling Energy: Neptune & Jupiter Wisdom',
      'desc': 'Excellent for advisory roles, profound spiritual depth, and strategic foresight.'
    },
    48: {
      'title': 'The Karmic Balance & Justice (48)',
      'planet': 'Ruling Energy: Saturn & Mars Equilibrium',
      'desc': 'Demands absolute integrity and legal compliance. Rewards disciplined execution with secure success.'
    },
    49: {
      'title': 'The Visionary Pioneer (49)',
      'planet': 'Ruling Energy: Sun & Mars Enterprise',
      'desc': 'Drives groundbreaking initiatives, bold ventures, and pioneering leadership in competitive markets.'
    },
    50: {
      'title': 'The Universal Flow (50)',
      'planet': 'Ruling Energy: Mercury & Jupiter Expansion',
      'desc': 'Brings freedom of movement, adaptability, versatility, and smooth international communication.'
    },
    51: {
      'title': 'The Warrior of Integrity (51)',
      'planet': 'Ruling Energy: Mars & Sun Protection',
      'desc': 'Symbolizes sudden rise to power, strength of character, and unwavering defense against adversaries.'
    },
    52: {
      'title': 'The Master Builder & Strategist (52)',
      'planet': 'Ruling Energy: Venus & Saturn Mastery',
      'desc': 'Favorable for long-term legacy construction, financial structuring, and enduring professional triumph.'
    },
    53: {
      'title': 'The Dynamic Catalyst (53)',
      'planet': 'Ruling Energy: Mercury & Mars Action',
      'desc': 'Brings quick decision-making, technical innovation, and dynamic movement in career.'
    },
    54: {
      'title': 'The Burden of Responsibility (54)',
      'planet': 'Ruling Energy: Saturn & Venus Duty',
      'desc': 'Indicates hard work, heavy family or organizational duties, leading to eventual stability.'
    },
    55: {
      'title': 'The Double Mercury Power (55)',
      'planet': 'Ruling Energy: Double Mercury Intellect',
      'desc': 'Represents extreme mental agility, sharp communication, and commercial brilliance.'
    },
    56: {
      'title': 'The Emotional Equilibrium (56)',
      'planet': 'Ruling Energy: Venus & Moon Harmony',
      'desc': 'Brings deep emotional resilience, artistic flair, and peaceful domestic relations.'
    },
    57: {
      'title': 'The Spiritual Intuition (57)',
      'planet': 'Ruling Energy: Jupiter & Neptune Grace',
      'desc': 'Indicates profound inner wisdom, successful counseling, and spiritual growth.'
    },
    58: {
      'title': 'The Financial Caution (58)',
      'planet': 'Ruling Energy: Saturn & Mercury Audit',
      'desc': 'Warns against hasty speculations and urges strict legal and financial discipline.'
    },
    59: {
      'title': 'The Assertive Command (59)',
      'planet': 'Ruling Energy: Mars & Sun Authority',
      'desc': 'Favorable for executive control, competitive leadership, and ambitious expansion.'
    },
    60: {
      'title': 'The Stable Harmony (60)',
      'planet': 'Ruling Energy: Venus & Jupiter Peace',
      'desc': 'Represents domestic bliss, steady progress, and enjoyable life circumstances.'
    },
    61: {
      'title': 'The Focused Strategist (61)',
      'planet': 'Ruling Energy: Sun & Mercury Focus',
      'desc': 'Brings sharp analytical capabilities, planning precision, and professional focus.'
    },
    62: {
      'title': 'The Diplomatic Alliance (62)',
      'planet': 'Ruling Energy: Moon & Venus Pact',
      'desc': 'Favorable for cooperative ventures, partnerships, and public relations.'
    },
    63: {
      'title': 'The Creative Pioneer (63)',
      'planet': 'Ruling Energy: Jupiter & Mars Spark',
      'desc': 'Encourages artistic creation, independent enterprise, and bold execution.'
    },
    64: {
      'title': 'The Structural Foundation (64)',
      'planet': 'Ruling Energy: Saturn & Rahu Build',
      'desc': 'Great for real estate, long-term construction, and systematic infrastructure.'
    },
    65: {
      'title': 'The Magnetic Explorer (65)',
      'planet': 'Ruling Energy: Venus & Mercury Flow',
      'desc': 'Attracts travel opportunities, trade success, and charming public interactions.'
    },
    66: {
      'title': 'The Master Teacher (66)',
      'planet': 'Ruling Energy: Venus & Jupiter Mastery',
      'desc': 'Symbolizes higher learning, mentorship, healing arts, and community leadership.'
    },
    67: {
      'title': 'The Intuitive Vision (67)',
      'planet': 'Ruling Energy: Neptune & Sun Vision',
      'desc': 'Brings strong gut feeling, creative foresight, and unique enterprise ideas.'
    },
    68: {
      'title': 'The Disciplined Executive (68)',
      'planet': 'Ruling Energy: Saturn & Mars Rule',
      'desc': 'Rewards systematic hard work, administrative grit, and legal adherence.'
    },
    69: {
      'title': 'The Compassionate Leader (69)',
      'planet': 'Ruling Energy: Moon & Mars Care',
      'desc': 'Favorable for social welfare, healthcare leadership, and empathetic management.'
    },
    70: {
      'title': 'The Spiritual Awakening (70)',
      'planet': 'Ruling Energy: Ketu & Jupiter Grace',
      'desc': 'Indicates inner realization, philosophical depth, and detachment from trivial chaos.'
    },
    71: {
      'title': 'The Analytical Master (71)',
      'planet': 'Ruling Energy: Mercury & Sun Logic',
      'desc': 'Brings scientific intellect, data mastery, and strategic problem-solving.'
    },
    72: {
      'title': 'The Cooperative Harmony (72)',
      'planet': 'Ruling Energy: Moon & Venus Grace',
      'desc': 'Enhances teamwork, family bonding, and peaceful commercial agreements.'
    },
    73: {
      'title': 'The Inspired Intellect (73)',
      'planet': 'Ruling Energy: Jupiter & Mercury Wit',
      'desc': 'Favorable for writing, teaching, lecturing, and intellectual pursuits.'
    },
    74: {
      'title': 'The Pragmatic Builder (74)',
      'planet': 'Ruling Energy: Saturn & Mercury Work',
      'desc': 'Represents meticulous planning, steady business growth, and operational skill.'
    },
    75: {
      'title': 'The Fortunate Transformation (75)',
      'planet': 'Ruling Energy: Venus & Mars Shift',
      'desc': 'Brings positive breakthroughs after initial struggles and professional upgrades.'
    },
    76: {
      'title': 'The Domestic Protector (76)',
      'planet': 'Ruling Energy: Venus & Saturn Home',
      'desc': 'Focuses on family security, real estate stability, and protective care.'
    },
    77: {
      'title': 'The Divine Intuitive (77)',
      'planet': 'Ruling Energy: Neptune & Jupiter Light',
      'desc': 'Highly spiritual, deep mystical insight, and protection from unseen obstacles.'
    },
    78: {
      'title': 'The Karmic Balance (78)',
      'planet': 'Ruling Energy: Saturn & Mars Justice',
      'desc': 'Demands fairness in all dealings; rewards honesty with enduring success.'
    },
    79: {
      'title': 'The Sovereign Authority (79)',
      'planet': 'Ruling Energy: Sun & Jupiter Crown',
      'desc': 'Brings high executive rank, commanding presence, and widespread prestige.'
    },
    80: {
      'title': 'The Resilient Planner (80)',
      'planet': 'Ruling Energy: Uranus & Saturn Grit',
      'desc': 'Indicates strong endurance through tests, leading to solid accomplishment.'
    },
    81: {
      'title': 'The Ultimate Crown (81)',
      'planet': 'Ruling Energy: Mars & Sun Mastery',
      'desc': 'A supreme number of achievement, leadership triumph, and lasting legacy.'
    },
    82: {
      'title': 'The Diplomatic Vision (82)',
      'planet': 'Ruling Energy: Moon & Jupiter Tact',
      'desc': 'Favorable for negotiation, counseling, and peaceful conflict resolution.'
    },
    83: {
      'title': 'The Enterprising Spirit (83)',
      'planet': 'Ruling Energy: Jupiter & Mars Drive',
      'desc': 'Drives bold business initiatives, risk management, and commercial triumphs.'
    },
    84: {
      'title': 'The Structural Pillar (84)',
      'planet': 'Ruling Energy: Saturn & Rahu Base',
      'desc': 'Brings foundational strength to organizations, institutions, and major projects.'
    },
    85: {
      'title': 'The Magnetic Communicator (85)',
      'planet': 'Ruling Energy: Venus & Mercury Voice',
      'desc': 'Excellent for media, public speaking, marketing, and public relations.'
    },
    86: {
      'title': 'The Harmonious Provider (86)',
      'planet': 'Ruling Energy: Venus & Jupiter Care',
      'desc': 'Brings financial security, domestic comfort, and generous philanthropy.'
    },
    87: {
      'title': 'The Analytical Pioneer (87)',
      'planet': 'Ruling Energy: Sun & Mercury Test',
      'desc': 'Combines intellectual depth with pioneering spirit in professional fields.'
    },
    88: {
      'title': 'The Master of Equilibrium (88)',
      'planet': 'Ruling Energy: Saturn & Venus Balance',
      'desc': 'Signifies high-level material management, financial security, and justice.'
    },
    89: {
      'title': 'The Visionary Leader (89)',
      'planet': 'Ruling Energy: Sun & Mars Vision',
      'desc': 'Inspires large groups, innovative corporate growth, and visionary execution.'
    },
    90: {
      'title': 'The Universal Master (90)',
      'planet': 'Ruling Energy: Jupiter & Universal Flow',
      'desc': 'Represents completion of karmic cycles, ultimate wisdom, and global outlook.'
    },
    91: {
      'title': 'The Strategic Commander (91)',
      'planet': 'Ruling Energy: Sun & Saturn Command',
      'desc': 'Favorable for administrative mastery, military or corporate command.'
    },
    92: {
      'title': 'The Intuitive Diplomat (92)',
      'planet': 'Ruling Energy: Moon & Neptune Tact',
      'desc': 'Brings subtle psychological understanding and peaceful international relations.'
    },
    93: {
      'title': 'The Creative Sage (93)',
      'planet': 'Ruling Energy: Jupiter & Mars Art',
      'desc': 'Blends philosophical teaching with creative enterprise and execution.'
    },
    94: {
      'title': 'The Enduring Builder (94)',
      'planet': 'Ruling Energy: Saturn & Sun Hard Work',
      'desc': 'Success through perseverance, strict ethics, and relentless dedication.'
    },
    95: {
      'title': 'The Dynamic Networker (95)',
      'planet': 'Ruling Energy: Mercury & Venus Network',
      'desc': 'Excels in global networking, commercial trade, and social influence.'
    },
    96: {
      'title': 'The Harmonious Protector (96)',
      'planet': 'Ruling Energy: Venus & Moon Shield',
      'desc': 'Brings strong family support, emotional well-being, and safe environments.'
    },
    97: {
      'title': 'The Spiritual Pioneer (97)',
      'planet': 'Ruling Energy: Neptune & Mars Faith',
      'desc': 'Combines spiritual conviction with bold action for righteous causes.'
    },
    98: {
      'title': 'The Legacy Master (98)',
      'planet': 'Ruling Energy: Saturn & Jupiter Crown',
      'desc': 'Favorable for building generational wealth, enduring reputation, and monumental success.'
    }
  };

  final List<Map<String, String>> lifeDomains = [
    {
      'title': 'Business & Enterprise Growth',
      'subtitle': 'Venture timing, partnership alignment, and scaling strategies.',
      'content': 'In elite Chaldean and practical matrix numerology, business success depends heavily on the alignment between the owner’s compound name number and the business entity name. Numbers like 19, 37, and 42 attract massive enterprise expansion.'
    },
    {
      'title': 'Career & Professional Trajectory',
      'subtitle': 'Ideal industry sectors, promotions, and leadership roles.',
      'content': 'Your core destiny number dictates your natural authority domain. Sun-ruled vibrations excel in administration and government liaisons, while Mercury-Venus combinations dominate finance and technology.'
    },
    {
      'title': 'Wealth & Financial Flow',
      'subtitle': 'Money attraction codes and asset accumulation cycles.',
      'content': 'Compound numbers such as 15 and 24 act as natural currency magnets, drawing unexpected financial windfalls, lucrative contracts, and sustainable long-term asset creation.'
    },
    {
      'title': 'Marriage & Partner Compatibility (Spouse Matrix)',
      'subtitle': 'Spousal resonance, emotional harmony, and family synchronization.',
      'content': 'Relationship longevity is evaluated by comparing life path numbers and birth dates. A harmonious matrix reduces domestic friction and ensures smooth synchronization in family life.'
    },
    {
      'title': 'Lucky Numbers, Colors & Gemstones',
      'subtitle': 'Daily magnetism boosters and high-frequency shades.',
      'content': 'Every individual has specific power numbers and compatible colors (such as royal white, metallic gold, and emerald green) that amplify aura strength during critical meetings and travel.'
    },
  ];

  int _calculateSum(String name) {
    String cleanName = name.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    int sum = 0;
    for (int i = 0; i < cleanName.length; i++) {
      sum += chaldeanMap[cleanName[i]] ?? 0;
    }
    return sum;
  }

  int _reduceToOneDigit(int n) {
    while (n > 9) {
      n = n.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }
    return n;
  }

  void _calculatePersonalYear(String dob) {
    try {
      List<String> parts = dob.split('-');
      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int currentYear = 2026;
        int sumYearDigits = currentYear.toString().split('').map(int.parse).reduce((a, b) => a + b);
        int total = day + month + sumYearDigits;
        _personalYear = _reduceToOneDigit(total);
      } else {
        _personalYear = null;
      }
    } catch (_) {
      _personalYear = null;
    }
  }

  void _generateLoShu(String dob) {
    String cleanDob = dob.replaceAll(RegExp(r'[^0-9]'), '');
    Map<int, int> counts = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0};
    List<int> missing = [];
    
    for (int i = 0; i < cleanDob.length; i++) {
      int digit = int.parse(cleanDob[i]);
      if (digit >= 1 && digit <= 9) {
        counts[digit] = (counts[digit] ?? 0) + 1;
      }
    }

    counts.forEach((num, count) {
      if (count == 0) {
        missing.add(num);
      }
    });

    setState(() {
      _loShuCounts = counts;
      _missingNumbers = missing;
    });
  }

  void _analyzeProfile() {
    String inputName = _nameController.text.trim();
    String inputDob = _dobController.text.trim();

    if (inputName.isEmpty) {
      setState(() {
        _compoundNumber = null;
        _title = 'Please enter a valid full name';
        _description = '';
        _planet = '';
        _dobAnalysis = '';
        _luckyVariations = [];
        _personalYear = null;
      });
      return;
    }

    int sum = _calculateSum(inputName);
    int singleNum = _reduceToOneDigit(sum);

    if (inputDob.isNotEmpty) {
      _generateLoShu(inputDob);
      _calculatePersonalYear(inputDob);
      _dobAnalysis = 'Lo Shu Grid & Personal Year (2026) calculated locally.';
    } else {
      _dobAnalysis = 'Tip: Enter Date of Birth (DD-MM-YYYY) for Lo Shu Grid & Personal Year analysis.';
      _loShuCounts = {};
      _missingNumbers = [];
      _personalYear = null;
    }

    var eliteInfo = eliteDatabase[sum];
    if (eliteInfo != null) {
      _title = eliteInfo['title']!;
      _planet = eliteInfo['planet']!;
      _description = eliteInfo['desc']!;
    } else {
      _title = 'Compound Number: $sum (Karmic Optimization Recommended)';
      _planet = 'Ruling Energy: Cosmic Matrix Vibration';
      _description = 'Carries structural lessons. Use our optimized elite name variations below to align your core vibration with supreme practicality and luck.';
    }

    List<Map<String, dynamic>> variations = [];
    List<String> eliteSuffixes = ['A', 'EE', 'H', 'K', 'NN', 'LL', 'S', 'IA'];
    List<int> targetNumbers = [19, 37, 42, 15, 24];

    for (int target in targetNumbers) {
      for (String suffix in eliteSuffixes) {
        String testName = '$inputName $suffix';
        int testSum = _calculateSum(testName);
        if (testSum == target && !variations.any((v) => v['name'] == testName)) {
          var targetInfo = eliteDatabase[target];
          variations.add({
            'name': testName,
            'number': testSum,
            'tag': targetInfo != null ? targetInfo['title']!.split('(')[0].trim() : 'Elite Auspicious Vibration'
          });
          break;
        }
      }
      if (variations.length >= 4) break;
    }

    setState(() {
      _compoundNumber = sum;
      _singleNumber = singleNum;
      _luckyVariations = variations;
    });
  }

  void _checkCompatibility() {
    String pName = _partnerNameController.text.trim();
    String myName = _nameController.text.trim();

    if (myName.isEmpty || pName.isEmpty) {
      setState(() {
        _compatibilityResult = 'Please enter both your name and partner/business name to run synergy matching.';
      });
      return;
    }

    int mySum = _calculateSum(myName);
    int pSum = _calculateSum(pName);
    int diff = (mySum - pSum).abs();

    String result = '';
    if (diff <= 3 || diff == 5 || diff == 9) {
      result = 'High Synergy & Resonance! Both names ($mySum & $pSum) share a harmonious numerical vibration suitable for long-term alliance.';
    } else {
      result = 'Moderate Friction. Name numbers ($mySum & $pSum) have contrasting elements; conscious communication or minor name adjustment recommended.';
    }

    setState(() {
      _compatibilityResult = result;
    });
  }

  void _checkMobileNumerology() {
    String mobile = _mobileController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');
    if (mobile.length < 10) {
      setState(() {
        _mobileResult = 'Please enter a valid 10-digit mobile number.';
        _mobileCompound = null;
      });
      return;
    }

    int sum = 0;
    for (int i = 0; i < mobile.length; i++) {
      sum += int.parse(mobile[i]);
    }

    String msg = '';
    if ([15, 19, 24, 37, 42].contains(sum) || [15, 19, 24, 37, 42].contains(_reduceToOneDigit(sum))) {
      msg = 'Mobile Number Compound: $sum - Auspicious frequency! Attracts smooth communication, business calls, and positive financial flow.';
    } else {
      msg = 'Mobile Number Compound: $sum - Standard frequency. Ensure proper balance in personal interactions.';
    }

    setState(() {
      _mobileCompound = sum;
      _mobileResult = msg;
    });
  }

  void _checkVehicleNumerology() {
    String vehicle = _vehicleController.text.trim().toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    if (vehicle.length < 4) {
      setState(() {
        _vehicleResult = 'Please enter a valid vehicle number (e.g. DL01AB1234).';
        _vehicleCompound = null;
      });
      return;
    }

    int sum = 0;
    for (int i = 0; i < vehicle.length; i++) {
      String char = vehicle[i];
      if (RegExp(r'[0-9]').hasMatch(char)) {
        sum += int.parse(char);
      } else if (chaldeanMap.containsKey(char)) {
        sum += chaldeanMap[char]!;
      }
    }

    setState(() {
      _vehicleCompound = sum;
      _vehicleResult = 'Vehicle Number Compound: $sum - Evaluated for travel safety, machinery endurance, and smooth journeys.';
    });
  }

  void _openDomainDetail(String domainTitle, String content) {
    _showCustomModal(domainTitle, content);
  }

  void _handleFAQClick(String question) {
    if (_compoundNumber == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Profile Required', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
          content: const Text('Please enter your Name and Date of Birth above and tap "Run Elite Master Analysis" first!', style: TextStyle(color: Color(0xFF475569))),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
      return;
    }

    String dynamicAnswer = '';
    String nameUsed = _nameController.text.trim();

    if (question.contains('job') || question.contains('career')) {
      dynamicAnswer = 'Based on your name "$nameUsed" (Compound Number: $_compoundNumber) and your local birth matrix, career elevation peaks during cycles governed by your ruling planetary frequency.';
    } else if (question.contains('married') || question.contains('partner')) {
      dynamicAnswer = 'For "$nameUsed", relationship harmony and marriage timing depend on synchronization of Venus and Moon vibrations in your local grid.';
    } else if (question.contains('wealth') || question.contains('financial')) {
      dynamicAnswer = 'Your financial flow analysis for compound number $_compoundNumber indicates strong periods of asset accumulation.';
    } else if (question.contains('business') || question.contains('venture')) {
      dynamicAnswer = 'Enterprise success for "$nameUsed" is highly favorable if your commercial brand name sums up to an elite number like 19, 37, or 42.';
    } else {
      dynamicAnswer = 'Your core vibration single number is $_singleNumber, operating under powerful cosmic influences.';
    }

    _showCustomModal(question, dynamicAnswer);
  }

  void _showCustomModal(String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.85,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFFD4AF37), size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, color: Color(0xFFE2E8F0)),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.6,
                  color: Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    foregroundColor: const Color(0xFFD4AF37),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('CLOSE DOSSIER', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> faqQuestions = [
      'When will I get married or find my ideal life partner?',
      'When will I start my job or experience a career breakthrough?',
      'How can I attract stable wealth and financial growth?',
      'Is my current business venture properly aligned for success?',
      'What are my primary hidden strengths according to my numbers?'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CHEIRO NUMEROLOGY ELITE MASTER',
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 15),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 750),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter Full Name & Date of Birth',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'e.g., Nikhil Gulati',
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _dobController,
                      style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Date of Birth (e.g., 06-04-1988)',
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _analyzeProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        foregroundColor: const Color(0xFFD4AF37),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'RUN ELITE MASTER ANALYSIS',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 25),
                    if (_compoundNumber != null) ...[
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD4AF37).withOpacity(0.12),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.auto_awesome, color: Color(0xFFD4AF37), size: 22),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _title,
                                    style: const TextStyle(
                                      color: Color(0xFF0F172A),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24, color: Color(0xFFE2E8F0)),
                            Text(
                              _planet,
                              style: const TextStyle(
                                color: Color(0xFFD4AF37),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _description,
                              style: const TextStyle(
                                color: Color(0xFF475569),
                                fontSize: 13.5,
                                height: 1.4,
                              ),
                            ),
                            if (_personalYear != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                ),
                                child: Text(
                                  'Personal Year Vibration (2026): Number $_personalYear',
                                  style: const TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      if (_loShuCounts.isNotEmpty) ...[
                        const Text(
                          'Lo Shu Grid & Missing Numbers',
                          style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: Column(
                            children: [
                              _buildLoShuRow(4, 9, 2),
                              const Divider(color: Color(0xFFE2E8F0)),
                              _buildLoShuRow(3, 5, 7),
                              const Divider(color: Color(0xFFE2E8F0)),
                              _buildLoShuRow(8, 1, 6),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _missingNumbers.isEmpty 
                              ? 'All Lo Shu numbers present in birth matrix!' 
                              : 'Missing Numbers in Chart: ${_missingNumbers.join(', ')}',
                          style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                      ],

                      if (_luckyVariations.isNotEmpty) ...[
                        const Text(
                          'Perfect Elite Name Combinations',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ..._luckyVariations.map((item) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        color: Color(0xFF0F172A),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['tag'],
                                      style: const TextStyle(
                                        color: Color(0xFF64748B),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4AF37).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${item['number']}',
                                  style: const TextStyle(
                                    color: Color(0xFF9A7B2C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: 20),
                      ],
                    ],

                    // Mobile & Vehicle Compatibility Section
                    const Text(
                      'Mobile & Vehicle Number Numerology',
                      style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _mobileController,
                      style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter 10-Digit Mobile Number',
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _checkMobileNumerology,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: const Color(0xFFD4AF37),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('CHECK MOBILE NUMBER', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    if (_mobileResult.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFD4AF37))),
                        child: Text(_mobileResult, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13)),
                      ),
                    ],
                    const SizedBox(height: 14),
                    TextField(
                      controller: _vehicleController,
                      style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Vehicle Number (e.g. DL01AB1234)',
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _checkVehicleNumerology,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: const Color(0xFFD4AF37),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('CHECK VEHICLE NUMBER', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    if (_vehicleResult.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFD4AF37))),
                        child: Text(_vehicleResult, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13)),
                      ),
                    ],
                    const SizedBox(height: 20),

                    // Partner / Business Compatibility Matcher Section
                    const Text(
                      'Partner & Business Synergy Matcher',
                      style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _partnerNameController,
                      style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Partner or Business Name',
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _checkCompatibility,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: const Color(0xFFD4AF37),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('CHECK SYNERGY MATCH', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    if (_compatibilityResult.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFD4AF37)),
                        ),
                        child: Text(
                          _compatibilityResult,
                          style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13.5, height: 1.4),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),

                    const Text(
                      'Instant Astrological Q&A (Client Inquiries)',
                      style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...faqQuestions.map((q) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        leading: const Icon(Icons.help_outline, color: Color(0xFFD4AF37), size: 22),
                        title: Text(
                          q,
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF64748B)),
                        onTap: () => _handleFAQClick(q),
                      ),
                    )),
                    const SizedBox(height: 20),

                    const Text(
                      'Elite Life Domains & Deep Insights',
                      style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...lifeDomains.map((domain) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          domain['title']!,
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.5,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            domain['subtitle']!,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFD4AF37)),
                        onTap: () => _openDomainDetail(domain['title']!, domain['content']!),
                      ),
                    )),
                    const SizedBox(height: 25),

                    // Professional Legal Disclaimer Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'PROFESSIONAL DISCLAIMER & LIABILITY NOTICE',
                            style: TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'All numerological calculations, Lo Shu grid mappings, personal year cycles, insights, and name optimization suggestions provided in this application are strictly for educational, informational, and entertainment purposes only. The creators and developers of this app hold no liability or responsibility for the outcomes of any practical remedies, name spelling adjustments, or life decisions made by the user. Users assume 100% personal responsibility for all actions taken at their own discretion.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11.5,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          // Permanent Transparent Watermark overlay at the bottom with correct YouTube handle
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                color: Colors.white.withOpacity(0.85),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '© 2026 Cheiro Elite | YouTube: @NikhilVGulatii',
                      style: TextStyle(
                        color: Color(0x990F172A),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoShuRow(int n1, int n2, int n3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _loShuCell(n1),
        _loShuCell(n2),
        _loShuCell(n3),
      ],
    );
  }

  Widget _loShuCell(int num) {
    int count = _loShuCounts[num] ?? 0;
    String displayStr = count > 0 ? num.toString() * count : '-';
    return Container(
      width: 60,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: count > 0 ? const Color(0xFFD4AF37).withOpacity(0.1) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: count > 0 ? const Color(0xFFD4AF37) : const Color(0xFFE2E8F0)),
      ),
      child: Text(
        displayStr,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: count > 0 ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
