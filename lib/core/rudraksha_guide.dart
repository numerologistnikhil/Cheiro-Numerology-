import 'root_profiles.dart' show L;

/// One kind of rudraksha bead, by the number of natural lines (mukhi).
/// Meanings follow common traditional lists. Different books and teachers
/// differ, so this is guidance, not a rule, and not a medical remedy.
class RudrakshaInfo {
  final int mukhi;
  final L deity;
  final L planet;
  final L mantra;
  final L focus;
  final L note;
  const RudrakshaInfo(
      this.mukhi, this.deity, this.planet, this.mantra, this.focus, this.note);
}

class RudrakshaGuide {
  static const L title = L('Rudraksha Guide', 'रुद्राक्ष मार्गदर्शन');
  static const L intro = L(
    'Rudraksha is the sacred seed of the rudraksha tree, worn for centuries as a prayer bead and a symbol of Shiva. Some people wear it instead of a gemstone, or along with prayer. This guide gives the traditional meaning of each type, how to choose, how to energise and wear it, and how to avoid fake beads. It is a matter of faith and tradition, not a medical or scientific remedy, and no result can be promised.',
    'रुद्राक्ष, रुद्राक्ष वृक्ष का पवित्र बीज है, जिसे सदियों से जपमाला और शिव के प्रतीक के रूप में पहना जाता है। कुछ लोग इसे रत्न की जगह या प्रार्थना के साथ पहनते हैं। इस मार्गदर्शन में हर प्रकार का पारंपरिक अर्थ, चुनने का तरीका, प्राण-प्रतिष्ठा और पहनने की विधि, और नकली मनकों से बचने के तरीके दिए गए हैं। यह श्रद्धा और परंपरा की बात है, कोई चिकित्सीय या वैज्ञानिक उपाय नहीं, और किसी नतीजे का वादा नहीं किया जा सकता।',
  );
  static const L forYou = L('Rudraksha for your Mulank', 'आपके मूलांक का रुद्राक्ष');
  static const L forYou2 = L('Rudraksha for your Bhagyank', 'आपके भाग्यांक का रुद्राक्ष');
  static const L universal = L('For almost everyone', 'लगभग सभी के लिए');
  static const L universalBody = L(
    '5 Mukhi is the most common and most widely recommended bead. Tradition treats it as suitable for almost everyone, and it is also the easiest to find as a genuine bead at a fair price.',
    '5 मुखी सबसे आम और सबसे ज़्यादा बताया जाने वाला मनका है। परंपरा इसे लगभग सभी के लिए उपयुक्त मानती है, और असली 5 मुखी उचित दाम पर मिलना भी सबसे आसान है।',
  );
  static const L linkNote = L(
    'The link between your number and the bead goes through the ruling planet of the number.',
    'आपके अंक और मनके का संबंध अंक के स्वामी ग्रह के ज़रिए बनता है।',
  );
  static const L mukhiLabel = L('Mukhi (faces)', 'मुखी');
  static const L deityLabel = L('Linked deity', 'संबंधित देवता');
  static const L planetLabel = L('Linked planet', 'संबंधित ग्रह');
  static const L mantraLabel = L('Mantra', 'मंत्र');
  static const L focusLabel = L('Traditionally linked with', 'परंपरा में जुड़ा है');
  static const L noteLabel = L('Good to know', 'जानने लायक');
  static const L allTitle = L('All types: 1 to 14 Mukhi', 'सभी प्रकार: 1 से 14 मुखी');
  static const L chooseTitle = L('Rudraksha or gemstone?', 'रुद्राक्ष या रत्न?');
  static const L chooseBody = L(
    'You may choose either one. Many people find rudraksha simpler, because tradition gives it fewer rules about metal, finger and weight, and it is worn with prayer. Gemstones are said to be more specific to a planet. Neither is a replacement for medical, legal or financial advice. If you already wear a gemstone and want to add rudraksha, ask an experienced advisor and listen to how you feel.',
    'आप दोनों में से कोई भी चुन सकते हैं। कई लोगों को रुद्राक्ष ज़्यादा सरल लगता है, क्योंकि परंपरा में इसके लिए धातु, उँगली और वज़न के नियम कम हैं और यह प्रार्थना के साथ पहना जाता है। रत्न किसी ग्रह के लिए ज़्यादा विशेष माना जाता है। दोनों में से कोई भी चिकित्सा, कानूनी या आर्थिक सलाह की जगह नहीं लेता। रत्न पहले से पहन रखा हो और रुद्राक्ष जोड़ना चाहें तो अनुभवी सलाहकार से पूछिए और अपने अनुभव को सुनिए।',
  );

  static const L energiseTitle = L('Energising (pran pratishtha) and wearing', 'प्राण-प्रतिष्ठा और पहनने की विधि');
  static const List<L> energise = [
    L('1) Choose a clean, auspicious day. Monday is Shiva\'s day and is the most common choice; the month of Shravan and Mahashivratri are considered especially good.',
        '1) साफ़ और शुभ दिन चुनिए। सोमवार शिव का दिन है और सबसे आम चुनाव है; श्रावण का महीना और महाशिवरात्रि ख़ास तौर पर शुभ माने जाते हैं।'),
    L('2) Early morning, bathe and wear clean clothes. Keep the bead in clean water or raw milk with a few drops of Ganga water for some time, then wash it and dry it.',
        '2) सुबह जल्दी स्नान करके साफ़ कपड़े पहनिए। मनके को कुछ देर साफ़ पानी या कच्चे दूध में गंगाजल की कुछ बूँदों के साथ रखिए, फिर धोकर सुखा लीजिए।'),
    L('3) Place it before an image or lingam of Shiva, apply a little sandal paste or ash, light a lamp and incense.',
        '3) इसे शिव की मूर्ति या शिवलिंग के सामने रखिए, थोड़ा चंदन या भस्म लगाइए और दीया तथा अगरबत्ती जलाइए।'),
    L('4) Say "Om Namah Shivaya" 108 times (or the mantra of that bead), with a calm mind. This step is what many wearers call the energising.',
        '4) शांत मन से "ॐ नमः शिवाय" 108 बार बोलिए (या उस मनके का मंत्र)। इसी क्रिया को कई पहनने वाले प्राण-प्रतिष्ठा कहते हैं।'),
    L('5) Wear it on a red, yellow or white thread (cotton or silk), or in a silver or gold cap. Wear it so that it touches the body, ideally around the neck or on the wrist.',
        '5) इसे लाल, पीले या सफ़ेद धागे (सूती या रेशमी) में, या चाँदी या सोने के कैप में पहनिए। ऐसे पहनिए कि यह शरीर को छुए, गले में या कलाई पर।'),
    L('6) Say the mantra once or a few times each morning. Regular wearing and regular prayer matter more than size or price.',
        '6) हर सुबह मंत्र एक या कुछ बार बोलिए। आकार या दाम से ज़्यादा नियमित पहनना और नियमित प्रार्थना मायने रखती है।'),
  ];

  static const L rulesTitle = L('Common rules (traditions differ)', 'आम नियम (परंपराएँ अलग-अलग हैं)');
  static const L rulesBody = L(
    'Keep the bead clean and treat it with respect. Many families take it off at a cremation ground and keep it away from unclean places. Many people avoid wearing it during sleep, intimate time and while consuming alcohol or meat; others do not follow these rules. Follow your own family tradition and do what you are comfortable with. Wearing a rudraksha does not need any special diet.',
    'मनके को साफ़ रखिए और आदर से रखिए। कई परिवार श्मशान में इसे उतार देते हैं और अशुद्ध जगहों से दूर रखते हैं। कई लोग सोते समय, अंतरंग समय और शराब या माँस के सेवन के समय इसे नहीं पहनते; कुछ लोग ये नियम नहीं मानते। अपने परिवार की परंपरा मानिए और जिसमें आप सहज हों वही कीजिए। रुद्राक्ष पहनने के लिए किसी ख़ास भोजन की ज़रूरत नहीं।',
  );

  static const L careTitle = L('Care', 'देखभाल');
  static const L careBody = L(
    'Keep it away from perfume, soap, chemicals and heat. Dry it if it gets wet. Now and then, rub a little sesame or mustard oil on it with a soft cloth. Re-thread it when the thread wears out. Keep it in a clean cloth or a prayer place when you are not wearing it.',
    'इसे इत्र, साबुन, रसायन और गर्मी से दूर रखिए। गीला हो जाए तो सुखा लीजिए। कभी-कभी मुलायम कपड़े से थोड़ा तिल या सरसों का तेल लगा दीजिए। धागा घिस जाए तो नया डालिए। न पहनें तब इसे साफ़ कपड़े या पूजा की जगह में रखिए।',
  );

  static const L fakeTitle = L('How to avoid a fake', 'नकली से कैसे बचें');
  static const List<L> fake = [
    L('Count the natural lines (mukhi). They should run from top to bottom on the bead, be clear and look natural, not cut or drawn. Check with a magnifying glass.',
        'प्राकृतिक रेखाएँ (मुखी) गिनिए। वे मनके पर ऊपर से नीचे तक चलती हों, साफ़ और प्राकृतिक दिखें, कटी या बनाई हुई नहीं। आवर्धक काँच से देखिए।'),
    L('A real bead has a natural, slightly uneven surface with small pores. A perfectly smooth, shiny, identical-looking bead is suspicious.',
        'असली मनके की सतह प्राकृतिक, थोड़ी ऊबड़-खाबड़ और छोटे छिद्रों वाली होती है। एकदम चिकना, चमकदार और हू-ब-हू एक जैसा मनका संदिग्ध है।'),
    L('Do not trust the "sinks in water" test. Many fake and treated beads also sink, and some genuine ones float. It proves nothing.',
        '"पानी में डूबना" वाली जाँच पर भरोसा मत कीजिए। कई नकली और उपचारित मनके भी डूबते हैं और कुछ असली तैर भी जाते हैं। इससे कुछ साबित नहीं होता।'),
    L('The most reliable proof is a laboratory report, for example an X-ray that shows the inner chambers matching the mukhi. Buy only with such a report and a written return option.',
        'सबसे भरोसेमंद सबूत प्रयोगशाला की रिपोर्ट है, जैसे एक्स-रे जिसमें अंदर के खाने मुखी से मेल खाते दिखें। केवल ऐसी रिपोर्ट और लिखित वापसी की सुविधा के साथ ही खरीदिए।'),
    L('Be careful with very rare types (1 Mukhi, 14 Mukhi and others) offered cheaply. They are costly when genuine, and fakes made by carving or gluing are common.',
        'बहुत दुर्लभ प्रकार (1 मुखी, 14 मुखी आदि) सस्ते में मिलें तो सावधान रहिए। असली होने पर ये महँगे होते हैं, और तराशकर या चिपकाकर बने नकली आम हैं।'),
    L('Both larger Nepal beads and smaller Indonesian beads are genuine rudraksha. Do not believe anyone who says only one origin is real.',
        'बड़े नेपाली मनके और छोटे इंडोनेशियाई मनके दोनों असली रुद्राक्ष हैं। जो कहे कि केवल एक ही जगह का असली है, उस पर भरोसा मत कीजिए।'),
  ];

  static const L safetyBody = L(
    'Rudraksha is a matter of faith. It is not a medicine and does not replace proper medical care. Spend only what you can comfortably afford.',
    'रुद्राक्ष श्रद्धा की बात है। यह दवा नहीं है और सही चिकित्सा की जगह नहीं लेता। उतना ही खर्च कीजिए जितना आप आराम से कर सकें।',
  );

  /// Which Mukhi suits each birth number (through the ruling planet).
  static const Map<int, List<int>> forRoot = {
    1: [12, 1],
    2: [2],
    3: [5],
    4: [8],
    5: [4],
    6: [6, 13],
    7: [9],
    8: [7, 14],
    9: [3],
  };

  static const Map<int, RudrakshaInfo> mukhis = {
    1: RudrakshaInfo(
      1,
      L('Shiva', 'शिव'),
      L('Sun', 'सूर्य'),
      L('Om Hreem Namah', 'ॐ ह्रीं नमः'),
      L('Clarity, focus and leadership.', 'स्पष्टता, एकाग्रता और नेतृत्व।'),
      L('Very rare and costly. Fakes are very common, so insist on a laboratory report. 12 Mukhi is the usual alternative for the Sun.',
          'बहुत दुर्लभ और महँगा। नकली बहुत आम हैं, इसलिए प्रयोगशाला की रिपोर्ट ज़रूर माँगिए। सूर्य के लिए आम विकल्प 12 मुखी है।'),
    ),
    2: RudrakshaInfo(
      2,
      L('Ardhanarishvara (Shiva and Shakti)', 'अर्धनारीश्वर (शिव और शक्ति)'),
      L('Moon', 'चंद्र'),
      L('Om Namah', 'ॐ नमः'),
      L('Harmony in relationships and a calm mind.', 'रिश्तों में तालमेल और शांत मन।'),
      L('Often worn as a pair or by couples in tradition.', 'परंपरा में अक्सर जोड़े में या दंपत्ति द्वारा पहना जाता है।'),
    ),
    3: RudrakshaInfo(
      3,
      L('Agni (Fire)', 'अग्नि'),
      L('Mars', 'मंगल'),
      L('Om Kleem Namah', 'ॐ क्लीं नमः'),
      L('Confidence, energy and letting go of past worries.', 'आत्मविश्वास, ऊर्जा और पुरानी चिंताएँ छोड़ना।'),
      L('Fairly easy to find.', 'मिलना अपेक्षाकृत आसान।'),
    ),
    4: RudrakshaInfo(
      4,
      L('Brahma', 'ब्रह्मा'),
      L('Mercury', 'बुध'),
      L('Om Hreem Namah', 'ॐ ह्रीं नमः'),
      L('Learning, speech and creativity.', 'सीखना, वाणी और रचनात्मकता।'),
      L('Popular with students and writers.', 'विद्यार्थियों और लेखकों में लोकप्रिय।'),
    ),
    5: RudrakshaInfo(
      5,
      L('Kalagni Rudra (Shiva)', 'कालाग्नि रुद्र (शिव)'),
      L('Jupiter', 'गुरु'),
      L('Om Hreem Namah', 'ॐ ह्रीं नमः'),
      L('Peace of mind and general well-being; used in prayer.', 'मन की शांति और सामान्य सुख; पूजा में प्रयोग।'),
      L('The most common bead. Suitable for almost everyone, and mala beads are mostly 5 Mukhi.',
          'सबसे आम मनका। लगभग सभी के लिए उपयुक्त, और माला के मनके अधिकतर 5 मुखी होते हैं।'),
    ),
    6: RudrakshaInfo(
      6,
      L('Kartikeya', 'कार्तिकेय'),
      L('Venus', 'शुक्र'),
      L('Om Hreem Hum Namah', 'ॐ ह्रीं हुं नमः'),
      L('Willpower, discipline and harmony.', 'इच्छाशक्ति, अनुशासन और सामंजस्य।'),
      L('Easy to find.', 'मिलना आसान।'),
    ),
    7: RudrakshaInfo(
      7,
      L('Mahalakshmi (Saptamatrika)', 'महालक्ष्मी (सप्तमातृका)'),
      L('Saturn', 'शनि'),
      L('Om Hum Namah', 'ॐ हुं नमः'),
      L('Steadiness, perseverance and hope for prosperity.', 'स्थिरता, दृढ़ता और समृद्धि की आशा।'),
      L('Moderately priced.', 'मध्यम दाम।'),
    ),
    8: RudrakshaInfo(
      8,
      L('Ganesha', 'गणेश'),
      L('Rahu', 'राहु'),
      L('Om Hum Namah', 'ॐ हुं नमः'),
      L('Wisdom and removing obstacles.', 'बुद्धि और रुकावटें हटाना।'),
      L('Moderately priced.', 'मध्यम दाम।'),
    ),
    9: RudrakshaInfo(
      9,
      L('Durga', 'दुर्गा'),
      L('Ketu', 'केतु'),
      L('Om Hreem Hum Namah', 'ॐ ह्रीं हुं नमः'),
      L('Courage, energy and a sense of protection.', 'साहस, ऊर्जा और सुरक्षा का एहसास।'),
      L('Often worn on the left side in tradition.', 'परंपरा में अक्सर बाएँ हाथ में पहना जाता है।'),
    ),
    10: RudrakshaInfo(
      10,
      L('Vishnu', 'विष्णु'),
      L('No single planet', 'कोई एक ग्रह नहीं'),
      L('Om Hreem Namah', 'ॐ ह्रीं नमः'),
      L('A feeling of protection and safety.', 'सुरक्षा और संरक्षण का एहसास।'),
      L('Less common.', 'कम मिलता है।'),
    ),
    11: RudrakshaInfo(
      11,
      L('Hanuman (Rudra)', 'हनुमान (रुद्र)'),
      L('No single planet', 'कोई एक ग्रह नहीं'),
      L('Om Hreem Hum Namah', 'ॐ ह्रीं हुं नमः'),
      L('Courage and determination.', 'साहस और दृढ़ निश्चय।'),
      L('Less common.', 'कम मिलता है।'),
    ),
    12: RudrakshaInfo(
      12,
      L('Surya (Aditya)', 'सूर्य (आदित्य)'),
      L('Sun', 'सूर्य'),
      L('Om Krom Shom Raum Namah', 'ॐ क्रौं श्रौं रौं नमः'),
      L('Leadership and confidence.', 'नेतृत्व और आत्मविश्वास।'),
      L('The usual, more available alternative to 1 Mukhi.', '1 मुखी का आम और ज़्यादा उपलब्ध विकल्प।'),
    ),
    13: RudrakshaInfo(
      13,
      L('Kamadeva / Indra', 'कामदेव / इंद्र'),
      L('Venus', 'शुक्र'),
      L('Om Hreem Namah', 'ॐ ह्रीं नमः'),
      L('Charm, attraction and ambition.', 'आकर्षण, लोकप्रियता और महत्वाकांक्षा।'),
      L('Rare and costly. Be careful of fakes.', 'दुर्लभ और महँगा। नकली से सावधान रहिए।'),
    ),
    14: RudrakshaInfo(
      14,
      L('Hanuman / Shiva\'s third eye', 'हनुमान / शिव का तीसरा नेत्र'),
      L('Saturn', 'शनि'),
      L('Om Namah Shivaya', 'ॐ नमः शिवाय'),
      L('Intuition and resolve.', 'अंतर्ज्ञान और संकल्प।'),
      L('Rare and costly. Be careful of fakes.', 'दुर्लभ और महँगा। नकली से सावधान रहिए।'),
    ),
  };
}
