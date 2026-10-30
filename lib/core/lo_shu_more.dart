import 'root_profiles.dart' show L;

/// What to do for a missing number (traditional beliefs, gently worded).
class LoShuRemedy {
  final L planet;
  final L day;
  final L colour;
  final L habit;
  const LoShuRemedy(this.planet, this.day, this.colour, this.habit);
}

/// Extra Lo Shu texts: too many of a number, remedies for a missing number,
/// how strong each line is, the three planes and the centre number.
class LoShuMore {
  static const L usedTitle = L('Numbers placed in your grid', 'आपकी ग्रिड में रखे गए अंक');
  static const L usedFrom = L('From the date of birth', 'जन्म तिथि से');
  static const L usedAdded = L('Added: Mulank and Bhagyank', 'जोड़े गए: मूलांक और भाग्यांक');

  static const L planesTitle = L('Your three planes', 'आपके तीन तल');
  static const L planesIntro = L(
    'The grid has three rows. Each row is a plane of life: thinking, feeling and doing. The more numbers a plane holds, the more developed that part of you is.',
    'ग्रिड में तीन पंक्तियाँ हैं। हर पंक्ति जीवन का एक तल है: सोचना, महसूस करना और करना। जिस तल में जितने ज़्यादा अंक होते हैं, आपका वह हिस्सा उतना विकसित होता है।',
  );

  static const List<L> groupNames = [
    L('Mental plane (top row: 4, 9, 2)', 'सोच का तल (ऊपर की पंक्ति: 4, 9, 2)'),
    L('Emotional plane (middle row: 3, 5, 7)', 'भावना का तल (बीच की पंक्ति: 3, 5, 7)'),
    L('Practical plane (bottom row: 8, 1, 6)', 'व्यावहारिक तल (नीचे की पंक्ति: 8, 1, 6)'),
  ];

  static const List<L> groupMeaning = [
    L('Thinking, memory, planning and judgement.', 'सोचना, याददाश्त, योजना और परख।'),
    L('Feelings, imagination, intuition and creativity.', 'भावनाएँ, कल्पना, अंतर्ज्ञान और रचनात्मकता।'),
    L('Action, money, health and getting daily work done.', 'काम करना, पैसा, सेहत और रोज़ के काम निपटाना।'),
  ];

  /// By how many of the three numbers are present: 0, 1, 2, 3.
  static const List<L> groupLevel = [
    L('No number here. This part needs conscious practice, and it can be built step by step.',
        'यहाँ कोई अंक नहीं है। इस हिस्से के लिए सोच-समझकर अभ्यास करना पड़ता है, और इसे कदम-कदम पर बनाया जा सकता है।'),
    L('One number here. This part is light in you, but it is there to grow.',
        'यहाँ एक अंक है। यह हिस्सा आपमें हल्का है, पर बढ़ने के लिए मौजूद है।'),
    L('Two numbers here. This part works well in you, with a small gap to fill.',
        'यहाँ दो अंक हैं। यह हिस्सा आपमें अच्छा काम करता है, बस एक छोटी कमी भरनी है।'),
    L('All three numbers are here. This part is fully developed and you can lean on it.',
        'यहाँ तीनों अंक हैं। यह हिस्सा पूरी तरह विकसित है और आप इस पर भरोसा कर सकते हैं।'),
  ];

  static const List<L> dominant = [
    L('You are mainly a thinker. You like to understand and plan before you act.',
        'आप मुख्य रूप से सोचने वाले इंसान हैं। आप काम से पहले समझना और योजना बनाना पसंद करते हैं।'),
    L('You are mainly a feeler. You work best when your heart is in it, and people notice your warmth.',
        'आप मुख्य रूप से भावना से चलने वाले इंसान हैं। जब मन लगता है तब आप सबसे अच्छा काम करते हैं, और लोग आपकी गर्मजोशी देखते हैं।'),
    L('You are mainly a doer. You like results, and you are happiest when you are busy with something useful.',
        'आप मुख्य रूप से करने वाले इंसान हैं। आपको नतीजे पसंद हैं, और कुछ काम का करते रहने में आपको सबसे ज़्यादा खुशी मिलती है।'),
  ];

  static const L balanced = L(
    'Your planes are fairly balanced, so you can think, feel and act in a good mix.',
    'आपके तल काफ़ी संतुलित हैं, इसलिए आप सोचने, महसूस करने और करने का अच्छा मेल रख पाते हैं।',
  );

  static const L centreTitle = L('The centre number: 5', 'बीच का अंक: 5');
  static const L centrePresent = L(
    'The 5 sits in the middle of the grid and holds it together. Having it means you can keep your balance, stay flexible and speak your mind with ease.',
    '5 ग्रिड के बीच में है और उसे जोड़कर रखता है। इसका होना बताता है कि आप संतुलन बनाए रख सकते हैं, लचीले रह सकते हैं और आसानी से अपनी बात कह सकते हैं।',
  );
  static const L centreAbsent = L(
    'The 5 is missing from the middle of your grid. Balance and quick change may need practice. A steady daily routine, regular sleep and meals, and calm decisions help a lot.',
    'आपकी ग्रिड के बीच में 5 नहीं है। संतुलन और जल्दी बदलाव में अभ्यास की ज़रूरत पड़ सकती है। रोज़ की नियमित दिनचर्या, समय पर नींद और खाना, और शांत होकर फ़ैसले लेना बहुत मदद करता है।',
  );

  static const L excessTitle = L('When a number repeats', 'जब कोई अंक दोहराता है');

  static const Map<int, L> excess = {
    1: L('Very strong will and ego. You may come across as bossy or stubborn. Listen more and share credit.',
        'इच्छा-शक्ति और अहं बहुत प्रबल। आप हावी होने वाले या ज़िद्दी लग सकते हैं। ज़्यादा सुनिए और श्रेय बाँटिए।'),
    2: L('Very sensitive and easily hurt, and you may soak up other people\'s moods. Build firm boundaries and trust yourself more.',
        'बहुत संवेदनशील और जल्दी आहत होने वाले, और दूसरों का मूड ख़ुद पर ले लेने वाले। पक्की सीमाएँ बनाइए और ख़ुद पर ज़्यादा भरोसा कीजिए।'),
    3: L('Plenty of talk and ideas, and energy can scatter or get exaggerated. Choose one creative goal and finish it.',
        'बातें और विचार बहुत, और ऊर्जा बिखर या बढ़ा-चढ़ाकर कही जा सकती है। एक रचनात्मक लक्ष्य चुनिए और उसे पूरा कीजिए।'),
    4: L('Too rigid, too cautious and too work-heavy. Make room for rest, flexibility and some fun.',
        'ज़रूरत से ज़्यादा कठोर, सतर्क और काम में डूबे हुए। आराम, लचीलेपन और थोड़े मज़े के लिए जगह बनाइए।'),
    5: L('Restless and impulsive, with many changes. Build a steady routine and avoid risky shortcuts.',
        'बेचैन और आवेग में, कई बदलावों के साथ। एक टिकाऊ दिनचर्या बनाइए और जोखिम भरे शॉर्टकट से बचिए।'),
    6: L('Over-giving and sometimes possessive in love, with a pull towards comfort. Let others solve their own problems.',
        'ज़रूरत से ज़्यादा देने वाले और प्रेम में कभी-कभी अधिकार जताने वाले, आराम की ओर खिंचाव के साथ। दूसरों को उनकी समस्याएँ खुद सुलझाने दीजिए।'),
    7: L('Withdrawn and over-thinking, with doubts. Share your thoughts with a trusted person and keep a grounded routine.',
        'अलग-थलग और ज़रूरत से ज़्यादा सोचने वाले, शंकाओं के साथ। अपनी बात किसी भरोसेमंद से बाँटिए और ज़मीन से जुड़ी दिनचर्या रखिए।'),
    8: L('Too much focus on money and control, and strictness. Balance it with generosity and time for family.',
        'पैसे और नियंत्रण पर ज़रूरत से ज़्यादा ध्यान, और सख़्ती। इसे उदारता और परिवार के समय से संतुलित कीजिए।'),
    9: L('Quick temper, strong emotions and restless idealism. Spend the energy on exercise and on helping others.',
        'जल्दी गुस्सा, तेज़ भावनाएँ और बेचैन आदर्शवाद। ऊर्जा को कसरत और दूसरों की मदद में लगाइए।'),
  };

  static const L remedyTitle = L('Simple help for each missing number', 'हर अनुपस्थित अंक के लिए सरल उपाय');
  static const L remedyNote = L(
    'These are traditional beliefs and simple habits. They are not medical or financial advice, and none of them is a must.',
    'ये पारंपरिक मान्यताएँ और सरल आदतें हैं। ये चिकित्सा या पैसे की सलाह नहीं हैं, और इनमें से कुछ भी ज़रूरी नहीं है।',
  );
  static const L planetLabel = L('Linked planet', 'जुड़ा ग्रह');
  static const L dayLabel = L('Helpful day', 'सहायक दिन');
  static const L colourLabel = L('Helpful colour', 'सहायक रंग');
  static const L habitLabel = L('Daily habit', 'रोज़ की आदत');

  static const Map<int, LoShuRemedy> remedy = {
    1: LoShuRemedy(L('Sun', 'सूर्य'), L('Sunday', 'रविवार'), L('Gold, orange', 'सुनहरा, नारंगी'),
        L('Say your opinion once in every meeting or conversation, and rise early.',
            'हर बैठक या बातचीत में एक बार अपनी राय ज़रूर रखिए, और सुबह जल्दी उठिए।')),
    2: LoShuRemedy(L('Moon', 'चंद्र'), L('Monday', 'सोमवार'), L('White, cream', 'सफ़ेद, क्रीम'),
        L('Give a few calm minutes every evening to music or a quiet hobby, and drink enough water.',
            'हर शाम कुछ शांत मिनट संगीत या किसी शांत शौक को दीजिए, और पर्याप्त पानी पीजिए।')),
    3: LoShuRemedy(L('Jupiter', 'गुरु'), L('Thursday', 'गुरुवार'), L('Yellow', 'पीला'),
        L('Learn something new each week and write a few lines in a diary.',
            'हर हफ़्ते कुछ नया सीखिए और डायरी में कुछ पंक्तियाँ लिखिए।')),
    4: LoShuRemedy(L('Rahu', 'राहु'), L('Saturday', 'शनिवार'), L('Blue, grey', 'नीला, स्लेटी'),
        L('Keep a simple daily list with fixed timings and tick it off.',
            'तय समय के साथ रोज़ की एक सरल सूची रखिए और उसमें निशान लगाइए।')),
    5: LoShuRemedy(L('Mercury', 'बुध'), L('Wednesday', 'बुधवार'), L('Green', 'हरा'),
        L('Keep a steady routine, read or talk with someone daily, and keep small accounts of your money.',
            'नियमित दिनचर्या रखिए, रोज़ किसी से बात कीजिए या पढ़िए, और पैसों का छोटा हिसाब रखिए।')),
    6: LoShuRemedy(L('Venus', 'शुक्र'), L('Friday', 'शुक्रवार'), L('White, light pink', 'सफ़ेद, हल्का गुलाबी'),
        L('Keep your home neat and give a small gift or kind word to family.',
            'घर सुथरा रखिए और परिवार को कोई छोटा उपहार या मीठा बोल दीजिए।')),
    7: LoShuRemedy(L('Ketu', 'केतु'), L('Monday', 'सोमवार'), L('Light sea-green, pastel', 'हल्का समुद्री हरा, पेस्टल'),
        L('Give 10 to 20 minutes each day to silence, prayer or quiet reading.',
            'रोज़ 10 से 20 मिनट मौन, प्रार्थना या शांत पढ़ने को दीजिए।')),
    8: LoShuRemedy(L('Saturn', 'शनि'), L('Saturday', 'शनिवार'), L('Dark blue, black', 'गहरा नीला, काला'),
        L('Save a fixed small amount every month, and be kind to workers and elders.',
            'हर महीने एक तय छोटी रक़म बचाइए, और काम करने वालों और बुज़ुर्गों से नरमी रखिए।')),
    9: LoShuRemedy(L('Mars', 'मंगल'), L('Tuesday', 'मंगलवार'), L('Red', 'लाल'),
        L('Do light exercise and help someone without expecting anything back.',
            'हल्की कसरत कीजिए और बदले में कुछ चाहे बिना किसी की मदद कीजिए।')),
  };

  static const L linesTitle = L('All eight lines of your grid', 'आपकी ग्रिड की सभी आठ रेखाएँ');
  static const L linesIntro = L(
    'Besides the three rows, the grid has three columns and two diagonals. When all three numbers of a line are present, the line is fully active. When none is present, it is called a missing arrow, and it shows a quality you build with effort, not a fixed fate.',
    'तीन पंक्तियों के अलावा ग्रिड में तीन स्तंभ और दो तिरछी रेखाएँ भी हैं। जब किसी रेखा के तीनों अंक मौजूद हों, तो वह रेखा पूरी तरह सक्रिय है। जब कोई भी न हो, तो उसे अनुपस्थित तीर कहते हैं, और यह ऐसा गुण दिखाता है जिसे आप मेहनत से बनाते हैं, कोई पक्का भाग्य नहीं।',
  );

  /// By how many numbers of the line are present: 0, 1, 2, 3.
  static const List<L> lineState = [
    L('Missing arrow (0 of 3). This quality does not come on its own. You build it through practice and it can become a real strength.',
        'अनुपस्थित तीर (3 में से 0)। यह गुण अपने आप नहीं आता। आप इसे अभ्यास से बनाते हैं और यह असली ताक़त बन सकता है।'),
    L('Weak (1 of 3). The quality shows only now and then.',
        'कमज़ोर (3 में से 1)। यह गुण बस कभी-कभी दिखता है।'),
    L('Partly active (2 of 3). The quality works, with one gap that practice can fill.',
        'आंशिक सक्रिय (3 में से 2)। यह गुण काम करता है, बस एक कमी है जिसे अभ्यास भर सकता है।'),
    L('Complete (3 of 3). The quality is fully active and you can rely on it.',
        'पूरी रेखा (3 में से 3)। यह गुण पूरी तरह सक्रिय है और आप इस पर भरोसा कर सकते हैं।'),
  ];

  static const List<String> stateWordEn = ['Missing arrow', 'Weak', 'Partly active', 'Complete'];
  static const List<String> stateWordHi = ['अनुपस्थित तीर', 'कमज़ोर', 'आंशिक सक्रिय', 'पूरी'];
}
