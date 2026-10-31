import 'root_profiles.dart' show L;

/// Plain-language texts for the Compatibility screen (English and Hindi).
class CompatText {
  static const L title = L('Compatibility', 'अनुकूलता');
  static const L intro = L(
    'Enter both people. The app compares their birth numbers, and their name numbers if you add the names, and explains in simple words where you fit well and where you need patience.',
    'दोनों व्यक्तियों की जानकारी भरिए। ऐप उनके जन्म के अंकों की तुलना करता है, और नाम भरने पर नाम के अंकों की भी, और सरल शब्दों में बताता है कि आप कहाँ अच्छे मेल में हैं और कहाँ धैर्य चाहिए।',
  );
  static const L first = L('First person', 'पहला व्यक्ति');
  static const L second = L('Second person', 'दूसरा व्यक्ति');
  static const L nameLabel = L('Name (optional, English letters)', 'नाम (ज़रूरी नहीं, अंग्रेज़ी अक्षरों में)');
  static const L dobLabel = L('Date of birth', 'जन्म तिथि');
  static const L check = L('Check compatibility', 'अनुकूलता देखिए');
  static const L psychic = L('Mulank', 'मूलांक');
  static const L destiny = L('Bhagyank', 'भाग्यांक');
  static const L nameNum = L('Name number', 'नाम का अंक');
  static const L result = L('Result', 'नतीजा');
  static const L points = L('Harmony points', 'तालमेल के अंक');
  static const L outOf = L('of', 'में से');
  static const L areasTitle = L('Area by area', 'हर पहलू अलग-अलग');
  static const L helpsTitle = L('What helps you two', 'आप दोनों के लिए क्या अच्छा है');
  static const L avoidTitle = L('What to be careful about', 'किस बात का ध्यान रखें');
  static const L bestUseTitle = L('In plain words', 'सीधे शब्दों में');
  static const L note = L(
    'This is a traditional guide, and different books differ slightly. A number match can never decide a relationship. Trust, honesty and respect matter far more. This is not a guarantee or advice.',
    'यह एक पारंपरिक मार्गदर्शन है और अलग-अलग किताबों में थोड़ा फ़र्क़ होता है। अंकों का मेल किसी रिश्ते का फ़ैसला नहीं करता। भरोसा, ईमानदारी और सम्मान कहीं ज़्यादा मायने रखते हैं। यह गारंटी या सलाह नहीं है।',
  );

  // Area names.
  static const L areaNature = L('Nature and daily chemistry (Mulank with Mulank)', 'स्वभाव और रोज़ का तालमेल (मूलांक और मूलांक)');
  static const L areaPath = L('Life path together (Bhagyank with Bhagyank)', 'साथ का जीवन-पथ (भाग्यांक और भाग्यांक)');
  static const L areaCross1 = L('How the first person fits the second one\'s road', 'पहला व्यक्ति दूसरे के जीवन-पथ में कैसे बैठता है');
  static const L areaCross2 = L('How the second person fits the first one\'s road', 'दूसरा व्यक्ति पहले के जीवन-पथ में कैसे बैठता है');
  static const L areaName = L('Names together (name number with name number)', 'नाम साथ में (नाम का अंक और नाम का अंक)');

  static const Map<String, L> friendly = {
    'nature': L('You understand each other without many words. Habits, moods and the way you react are close, so daily life feels easy.',
        'आप बिना ज़्यादा बोले एक-दूसरे को समझ लेते हैं। आदतें, मूड और प्रतिक्रिया का तरीक़ा क़रीब है, इसलिए रोज़ का जीवन आसान लगता है।'),
    'path': L('You want similar things from life. Your long-term goals pull in the same direction, so you can build something together.',
        'आप जीवन से मिलती-जुलती चीज़ें चाहते हैं। लंबे समय के लक्ष्य एक ही दिशा में खींचते हैं, इसलिए साथ मिलकर कुछ बना सकते हैं।'),
    'cross': L('Their nature supports the road this person is on. Small help from them goes a long way.',
        'इनका स्वभाव उस रास्ते को सहारा देता है जिस पर दूसरा चल रहा है। इनकी छोटी-सी मदद भी बहुत काम आती है।'),
    'name': L('The two names carry friendly energy together, which suits writing, speaking and working side by side.',
        'दोनों नाम साथ में अनुकूल ऊर्जा रखते हैं, जो साथ लिखने, बोलने और काम करने के लिए अच्छा है।'),
  };

  static const Map<String, L> neutral = {
    'nature': L('You are different in some ways and alike in others. Things work well when you respect each other\'s style.',
        'आप कुछ बातों में अलग और कुछ में एक जैसे हैं। जब आप एक-दूसरे के तरीक़े का सम्मान करते हैं तब बात अच्छी बनती है।'),
    'path': L('Your life goals are different but not opposed. With some talking, you can plan a road that suits both.',
        'आपके जीवन के लक्ष्य अलग हैं पर उलटे नहीं। थोड़ी बातचीत से आप ऐसा रास्ता बना सकते हैं जो दोनों को ठीक लगे।'),
    'cross': L('Their nature neither helps nor blocks the other\'s road. What you get depends on effort and clear talk.',
        'इनका स्वभाव दूसरे के रास्ते में न मदद करता है न रुकावट बनता है। नतीजा कोशिश और साफ़ बातचीत पर निर्भर है।'),
    'name': L('The two names are neutral together. They neither lift nor weigh down your joint work.',
        'दोनों नाम साथ में सामान्य हैं। ये आपके साथ के काम को न ऊपर उठाते हैं न बोझ बनते हैं।'),
  };

  static const Map<String, L> challenging = {
    'nature': L('Your natures can pull in different ways, so small things may turn into arguments. Patience and a calm voice solve most of it.',
        'आपके स्वभाव अलग-अलग दिशा में खींच सकते हैं, इसलिए छोटी बातें बहस बन सकती हैं। धैर्य और शांत आवाज़ से ज़्यादातर बातें सुलझ जाती हैं।'),
    'path': L('Your long-term wishes may not match, so big decisions need open talk from the start. Do not assume, ask.',
        'आपकी लंबी इच्छाएँ मेल न खाएँ, इसलिए बड़े फ़ैसलों पर शुरू से खुलकर बात चाहिए। मान मत लीजिए, पूछिए।'),
    'cross': L('Their nature can feel like a brake on the other\'s road. Give each other room, and agree on small rules.',
        'इनका स्वभाव दूसरे के रास्ते पर ब्रेक जैसा लग सकता है। एक-दूसरे को जगह दीजिए और छोटे-छोटे नियम तय कर लीजिए।'),
    'name': L('The two names do not sit easily together. In joint work or a joint brand, make roles very clear.',
        'दोनों नाम साथ में आसानी से नहीं बैठते। साझे काम या साझे ब्रांड में भूमिकाएँ बिल्कुल साफ़ रखिए।'),
  };

  /// By level: 0 needs care, 1 balanced, 2 strong.
  static const List<L> levelName = [
    L('Needs care and patience', 'ध्यान और धैर्य चाहिए'),
    L('Balanced', 'संतुलित'),
    L('Strong match', 'मज़बूत मेल'),
  ];

  static const List<L> levelPlain = [
    L('Your numbers show real differences. This does not mean the relationship cannot work. It means you must talk more, listen more and not take small things personally.',
        'आपके अंकों में सचमुच फ़र्क़ है। इसका मतलब ये नहीं कि रिश्ता चल नहीं सकता। इसका मतलब है कि ज़्यादा बात कीजिए, ज़्यादा सुनिए और छोटी बातों को दिल पर मत लीजिए।'),
    L('There is a healthy mix of support and difference. Respect each other\'s style and use the differences to cover each other\'s gaps.',
        'सहारे और फ़र्क़ का अच्छा मेल है। एक-दूसरे के तरीक़े का सम्मान कीजिए और फ़र्क़ को एक-दूसरे की कमी भरने में लगाइए।'),
    L('Your numbers support each other well. You start with an easy understanding. Protect it by staying honest and by not taking it for granted.',
        'आपके अंक एक-दूसरे को अच्छा सहारा देते हैं। आपके बीच शुरू से आसान समझ है। ईमानदार रहकर और इसे सहज न मानकर इसे बचाए रखिए।'),
  ];

  static const List<L> helps = [
    L('Fix one calm time each week to talk about money, plans and feelings. Write down what you both agreed.',
        'हर हफ़्ते एक शांत समय तय कीजिए जब पैसे, योजनाओं और भावनाओं पर बात हो। जो दोनों ने तय किया उसे लिख लीजिए।'),
    L('Plan some things together and keep some space for yourselves. Praise small things often.',
        'कुछ चीज़ें साथ में तय कीजिए और कुछ जगह अपने लिए भी रखिए। छोटी बातों की अक्सर तारीफ़ कीजिए।'),
    L('Do shared things regularly: meals, trips, goals, a hobby. Keep thanking each other.',
        'साझे काम नियमित कीजिए: खाना, यात्रा, लक्ष्य, कोई शौक़। एक-दूसरे का शुक्रिया कहते रहिए।'),
  ];

  static const List<L> avoid = [
    L('Do not argue when tired or angry. Do not bring up old matters again and again. Avoid big decisions in a bad mood.',
        'थके या गुस्से में बहस मत कीजिए। पुरानी बातें बार-बार मत उठाइए। बुरे मूड में बड़े फ़ैसले मत लीजिए।'),
    L('Do not hide small problems until they grow. Do not compare yourselves with others.',
        'छोटी समस्याएँ तब तक मत छिपाइए जब तक वे बड़ी न हो जाएँ। दूसरों से अपनी तुलना मत कीजिए।'),
    L('Do not take the ease for granted. Do not let work or phones eat your time together.',
        'आसानी को सहज मत मानिए। काम या फ़ोन को अपने साथ के समय में सेंध मत लगाने दीजिए।'),
  ];

  static const L plainFriends = L('For friendship: ', 'दोस्ती के लिए: ');
  static const L plainLove = L('For love and marriage: ', 'प्रेम और विवाह के लिए: ');
  static const L plainWork = L('For work together: ', 'साथ में काम के लिए: ');

  static const List<List<L>> usage = [
    [
      L('Friendship works if you keep expectations light.', 'उम्मीदें हल्की रखें तो दोस्ती चलती है।'),
      L('Love needs open talk early, and patience in daily matters.', 'प्रेम में शुरू से खुली बात और रोज़ की बातों में धैर्य चाहिए।'),
      L('Work together with clear roles and written agreements.', 'साफ़ भूमिकाओं और लिखित समझौतों के साथ मिलकर काम कीजिए।'),
    ],
    [
      L('A steady, honest friendship is likely.', 'एक टिकाऊ, ईमानदार दोस्ती की संभावना है।'),
      L('Love grows well with shared plans and respect.', 'साझी योजनाओं और सम्मान के साथ प्रेम अच्छा बढ़ता है।'),
      L('Teamwork is good when each person keeps their own strength.', 'जब हर कोई अपनी ताक़त पर टिके तब टीमवर्क अच्छा रहता है।'),
    ],
    [
      L('A natural, easy friendship.', 'स्वाभाविक और आसान दोस्ती।'),
      L('A warm base for love and marriage, if you keep communicating.', 'बातचीत बनी रहे तो प्रेम और विवाह के लिए गर्म और मज़बूत आधार।'),
      L('A strong team. Still, write down money matters clearly.', 'मज़बूत टीम। फिर भी पैसे की बातें साफ़ लिख लीजिए।'),
    ],
  ];
}
