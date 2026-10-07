class KnowledgePack {
  static const version = '1.2.0';

  // Verified Cheiro compound-number framework: 10–52.
  static const int minCompound = 10;
  static const int maxCompound = 52;

  static const Map<int, String> roots = {
    1: 'Individuality, initiative and leadership.',
    2: 'Cooperation, sensitivity and partnership.',
    3: 'Expression, creativity and communication.',
    4: 'Structure, discipline and practical effort.',
    5: 'Movement, change and adaptability.',
    6: 'Responsibility, harmony and relationships.',
    7: 'Analysis, reflection and spiritual inquiry.',
    8: 'Authority, organisation and material responsibility.',
    9: 'Completion, compassion and broad perspective.',
  };

  static String rootMeaning(int n) =>
      roots[n] ?? 'Interpretation unavailable in the verified pack.';

  static bool isValidCompound(int n) =>
      n >= minCompound && n <= maxCompound;

  static String compoundMeaning(int n) {
    if (!isValidCompound(n)) {
      return 'Compound number outside the verified Cheiro range.';
    }
    return compoundNumbers[n] ??
        'Verified interpretation pending.';
  }

  // Paraphrased from Cheiro's Book of Numbers.
  // These are interpretation summaries, not copied source text.
  static const Map<int, String> compoundNumbers = {
    10: 'Wheel of Fortune: honour, faith, confidence, changing fortunes and the possibility of plans succeeding.',
    11: 'Warning number: hidden dangers, trials, opposition and possible treachery; calls for caution.',
    12: 'Sacrifice and anxiety: difficulty, mental strain and the possibility of being used for others’ plans.',
    13: 'Change and upheaval: transformation, destruction of old conditions and unexpected developments; not inherently unlucky.',
    14: 'Movement and combinations: change, money or business opportunities with risk; caution against impulsive actions.',
    15: 'Occult influence, communication and personal magnetism; can indicate eloquence, artistic ability and influence.',
    16: 'Sudden disruption: warning of defeat, accidents or plans being overturned; encourages preparation and caution.',
    17: 'Spiritual strength and lasting influence: associated with peace, love, achievement and a name that endures.',
    18: 'Conflict and material struggle: warnings involving quarrels, deception, upheaval and elemental dangers.',
    19: 'Favourable solar influence: happiness, success, esteem, honour and progress with future plans.',
    20: 'Awakening and new purpose: new ambitions or duties, but possible delays and limited immediate material gain.',
    21: 'Advancement and recognition: success after effort, elevation and victory following perseverance.',
    22: 'Warning of illusion and poor judgment: vulnerability to misleading influences and mistakes caused by others.',
    23: 'Royal Star: protection, assistance from influential people and strong prospects for successful plans.',
    24: 'Support and favourable associations: help from influential connections and benefits through relationships.',
    25: 'Strength through experience: learning from observation and trials, with favourable results after development.',
    26: 'Serious warning: possible losses through partnerships, speculation, poor advice or unsuitable associations.',
    27: 'Authority and productive intellect: creative effort, command and rewards from one’s own ideas.',
    28: 'Contradictory fortunes: promise and ability mixed with risks of loss, opposition, legal difficulties and repeated rebuilding.',
    29: 'Uncertainty and deception: trials, unreliable associations and unexpected difficulties; caution is advised.',
    30: 'Mental power and reflection: thoughtful analysis and intellectual independence; outcome depends on the person’s use of it.',
    31: 'Strong self-containment: independence and isolation; less favourable for worldly or material concerns.',
    32: 'Influence through communication and combinations: favourable when personal judgment is maintained rather than following others blindly.',
    33: 'Same essential interpretation as 24; the compound itself has no separate potency in Cheiro’s description.',
    34: 'Same essential interpretation as 25.',
    35: 'Same essential interpretation as 26.',
    36: 'Same essential interpretation as 27.',
    37: 'Favourable friendships and partnerships: especially positive for love, cooperation and joint ventures.',
    38: 'Same essential interpretation as 29.',
    39: 'Same essential interpretation as 30.',
    40: 'Same essential interpretation as 31.',
    41: 'Same essential interpretation as 32.',
    42: 'Same essential interpretation as 24.',
    43: 'Unfavourable warning: upheaval, conflict, failure, obstruction and difficult future indications.',
    44: 'Same essential interpretation as 26.',
    45: 'Same essential interpretation as 27.',
    46: 'Same essential interpretation as 37.',
    47: 'Same essential interpretation as 29.',
    48: 'Same essential interpretation as 30.',
    49: 'Same essential interpretation as 31.',
    50: 'Same essential interpretation as 32.',
    51: 'Powerful warrior symbolism: sudden advancement and leadership potential, alongside serious warnings concerning enemies and danger.',
    52: 'Same essential interpretation as 43.',
  };
}
