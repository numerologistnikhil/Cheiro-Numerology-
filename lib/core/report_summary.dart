import 'report_pages.dart' show PBi;

/// Labels and texts for the one-page summary and the Lo Shu section of the
/// report.
class ReportSummary {
  static const PBi title = PBi('Your report in one page', 'एक पन्ने में आपकी रिपोर्ट');
  static const PBi intro = PBi(
    'This page is the short version of everything that follows. Keep it handy, and read the next pages when you want the full story behind each point.',
    'यह पन्ना आगे की पूरी रिपोर्ट का छोटा रूप है। इसे सँभालकर रखिए, और हर बात की पूरी कहानी जानने के लिए आगे के पन्ने पढ़िए।',
  );
  static const PBi gridCaption = PBi(
    'Lo Shu grid made from your date of birth. A number you have is shown in its box (twice or more if it repeats). A dash means that number is missing.',
    'आपकी जन्म तिथि से बनी लो शू ग्रिड। जो अंक आपके पास है वह अपने खाने में दिखता है (दोहराने पर दो या ज़्यादा बार)। डैश का मतलब है कि वह अंक नहीं है।',
  );
  static const PBi luckyNumbers = PBi('Lucky numbers', 'शुभ अंक');
  static const PBi luckyColours = PBi('Lucky colours', 'शुभ रंग');
  static const PBi luckyDays = PBi('Lucky days', 'शुभ दिन');
  static const PBi gemstone = PBi('Gemstone (belief)', 'रत्न (मान्यता)');
  static const PBi missingNumbers = PBi('Missing numbers', 'जो अंक नहीं हैं');
  static const PBi strongLines = PBi('Complete lines', 'पूरी रेखाएँ');
  static const PBi nameGuide = PBi('Name guide', 'नाम का संकेत');
  static const PBi none = PBi('None', 'कोई नहीं');
  static const PBi next = PBi(
    'The next pages explain each of these points in simple words.',
    'आगे के पन्ने इनमें से हर बात को सरल शब्दों में समझाते हैं।',
  );

  static const PBi loShuTitle = PBi('Your Lo Shu grid', 'आपकी लो शू ग्रिड');
  static const PBi loShuIntro = PBi(
    'The Lo Shu grid is an old Chinese number square. We fill it with the digits of your date of birth and add your Mulank and Bhagyank. Every number you have is a quality you carry. Every number that is missing is only a quality that asks for a little more practice.',
    'लो शू ग्रिड एक पुराना चीनी अंक-वर्ग है। हम इसमें आपकी जन्म तिथि के अंक भरते हैं और आपका मूलांक और भाग्यांक जोड़ते हैं। जो अंक आपके पास है वह आपकी एक खूबी है। जो अंक नहीं है वह बस ऐसी बात है जिसपर थोड़े ज़्यादा अभ्यास की ज़रूरत है।',
  );
  static const PBi haveTitle = PBi('Numbers you have', 'जो अंक आपके पास हैं');
  static const PBi lackTitle = PBi('Numbers that are missing', 'जो अंक नहीं हैं');
  static const PBi linesTitle = PBi('Your complete lines', 'आपकी पूरी रेखाएँ');
  static const PBi noLines = PBi(
    'No full line is formed in your grid. This is common and not a problem. It only means your strengths come from single numbers rather than from a full line.',
    'आपकी ग्रिड में कोई पूरी रेखा नहीं बनी है। यह आम बात है और कोई समस्या नहीं है। इसका मतलब बस इतना है कि आपकी ताक़त पूरी रेखा से नहीं, अलग-अलग अंकों से आती है।',
  );
  static const PBi noMissing = PBi(
    'No number is missing in your grid. All nine qualities are present.',
    'आपकी ग्रिड में कोई अंक गायब नहीं है। सभी नौ गुण मौजूद हैं।',
  );
  static const PBi repeatNote = PBi(
    'This number appears more than once, so this quality is strong in you. Keep it balanced, because too much of a good thing can turn into stubbornness or excess.',
    'यह अंक एक से ज़्यादा बार आया है, इसलिए यह गुण आपमें मज़बूत है। इसे संतुलित रखिए, क्योंकि अच्छी चीज़ भी ज़्यादा हो जाए तो ज़िद या अति बन सकती है।',
  );
  static const PBi loShuNote = PBi(
    'Different books read the Lo Shu grid slightly differently. Use this as a gentle guide, not a fixed verdict.',
    'अलग-अलग किताबें लो शू ग्रिड को थोड़ा अलग तरह से पढ़ती हैं। इसे नरम मार्गदर्शन की तरह लीजिए, पक्के फ़ैसले की तरह नहीं।',
  );
  static const PBi appears = PBi('appears', 'आया');
  static const PBi times = PBi('time(s)', 'बार');
  static const PBi number = PBi('Number', 'अंक');
}
