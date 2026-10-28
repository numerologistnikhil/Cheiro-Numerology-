import 'root_profiles.dart' show L;

/// Lo Shu texts used by the PDF report (same wording as the Lo Shu screen).
class LoShuText {
  /// Names of the eight lines, in the same order as [LoShu.planes].
  static const List<L> planeNames = [
    L('Mental line', 'सोच की रेखा'),
    L('Emotional line', 'भावना की रेखा'),
    L('Practical line', 'व्यावहारिक रेखा'),
    L('Thought line', 'विचार की रेखा'),
    L('Willpower line', 'इच्छा-शक्ति की रेखा'),
    L('Action line', 'कर्म की रेखा'),
    L('Determination line', 'दृढ़ता की रेखा'),
    L('Inner balance line', 'आंतरिक संतुलन की रेखा'),
  ];

  static const List<L> planeMeanings = [
    L('Strong thinking, memory and planning.',
        'सोचने, याददाश्त और योजना बनाने की अच्छी शक्ति।'),
    L('Feelings, intuition and creativity flow easily.',
        'भावनाएँ, अंतर्ज्ञान और रचनात्मकता सहज रूप से बहती हैं।'),
    L('Good at turning plans into results, and at handling money and daily work.',
        'योजनाओं को नतीजों में बदलने और पैसे व रोज़ के काम सँभालने में अच्छे।'),
    L('You think clearly and can organise your ideas.',
        'आप साफ़ सोचते हैं और विचारों को सलीक़े से सजा लेते हैं।'),
    L('Strong will; you can stay with a goal.',
        'इच्छा-शक्ति मज़बूत; आप लक्ष्य पर टिके रह सकते हैं।'),
    L('You turn feelings and intuition into action.',
        'आप भावना और अंतर्ज्ञान को कर्म में बदल लेते हैं।'),
    L('Steady and determined; you finish what you start.',
        'स्थिर और दृढ़; जो शुरू करते हैं उसे पूरा करते हैं।'),
    L('Calm, balanced and patient in hard times.',
        'कठिन समय में शांत, संतुलित और धैर्यवान।'),
  ];

  /// What a number gives when it is present.
  static const Map<int, L> have = {
    1: L('Self-confidence, leadership and a clear voice.',
        'आत्मविश्वास, नेतृत्व और अपनी बात साफ़ कहने की ताक़त।'),
    2: L('Sensitivity, cooperation and good intuition.',
        'संवेदनशीलता, सहयोग और अच्छा अंतर्ज्ञान।'),
    3: L('Creativity, learning and the joy of expression.',
        'रचनात्मकता, सीखने की ललक और अपनी बात कहने का आनंद।'),
    4: L('Discipline, order and practical hard work.',
        'अनुशासन, व्यवस्था और व्यावहारिक मेहनत।'),
    5: L('Balance, communication and the ability to adapt.',
        'संतुलन, संवाद और ख़ुद को ढाल लेने की क्षमता।'),
    6: L('Care for family, and love of comfort and beauty.',
        'परिवार की परवाह, आराम और सुंदरता से प्रेम।'),
    7: L('Depth, analysis and spiritual interest.',
        'गहराई, विश्लेषण और आध्यात्मिक रुचि।'),
    8: L('Responsibility, money sense and patience.',
        'ज़िम्मेदारी, पैसे की समझ और धैर्य।'),
    9: L('Energy, courage and a wish to serve others.',
        'ऊर्जा, साहस और दूसरों की सेवा की इच्छा।'),
  };

  /// A gentle tip when a number is missing.
  static const Map<int, L> lack = {
    1: L('You may hold back from speaking up. Practise giving your opinion '
        'early and take small steps to lead.',
        'आप अपनी बात कहने से हिचक सकते हैं। अपनी राय जल्दी रखने और '
        'छोटे-छोटे नेतृत्व के कदम उठाने का अभ्यास करें।'),
    2: L('Patience in relationships may be harder. Practise listening and give '
        'feelings a little time.',
        'रिश्तों में धैर्य थोड़ा कठिन लग सकता है। सुनने का अभ्यास करें और '
        'भावनाओं को थोड़ा समय दें।'),
    3: L('Showing feelings may take effort. Writing, singing or talking with a '
        'friend can help.',
        'भावनाएँ जताना मेहनत माँग सकता है। लिखना, गाना या दोस्त से बात करना '
        'मदद करता है।'),
    4: L('Routine and planning may need effort. A simple daily list and fixed '
        'timings help.',
        'दिनचर्या और योजना में मेहनत लग सकती है। रोज़ की एक सरल सूची और '
        'तय समय मदद करते हैं।'),
    5: L('Balance and quick decisions may need effort. Keep a steady routine '
        'and think before big choices.',
        'संतुलन और जल्दी फैसले लेने में मेहनत लग सकती है। नियमित दिनचर्या रखें '
        'और बड़े फैसलों से पहले सोचें।'),
    6: L('Home and family comfort may need extra attention. Spend small, '
        'regular time with loved ones.',
        'घर और परिवार के सुकून पर अतिरिक्त ध्यान देना पड़ सकता है। अपनों के साथ '
        'थोड़ा-थोड़ा नियमित समय बिताएँ।'),
    7: L('Quiet reflection may be rare. A few minutes of silence or a short walk '
        'each day helps.',
        'शांत चिंतन कम मिल पाता है। रोज़ कुछ मिनट मौन या छोटी सैर मदद करती है।'),
    8: L('Money planning and patience may need effort. Save a fixed small '
        'amount each month.',
        'पैसे की योजना और धैर्य में मेहनत लग सकती है। हर महीने एक तय छोटी रक़म '
        'बचाएँ।'),
    9: L('Staying energetic for long goals may be hard. Light daily exercise and '
        'helping others restore energy.',
        'लंबे लक्ष्यों के लिए ऊर्जा बनाए रखना कठिन हो सकता है। रोज़ हल्का व्यायाम '
        'और दूसरों की मदद ऊर्जा लौटाती है।'),
  };

}
