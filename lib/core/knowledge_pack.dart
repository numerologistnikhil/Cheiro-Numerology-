class KnowledgePack {
  static const version = '1.0.0';
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
}
