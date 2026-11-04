import 'package:flutter/painting.dart';

import 'root_profiles.dart' show L;

/// Shape used to draw a stone.
enum GemShape { faceted, round, oval, catsEye }

/// Traditional guidance for one birth number's stone. This is a traditional
/// belief, not science; ranges differ between families and advisors.
class GemInfo {
  final int root;
  final String id; // used for an optional photo: assets/images/gem_<id>.jpg
  final L gem;
  final L alt;
  final L planet;
  final int finger; // 0 thumb, 1 index, 2 middle, 3 ring, 4 little
  final L metal;
  final L day;
  final L weight;
  final L mantra;
  final L caution;
  final Color color;
  final GemShape shape;

  const GemInfo({
    required this.root,
    required this.id,
    required this.gem,
    required this.alt,
    required this.planet,
    required this.finger,
    required this.metal,
    required this.day,
    required this.weight,
    required this.mantra,
    required this.caution,
    required this.color,
    required this.shape,
  });
}

class GemstoneGuide {
  static const List<L> fingerNames = [
    L('Thumb', 'अंगूठा'),
    L('Index finger', 'तर्जनी (पहली उँगली)'),
    L('Middle finger', 'मध्यमा (बीच की उँगली)'),
    L('Ring finger', 'अनामिका (तीसरी उँगली)'),
    L('Little finger', 'कनिष्ठा (छोटी उँगली)'),
  ];

  static const L title = L('Gemstone Guide', 'रत्न मार्गदर्शन');
  static const L intro = L(
    'Traditional guidance on which stone is linked with your birth number, how heavy it should be, which finger and day to use, and how to wear it. Gemstones are a traditional belief, not a medical or scientific remedy, and nobody can promise a result. Never spend more than you can comfortably afford.',
    'आपके जन्म के अंक से कौन सा रत्न जुड़ा है, उसका वज़न कितना हो, कौन सी उँगली और कौन सा दिन चुनें, और उसे कैसे पहनें, इसकी पारंपरिक जानकारी। रत्न एक पारंपरिक मान्यता है, कोई चिकित्सीय या वैज्ञानिक उपाय नहीं, और कोई नतीजे का वादा नहीं कर सकता। अपनी सहूलियत से ज़्यादा कभी खर्च मत कीजिए।',
  );
  static const L mainStone = L('Stone for your Mulank', 'आपके मूलांक का रत्न');
  static const L secondStone = L('Stone for your Bhagyank', 'आपके भाग्यांक का रत्न');
  static const L allStones = L('All nine stones', 'सभी नौ रत्न');
  static const L stone = L('Stone', 'रत्न');
  static const L substitute = L('Lower-cost substitute', 'सस्ता विकल्प (उपरत्न)');
  static const L planetLabel = L('Linked planet', 'संबंधित ग्रह');
  static const L fingerLabel = L('Finger', 'उँगली');
  static const L metalLabel = L('Metal for the ring', 'अँगूठी की धातु');
  static const L dayLabel = L('Day and time to start', 'शुरू करने का दिन और समय');
  static const L weightLabel = L('Usual weight', 'आम वज़न');
  static const L mantraLabel = L('Mantra', 'मंत्र');
  static const L cautionLabel = L('Special care', 'ख़ास ध्यान');

  static const L handTitle = L('Which hand?', 'कौन सा हाथ?');
  static const L handBody = L(
    'Practice differs. Many families use the right hand for men and the left hand for women; many advisors use the right hand for everyone. Follow your family tradition or your advisor, and wear it on the same hand every day.',
    'परंपराएँ अलग-अलग हैं। कई परिवारों में पुरुष दाएँ हाथ में और महिलाएँ बाएँ हाथ में पहनती हैं; कई सलाहकार सभी के लिए दायाँ हाथ बताते हैं। अपने परिवार की परंपरा या सलाहकार की बात मानिए और रोज़ एक ही हाथ में पहनिए।',
  );

  static const L weightTitle = L('How heavy should the stone be?', 'रत्न का वज़न कितना हो?');
  static const L weightIntro = L(
    'Weight is counted in ratti (1 ratti is about 0.91 carat, or about 0.18 gram). A common rule of thumb is: body weight in kg divided by 10 gives the ratti (for example 60 kg is about 6 ratti). These are traditional approximations, and a stone that is too small is said to give little effect, while a very large one is not better.',
    'वज़न रत्ती में गिना जाता है (1 रत्ती लगभग 0.91 कैरेट, यानी लगभग 0.18 ग्राम)। एक आम नियम है: शरीर का वज़न किलो में, 10 से भाग देने पर रत्ती मिलती है (जैसे 60 किलो के लिए लगभग 6 रत्ती)। ये पारंपरिक अनुमान हैं। बहुत छोटा रत्न कम असर वाला माना जाता है, और बहुत बड़ा रत्न भी ज़्यादा अच्छा नहीं होता।',
  );

  static const List<List<L>> ageTable = [
    [
      L('Below 12 years', '12 साल से छोटे'),
      L('Usually not advised. If elders insist, a small 2-3 ratti stone and only with an experienced advisor.',
          'आम तौर पर सलाह नहीं दी जाती। बड़ों के कहने पर छोटा 2-3 रत्ती का रत्न, वो भी अनुभवी सलाहकार के साथ।'),
    ],
    [
      L('12 to 25 years', '12 से 25 साल'),
      L('About 3 to 5 ratti, a lighter stone.', 'लगभग 3 से 5 रत्ती, हल्का रत्न।'),
    ],
    [
      L('26 to 50 years', '26 से 50 साल'),
      L('About 5 to 7 ratti, or body weight in kg divided by 10.',
          'लगभग 5 से 7 रत्ती, या शरीर का वज़न (किलो) ÷ 10।'),
    ],
    [
      L('Above 50 years', '50 साल से ऊपर'),
      L('About 5 to 6 ratti is enough. Comfort matters more than size.',
          'लगभग 5 से 6 रत्ती काफ़ी है। आकार से ज़्यादा आराम मायने रखता है।'),
    ],
  ];

  static const L stepsTitle = L('How to wear it, step by step', 'कैसे पहनें, कदम-दर-कदम');
  static const List<L> steps = [
    L('1) Buy a natural, untreated stone from a trusted seller, with a laboratory certificate and a written return option. Cheap glass and lab-made stones are common.',
        '1) भरोसेमंद दुकान से प्राकृतिक, बिना उपचार वाला रत्न लीजिए, प्रयोगशाला के प्रमाणपत्र और लिखित वापसी की सुविधा के साथ। सस्ते काँच और बनावटी रत्न आम हैं।'),
    L('2) Ask the jeweller to make the ring in the right metal so that the stone touches your skin (an open back).',
        '2) सुनार से सही धातु में अँगूठी बनवाइए, ऐसी कि रत्न आपकी त्वचा को छुए (पीछे से खुला)।'),
    L('3) Choose the right day (see the day and time for your stone), ideally in the bright half of the month, and avoid eclipse days.',
        '3) सही दिन चुनिए (अपने रत्न का दिन और समय देखिए), अच्छा हो कि महीने का शुक्ल पक्ष हो, और ग्रहण के दिन से बचिए।'),
    L('4) The night before, keep the ring in raw milk mixed with clean water and a few tulsi leaves. In the morning wash it with clean water.',
        '4) एक रात पहले अँगूठी को कच्चे दूध और साफ़ पानी में कुछ तुलसी के पत्तों के साथ रखिए। सुबह साफ़ पानी से धो लीजिए।'),
    L('5) Bathe, sit facing east, light a small lamp and say the stone\'s mantra 108 times. Then wear the ring with a simple prayer.',
        '5) स्नान कीजिए, पूर्व की ओर मुँह करके बैठिए, छोटा दीया जलाइए और रत्न का मंत्र 108 बार बोलिए। फिर सादी प्रार्थना के साथ अँगूठी पहनिए।'),
    L('6) Trial period: wear it for 3 days and notice how you feel. If you feel uneasy, restless or unwell, take it off and ask your advisor.',
        '6) परीक्षण: 3 दिन पहनकर देखिए कि कैसा लग रहा है। बेचैनी या असहजता हो तो उतार दीजिए और सलाहकार से पूछिए।'),
    L('7) Keep it clean. If the stone cracks, chips or is lost, change it. Wear it at least for some months before judging.',
        '7) साफ़ रखिए। रत्न टूटे, चटके या खो जाए तो बदल लीजिए। राय बनाने से पहले कम से कम कुछ महीने पहनकर देखिए।'),
  ];

  static const L buyTitle = L('Before you buy', 'खरीदने से पहले');
  static const L buyBody = L(
    'A stone should be natural, clear and lively, with no deep cracks or dark spots, and the colour should look even. Ask for the certificate from a recognised laboratory. A lower-cost substitute stone is acceptable in tradition, so there is no need to buy an expensive one. Do not buy from anyone who frightens you or pushes you to buy fast.',
    'रत्न प्राकृतिक, साफ़ और चमकदार होना चाहिए, उसमें गहरी दरार या काले धब्बे न हों और रंग एक-सा दिखे। किसी मान्य प्रयोगशाला का प्रमाणपत्र माँगिए। परंपरा में सस्ता विकल्प (उपरत्न) भी चलता है, इसलिए महँगा रत्न लेना ज़रूरी नहीं। जो आपको डराए या जल्दी खरीदने पर ज़ोर दे, उससे मत खरीदिए।',
  );

  static const L safetyTitle = L('Please remember', 'ज़रूर याद रखिए');
  static const L safetyBody = L(
    'A gemstone is not a medicine. For health, money or legal matters, take proper professional advice. Wear it only if it feels right for you, and stop if you feel uneasy.',
    'रत्न कोई दवा नहीं है। सेहत, पैसे या कानूनी मामलों में सही पेशेवर सलाह लीजिए। तभी पहनिए जब आपको ठीक लगे, और असहज लगे तो छोड़ दीजिए।',
  );

  static const Map<int, GemInfo> gems = {
    1: GemInfo(
      root: 1,
      id: 'ruby',
      gem: L('Ruby (Manik)', 'माणिक (रूबी)'),
      alt: L('Red spinel, red garnet', 'लाल स्पाइनल, लाल गार्नेट'),
      planet: L('Sun', 'सूर्य'),
      finger: 3,
      metal: L('Gold (or copper)', 'सोना (या ताँबा)'),
      day: L('Sunday morning, soon after sunrise', 'रविवार सुबह, सूर्योदय के कुछ देर बाद'),
      weight: L('About 3 to 6 ratti', 'लगभग 3 से 6 रत्ती'),
      mantra: L('Om Ghrini Suryaya Namah', 'ॐ घृणि सूर्याय नमः'),
      caution: L('Feels warm. People who are very short-tempered are often advised to go slowly.',
          'गर्म प्रकृति का माना जाता है। बहुत गुस्सैल स्वभाव वालों को धीरे-धीरे आगे बढ़ने की सलाह दी जाती है।'),
      color: Color(0xFFD81B3C),
      shape: GemShape.faceted,
    ),
    2: GemInfo(
      root: 2,
      id: 'pearl',
      gem: L('Pearl (Moti)', 'मोती'),
      alt: L('Moonstone', 'चंद्रकांत मणि (मूनस्टोन)'),
      planet: L('Moon', 'चंद्र'),
      finger: 4,
      metal: L('Silver', 'चाँदी'),
      day: L('Monday morning or evening', 'सोमवार सुबह या शाम'),
      weight: L('About 4 to 7 ratti', 'लगभग 4 से 7 रत्ती'),
      mantra: L('Om Som Somaya Namah', 'ॐ सों सोमाय नमः'),
      caution: L('Real pearls are delicate. Keep away from perfume, soap and heat, and wipe with a soft cloth.',
          'असली मोती नाज़ुक होता है। इत्र, साबुन और गर्मी से दूर रखिए और मुलायम कपड़े से पोंछिए।'),
      color: Color(0xFFF1ECE4),
      shape: GemShape.round,
    ),
    3: GemInfo(
      root: 3,
      id: 'yellow_sapphire',
      gem: L('Yellow sapphire (Pukhraj)', 'पुखराज'),
      alt: L('Citrine, yellow topaz', 'सुनहला (सिट्रीन), पीला टोपाज़'),
      planet: L('Jupiter', 'गुरु (बृहस्पति)'),
      finger: 1,
      metal: L('Gold', 'सोना'),
      day: L('Thursday morning', 'गुरुवार सुबह'),
      weight: L('About 3 to 7 ratti', 'लगभग 3 से 7 रत्ती'),
      mantra: L('Om Brim Brihaspataye Namah', 'ॐ बृं बृहस्पतये नमः'),
      caution: L('A fairly gentle stone in tradition. Make sure it is natural, because yellow glass is common.',
          'परंपरा में अपेक्षाकृत सौम्य रत्न माना जाता है। प्राकृतिक होना पक्का कीजिए, क्योंकि पीला काँच आम है।'),
      color: Color(0xFFF2B705),
      shape: GemShape.faceted,
    ),
    4: GemInfo(
      root: 4,
      id: 'hessonite',
      gem: L('Hessonite (Gomed)', 'गोमेद'),
      alt: L('Orange garnet', 'नारंगी गार्नेट'),
      planet: L('Rahu', 'राहु'),
      finger: 2,
      metal: L('Silver or ashtadhatu', 'चाँदी या अष्टधातु'),
      day: L('Saturday evening', 'शनिवार शाम'),
      weight: L('About 5 to 8 ratti', 'लगभग 5 से 8 रत्ती'),
      mantra: L('Om Ram Rahave Namah', 'ॐ रां राहवे नमः'),
      caution: L('Often advised to try it for a short period first and notice how you feel.',
          'अक्सर पहले थोड़े समय पहनकर देखने की सलाह दी जाती है कि कैसा लगता है।'),
      color: Color(0xFFC4601A),
      shape: GemShape.faceted,
    ),
    5: GemInfo(
      root: 5,
      id: 'emerald',
      gem: L('Emerald (Panna)', 'पन्ना'),
      alt: L('Green tourmaline, peridot', 'हरा टूरमलीन, पेरिडॉट'),
      planet: L('Mercury', 'बुध'),
      finger: 4,
      metal: L('Gold (or silver)', 'सोना (या चाँदी)'),
      day: L('Wednesday morning', 'बुधवार सुबह'),
      weight: L('About 3 to 6 ratti', 'लगभग 3 से 6 रत्ती'),
      mantra: L('Om Bum Budhaya Namah', 'ॐ बुं बुधाय नमः'),
      caution: L('Emeralds often have small natural lines. Avoid deep cracks, and do not clean with harsh chemicals.',
          'पन्ने में अक्सर छोटी प्राकृतिक रेखाएँ होती हैं। गहरी दरारों से बचिए और कड़े रसायनों से साफ़ मत कीजिए।'),
      color: Color(0xFF1F9D5C),
      shape: GemShape.faceted,
    ),
    6: GemInfo(
      root: 6,
      id: 'diamond',
      gem: L('Diamond (Heera) or white sapphire', 'हीरा या सफ़ेद पुखराज'),
      alt: L('White sapphire, opal, white zircon', 'सफ़ेद पुखराज, ओपल, सफ़ेद ज़िरकॉन'),
      planet: L('Venus', 'शुक्र'),
      finger: 2,
      metal: L('Silver, white gold or platinum', 'चाँदी, सफ़ेद सोना या प्लैटिनम'),
      day: L('Friday morning', 'शुक्रवार सुबह'),
      weight: L('Diamond about 0.5 to 1 carat; white sapphire about 5 to 7 ratti',
          'हीरा लगभग 0.5 से 1 कैरेट; सफ़ेद पुखराज लगभग 5 से 7 रत्ती'),
      mantra: L('Om Shum Shukraya Namah', 'ॐ शुं शुक्राय नमः'),
      caution: L('Diamonds are costly. A white sapphire or opal is an accepted substitute, so you need not stretch your budget.',
          'हीरा महँगा होता है। सफ़ेद पुखराज या ओपल मान्य विकल्प हैं, इसलिए बजट खींचने की ज़रूरत नहीं।'),
      color: Color(0xFFBFE3F2),
      shape: GemShape.faceted,
    ),
    7: GemInfo(
      root: 7,
      id: 'cats_eye',
      gem: L('Cat\'s eye (Lehsunia)', 'लहसुनिया (कैट्स आई)'),
      alt: L('Tiger\'s eye', 'टाइगर आई'),
      planet: L('Ketu', 'केतु'),
      finger: 2,
      metal: L('Silver or ashtadhatu', 'चाँदी या अष्टधातु'),
      day: L('Saturday evening (some advisors say Tuesday)', 'शनिवार शाम (कुछ सलाहकार मंगलवार बताते हैं)'),
      weight: L('About 5 to 8 ratti', 'लगभग 5 से 8 रत्ती'),
      mantra: L('Om Kem Ketave Namah', 'ॐ कें केतवे नमः'),
      caution: L('A real cat\'s eye shows a thin bright line that moves when you turn the stone. Often advised to try for a short period first.',
          'असली लहसुनिया में एक पतली चमकीली रेखा होती है जो पत्थर घुमाने पर हिलती है। अक्सर पहले थोड़े समय पहनकर देखने की सलाह दी जाती है।'),
      color: Color(0xFF8C9A2D),
      shape: GemShape.catsEye,
    ),
    8: GemInfo(
      root: 8,
      id: 'blue_sapphire',
      gem: L('Blue sapphire (Neelam)', 'नीलम'),
      alt: L('Amethyst, lapis lazuli, blue topaz', 'जामुनिया (एमेथिस्ट), लाजवर्त, नीला टोपाज़'),
      planet: L('Saturn', 'शनि'),
      finger: 2,
      metal: L('Silver or panchdhatu', 'चाँदी या पंचधातु'),
      day: L('Saturday evening', 'शनिवार शाम'),
      weight: L('About 3 to 5 ratti, start small', 'लगभग 3 से 5 रत्ती, छोटे से शुरू कीजिए'),
      mantra: L('Om Sham Shanaishcharaya Namah', 'ॐ शं शनैश्चराय नमः'),
      caution: L('Tradition calls this a strong stone that suits some people and not others. Always do the 3-day trial first (for example keep it near you for 3 days before wearing), take experienced advice, and stop if you feel uneasy. A substitute such as amethyst is gentler.',
          'परंपरा में इसे तेज़ असर वाला रत्न माना जाता है जो कुछ लोगों को सूट करता है और कुछ को नहीं। हमेशा पहले 3 दिन का परीक्षण कीजिए (जैसे पहनने से पहले 3 दिन अपने पास रखिए), अनुभवी सलाह लीजिए, और असहज लगे तो छोड़ दीजिए। जामुनिया जैसा विकल्प ज़्यादा सौम्य है।'),
      color: Color(0xFF1F3F9E),
      shape: GemShape.faceted,
    ),
    9: GemInfo(
      root: 9,
      id: 'red_coral',
      gem: L('Red coral (Moonga)', 'मूँगा'),
      alt: L('Carnelian, red jasper', 'कार्नेलियन (लाल अकीक), लाल जैस्पर'),
      planet: L('Mars', 'मंगल'),
      finger: 3,
      metal: L('Gold or copper', 'सोना या ताँबा'),
      day: L('Tuesday morning', 'मंगलवार सुबह'),
      weight: L('About 5 to 9 ratti', 'लगभग 5 से 9 रत्ती'),
      mantra: L('Om Am Angarakaya Namah', 'ॐ अं अङ्गारकाय नमः'),
      caution: L('Coral comes from the sea and is often dyed. Ask the seller to confirm it is natural. Hot-tempered people are often advised to go slowly.',
          'मूँगा समुद्र से आता है और अक्सर रंगा हुआ मिलता है। विक्रेता से प्राकृतिक होने की पुष्टि करवाइए। गरम स्वभाव वालों को धीरे चलने की सलाह दी जाती है।'),
      color: Color(0xFFE4472E),
      shape: GemShape.oval,
    ),
  };
}
