class KnowledgePack {
  static const version = '1.1.0';
  // Compound-number interpretation range locked to Cheiro 10–52.
  static const int minCompound = 10;
  static const int maxCompound = 52;
  // Interpretation layer intentionally modular. Expand only with verified/licensed/public-domain material.
  static const Map<int,String> roots = {
    1:'Initiative, independence, individuality and leadership themes.',
    2:'Cooperation, sensitivity, partnership and diplomacy themes.',
    3:'Expression, creativity, communication and social themes.',
    4:'Structure, discipline, systems and practical effort themes.',
    5:'Movement, adaptability, communication and variety themes.',
    6:'Responsibility, harmony, family, care and aesthetics themes.',
    7:'Reflection, analysis, research and inward development themes.',
    8:'Authority, material organisation, responsibility and long cycles.',
    9:'Completion, compassion, broad perspective and service themes.',
  };
  static String rootMeaning(int n)=>roots[n]??'Interpretation unavailable in current verified pack.';
  static String compoundMeaning(int n) {
    if (!isValidCompound(n)) {
      return 'Compound number outside the verified Cheiro range.';
    }
    return compoundNumbers[n] ?? 'Verified interpretation pending.';
  }

  static bool isValidCompound(int n) {
    return n >= minCompound && n <= maxCompound;
  }

  static const Map<int, String> compoundNumbers = {
    10: 'Wheel of Fortune',
    11: 'Intuition and heightened sensitivity',
    12: 'Learning through experience and responsibility',
    13: 'Transformation through disciplined effort',
    14: 'Movement, change and adaptability',
    15: 'Influence, communication and attraction',
    16: 'Reflection, change and rebuilding',
    17: 'Progress through discipline and persistence',
    18: 'Power, responsibility and service',
    19: 'Independence, completion and renewal',
    20: 'Awakening, cooperation and patience',
    21: 'Growth through expression and opportunity',
    22: 'Large-scale plans and practical organisation',
    23: 'Communication, protection and opportunity',
    24: 'Support, relationships and material comfort',
    25: 'Analysis, intuition and experience',
    26: 'Responsibility, partnership and material affairs',
    27: 'Spiritual insight, compassion and achievement',
    28: 'Independence, partnerships and changing fortunes',
    29: 'Sensitivity, intuition and relationship lessons',
    30: 'Expression, creativity and communication',
    31: 'Individuality, structure and practical achievement',
    32: 'Communication, influence and adaptability',
    33: 'Service, responsibility and creative expression',
    34: 'Practical growth through communication and effort',
    35: 'Change, expression and learning',
    36: 'Responsibility, creativity and relationships',
    37: 'Intuition, analysis and independent achievement',
    38: 'Ambition, organisation and material responsibility',
    39: 'Completion, service and broad perspective',
    40: 'Structure, patience and practical foundations',
    41: 'Independent thinking with disciplined action',
    42: 'Partnership, organisation and steady progress',
    43: 'Transformation through structure and persistence',
    44: 'Strong organisation, responsibility and long-term building',
    45: 'Change, communication and practical opportunity',
    46: 'Responsibility, relationships and material organisation',
    47: 'Research, intuition and disciplined development',
    48: 'Authority, organisation and long-term responsibility',
    49: 'Completion, transformation and renewal',
    50: 'Freedom, movement and adaptability',
    51: 'Initiative, influence and decisive action',
    52: 'Intuition, change and independent development',
  };
}
