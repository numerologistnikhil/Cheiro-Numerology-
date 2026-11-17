// Ank Dhara - Angel Numbers (English + Hindi)
// Pure Dart: koi dusri file ya package ki zarurat nahi.
// Use: AngelNumbers.all  -> sab angel numbers ki list
//      AngelNumbers.linksForDob(dob, year) -> DOB se kitna judte hain
//      AngelNumbers.dobParagraph(dob, year, hindi) -> PDF/app ke liye lamba paragraph

class AngelNumber {
  final String number;
  final List<int> keyDigits;
  final String titleEn, titleHi;
  final String meaningEn, meaningHi;
  final String messageEn, messageHi;
  final String loveEn, loveHi;
  final String careerEn, careerHi;
  final String actionEn, actionHi;

  const AngelNumber({
    required this.number,
    required this.keyDigits,
    required this.titleEn,
    required this.titleHi,
    required this.meaningEn,
    required this.meaningHi,
    required this.messageEn,
    required this.messageHi,
    required this.loveEn,
    required this.loveHi,
    required this.careerEn,
    required this.careerHi,
    required this.actionEn,
    required this.actionHi,
  });

  String title(bool hi) => hi ? titleHi : titleEn;
  String meaning(bool hi) => hi ? meaningHi : meaningEn;
  String message(bool hi) => hi ? messageHi : messageEn;
  String love(bool hi) => hi ? loveHi : loveEn;
  String career(bool hi) => hi ? careerHi : careerEn;
  String action(bool hi) => hi ? actionHi : actionEn;
}

class DobLink {
  final AngelNumber angel;
  final int strength; // 0 = seedha nahi, 1 = halka, 2 = achha, 3 = bahut gehra
  final String reasonEn, reasonHi;
  const DobLink(this.angel, this.strength, this.reasonEn, this.reasonHi);

  String label(bool hi) {
    switch (strength) {
      case 3:
        return hi ? 'बहुत गहरा संबंध' : 'Very strong link';
      case 2:
        return hi ? 'अच्छा संबंध' : 'Good link';
      case 1:
        return hi ? 'हल्का संबंध' : 'Light link';
      default:
        return hi ? 'सीधा संबंध नहीं' : 'No direct link';
    }
  }

  String reason(bool hi) => hi ? reasonHi : reasonEn;
}

class AngelNumbers {
  // ---------- Intro texts ----------
  static String introTitle(bool hi) =>
      hi ? 'एंजल नंबर क्या होते हैं?' : 'What are Angel Numbers?';

  static String intro(bool hi) => hi ? _introHi : _introEn;

  static const String _introEn =
      'Angel numbers are repeating number patterns such as 111, 222, 333 or 1111 '
      'that people notice again and again in daily life - on a clock, a bill, '
      'a vehicle number plate, a phone screen or a page number. In numerology and '
      'spiritual belief, such repeated numbers are seen as gentle messages that '
      'ask you to pause, think and notice what is going on in your life at that moment.\n\n'
      'Each number carries the energy of its digit. A digit repeated three or four '
      'times is believed to make that energy louder, so the message is considered '
      'more important. The meaning is never a command and never a fear - it is a '
      'friendly direction, like a signboard on a road.\n\n'
      'Please remember: this is guidance based on numerology and spiritual belief, '
      'not a scientific proof. Use it to reflect and to feel hopeful, and always '
      'take big life decisions with practical thinking and trusted advice.';

  static const String _introHi =
      'एंजल नंबर वे दोहराए जाने वाले अंक होते हैं, जैसे 111, 222, 333 या 1111, '
      'जो रोज़मर्रा की ज़िंदगी में बार-बार आपकी नज़र में आते हैं - घड़ी में, बिल पर, '
      'गाड़ी की नंबर प्लेट पर, मोबाइल स्क्रीन पर या किसी पन्ने के नंबर में। अंक शास्त्र और '
      'आध्यात्मिक मान्यता में ऐसे दोहराए गए अंकों को एक कोमल संदेश माना जाता है, '
      'जो आपसे कहता है कि थोड़ा रुकिए, सोचिए और देखिए कि उस समय आपकी ज़िंदगी में क्या चल रहा है।\n\n'
      'हर अंक अपने मूल अंक की ऊर्जा लेकर आता है। जब कोई अंक तीन या चार बार दोहराया जाता है, तो माना जाता '
      'है कि उसकी ऊर्जा और तेज़ हो जाती है और संदेश ज़्यादा ज़रूरी बन जाता है। इसका मतलब कभी आदेश '
      'या डर नहीं होता - यह रास्ते में लगे संकेत-बोर्ड की तरह एक दोस्ताना दिशा है।\n\n'
      'कृपया याद रखें: यह अंक शास्त्र और आध्यात्मिक मान्यता पर आधारित मार्गदर्शन है, कोई वैज्ञानिक '
      'प्रमाण नहीं। इसे सोचने और उम्मीद पाने के लिए इस्तेमाल करें, और जीवन के बड़े फ़ैसले हमेशा '
      'व्यावहारिक सोच और भरोसेमंद सलाह के साथ लें।';

  static String dobTitle(bool hi) => hi
      ? 'क्या एंजल नंबर आपकी जन्मतिथि से जुड़े होते हैं?'
      : 'Are Angel Numbers linked to your Date of Birth?';

  static String dobGeneral(bool hi) => hi ? _dobGeneralHi : _dobGeneralEn;

  static const String _dobGeneralEn =
      'Angel numbers appear for everyone, so your date of birth does not create them. '
      'But in numerology, your birth date gives you three personal numbers - the Mulank '
      '(your birth-day number), the Bhagyank (the total of your full date of birth) and '
      'your Personal Year number. When an angel number repeats the same digit as one of '
      'your personal numbers, it is believed to speak to you much more personally.\n\n'
      'Example: if your Mulank is 6 and you keep seeing 666, numerologists read it as a message '
      'about your own home, family and responsibilities - not a general warning. In the same way, '
      'a digit that appears many times in your date of birth is believed to be a "familiar energy" '
      'for you, so its angel number may feel natural and close.\n\n'
      'So the simple answer is: angel numbers are not decided by your birth date, but your birth date '
      'decides which angel numbers matter most for you. The section below shows exactly which ones '
      'are closest to your date of birth, and why.';

  static const String _dobGeneralHi =
      'एंजल नंबर हर किसी को दिखते हैं, इसलिए आपकी जन्मतिथि उन्हें पैदा नहीं करती। लेकिन अंक शास्त्र '
      'में आपकी जन्मतिथि आपको तीन निजी अंक देती है - मूलांक (आपके जन्म दिन का अंक), भाग्यांक '
      '(पूरी जन्मतिथि के अंकों का जोड़) और आपका पर्सनल ईयर नंबर। जब कोई एंजल नंबर आपके इन निजी '
      'अंकों में से किसी का वही अंक दोहराता है, तो माना जाता है कि वह संदेश आपसे कहीं ज़्यादा '
      'व्यक्तिगत रूप से बात करता है।\n\n'
      'उदाहरण: अगर आपका मूलांक 6 है और आपको बार-बार 666 दिखता है, तो अंक शास्त्री इसे आपके अपने '
      'घर, परिवार और ज़िम्मेदारियों का संदेश मानते हैं - कोई आम चेतावनी नहीं। इसी तरह, जो अंक आपकी '
      'जन्मतिथि में कई बार आता है, उसे आपके लिए "जानी-पहचानी ऊर्जा" माना जाता है, इसलिए उसका '
      'एंजल नंबर आपको अपना-सा लग सकता है।\n\n'
      'तो सीधा जवाब यह है: एंजल नंबर आपकी जन्मतिथि से तय नहीं होते, लेकिन आपकी जन्मतिथि तय करती '
      'है कि कौन-से एंजल नंबर आपके लिए सबसे ज़्यादा मायने रखते हैं। नीचे का हिस्सा बताता है कि कौन-से '
      'नंबर आपकी जन्मतिथि के सबसे करीब हैं और क्यों।';

  // ---------- Digit meanings ----------
  static String digitMeaning(int d, bool hi) {
    const en = {
      0: 'infinite potential and the divine source',
      1: 'new beginnings, leadership and self-belief',
      2: 'balance, partnership and patience',
      3: 'creativity, joy and self-expression',
      4: 'stability, discipline and hard work',
      5: 'change, freedom and adventure',
      6: 'family, love and responsibility',
      7: 'inner wisdom, spirituality and study',
      8: 'money, power and the fruit of karma',
      9: 'completion, kindness and service',
    };
    const hin = {
      0: 'अनंत संभावना और दिव्य स्रोत',
      1: 'नई शुरुआत, नेतृत्व और आत्मविश्वास',
      2: 'संतुलन, साझेदारी और धैर्य',
      3: 'रचनात्मकता, खुशी और अभिव्यक्ति',
      4: 'स्थिरता, अनुशासन और मेहनत',
      5: 'बदलाव, आज़ादी और रोमांच',
      6: 'परिवार, प्रेम और ज़िम्मेदारी',
      7: 'अंदरूनी समझ, अध्यात्म और अध्ययन',
      8: 'धन, शक्ति और कर्म का फल',
      9: 'पूर्णता, करुणा और सेवा',
    };
    return (hi ? hin : en)[d] ?? '';
  }

  // ---------- Birth numbers ----------
  static int _digitSum(int n) {
    var s = 0;
    for (final c in n.toString().split('')) {
      s += int.parse(c);
    }
    return s;
  }

  static int reduce(int n) {
    var x = n;
    while (x > 9) {
      x = _digitSum(x);
    }
    return x;
  }

  /// Mulank = janm tarikh (din) ka single ank.
  static int mulank(DateTime dob) => reduce(dob.day);

  /// Bhagyank = poori DOB ke sabhi ankon ka jod.
  static int bhagyank(DateTime dob) =>
      reduce(_digitSum(dob.day) + _digitSum(dob.month) + _digitSum(dob.year));

  /// Personal Year = DOB ka din + mahina + diya gaya saal.
  static int personalYear(DateTime dob, int year) =>
      reduce(_digitSum(dob.day) + _digitSum(dob.month) + _digitSum(year));

  /// How many times a digit appears in the date of birth (06-04-1988 is read
  /// as 6, 4, 1988: the digit 8 appears twice and 0 does not appear).
  static int digitCountInDob(DateTime dob, int digit) {
    // Written without padding (6, not 06), exactly like the Lo Shu grid, so a
    // zero is counted only when the day, month or year really contains one.
    final s = dob.day.toString() + dob.month.toString() + dob.year.toString();
    return s.split('').where((c) => c == digit.toString()).length;
  }

  // ---------- DOB links ----------
  static List<DobLink> linksForDob(DateTime dob, int year) {
    final m = mulank(dob);
    final b = bhagyank(dob);
    final p = personalYear(dob, year);
    final out = <DobLink>[];
    for (final a in all) {
      var score = 0;
      final en = <String>[];
      final hi = <String>[];
      for (final k in a.keyDigits) {
        if (k != 0 && k == m) {
          score += 2;
          en.add('your Mulank is $k');
          hi.add('आपका मूलांक $k है');
        }
        if (k != 0 && k == b) {
          score += 2;
          en.add('your Bhagyank is $k');
          hi.add('आपका भाग्यांक $k है');
        }
        if (k != 0 && k == p) {
          score += 1;
          en.add('your Personal Year number for $year is $k');
          hi.add('$year के लिए आपका पर्सनल ईयर नंबर $k है');
        }
        final c = digitCountInDob(dob, k);
        if (k != 0 && c >= 2) {
          score += 1;
          en.add('the digit $k appears $c times in your date of birth');
          hi.add('अंक $k आपकी जन्मतिथि में $c बार आया है');
        }
        if (k == 0 && c >= 1) {
          score += 1;
          en.add('your date of birth contains the digit 0 ($c time/s)');
          hi.add('आपकी जन्मतिथि में अंक 0 है ($c बार)');
        }
      }
      final strength = score >= 4 ? 3 : (score >= 2 ? 2 : (score >= 1 ? 1 : 0));
      final reasonEn = en.isEmpty
          ? 'This number does not touch your birth numbers directly, so read it as a general message that comes to everyone.'
          : 'Linked to you because ${en.join(', ')}.';
      final reasonHi = hi.isEmpty
          ? 'यह नंबर आपके जन्म के अंकों से सीधे नहीं जुड़ता, इसलिए इसे सबके लिए आने वाला एक आम संदेश मानकर पढ़ें।'
          : 'यह आपसे इसलिए जुड़ा है क्योंकि ${hi.join(', ')}।';
      out.add(DobLink(a, strength, reasonEn, reasonHi));
    }
    out.sort((x, y) => y.strength.compareTo(x.strength));
    return out;
  }

  /// Lamba, saaf paragraph: PDF aur app dono me chal sakta hai.
  static String dobParagraph(DateTime dob, int year, bool hi) {
    final m = mulank(dob);
    final b = bhagyank(dob);
    final p = personalYear(dob, year);
    final links = linksForDob(dob, year);
    final top = links.where((l) => l.strength > 0).take(3).toList();
    final buf = StringBuffer();
    if (hi) {
      buf.write('आपकी जन्मतिथि के हिसाब से आपके तीन निजी अंक ये हैं: मूलांक $m (${digitMeaning(m, true)}), '
          'भाग्यांक $b (${digitMeaning(b, true)}) और $year का पर्सनल ईयर नंबर $p (${digitMeaning(p, true)}). ');
      buf.write('इन्हीं अंकों से तय होता है कि कौन-सा एंजल नंबर आपसे सबसे ज़्यादा व्यक्तिगत बात करता है।\n\n');
      if (top.isEmpty) {
        buf.write('इस बार कोई एंजल नंबर आपके अंकों से सीधा नहीं जुड़ा, लेकिन इसका मतलब यह नहीं कि संदेश कम '
            'ज़रूरी हैं। जो भी नंबर आपको बार-बार दिखे, उसका सामान्य अर्थ पढ़ें और अपने मन की सुनें।');
      } else {
        for (final l in top) {
          buf.write('${l.angel.number} - ${l.angel.titleHi} (${l.label(true)}): ${l.reasonHi} '
              '${l.angel.messageHi}\n\n');
        }
      }
      buf.write('याद रखें, यह अंक शास्त्र की मान्यता पर आधारित मार्गदर्शन है। इसे प्रेरणा की तरह लें, '
          'कोई पक्की भविष्यवाणी या डर की तरह नहीं।');
    } else {
      buf.write('From your date of birth, your three personal numbers are: Mulank $m (${digitMeaning(m, false)}), '
          'Bhagyank $b (${digitMeaning(b, false)}) and your Personal Year number for $year, which is $p (${digitMeaning(p, false)}). ');
      buf.write('These decide which angel number speaks to you most personally.\n\n');
      if (top.isEmpty) {
        buf.write('This time no angel number touches your birth numbers directly, but that does not make '
            'the messages less useful. Whenever a number keeps appearing, read its general meaning and listen to your own heart.');
      } else {
        for (final l in top) {
          buf.write('${l.angel.number} - ${l.angel.titleEn} (${l.label(false)}): ${l.reasonEn} '
              '${l.angel.messageEn}\n\n');
        }
      }
      buf.write('Remember, this is guidance based on numerology belief. Take it as encouragement, '
          'not as a fixed prediction or a reason to worry.');
    }
    return buf.toString();
  }

  // ---------- The numbers ----------
  static const List<AngelNumber> all = [
    AngelNumber(
      number: '000',
      keyDigits: [0],
      titleEn: 'The Infinite Circle',
      titleHi: 'अनंत का चक्र',
      meaningEn:
          'Zero has no beginning and no end, so 000 is seen as the number of unlimited potential. '
          'It appears when one chapter is ending and a blank page is ready for you to write on.',
      meaningHi:
          'शून्य का न आदि है न अंत, इसलिए 000 को असीम संभावनाओं का अंक माना जाता है। '
          'यह तब दिखता है जब जीवन का एक अध्याय खत्म हो रहा हो और आपके लिखने के लिए एक खाली पन्ना तैयार हो।',
      messageEn:
          'You are being asked to let go of old worries and trust that you are supported. '
          'A fresh start is possible, and you do not have to carry everything from the past.',
      messageHi:
          'आपसे कहा जा रहा है कि पुरानी चिंताओं को छोड़ दें और भरोसा रखें कि आपको सहारा मिल रहा है। '
          'नई शुरुआत संभव है, और पिछला सब कुछ ढोना ज़रूरी नहीं।',
      loveEn:
          'In love, it asks you to forgive, reset and begin again with an open heart. '
          'If you are single, it says to stop rushing and let the right person arrive naturally.',
      loveHi:
          'प्रेम में यह माफ़ करने, सब कुछ नए सिरे से शुरू करने और खुले दिल से आगे बढ़ने को कहता है। '
          'अगर आप अकेले हैं, तो जल्दबाज़ी छोड़ें और सही इंसान को अपने आप आने दें।',
      careerEn:
          'In work, it points to a good time for a fresh plan, a new skill or a small experiment. '
          'Do not fear starting from zero - every big thing began there.',
      careerHi:
          'काम में यह नई योजना, नया हुनर या छोटा प्रयोग शुरू करने का अच्छा समय बताता है। '
          'शून्य से शुरू करने से मत डरिए - हर बड़ी चीज़ वहीं से शुरू हुई है।',
      actionEn:
          'Do this: sit quietly for five minutes, write down one thing you are ready to release and one thing you want to begin.',
      actionHi:
          'यह करें: पाँच मिनट शांत बैठें, एक चीज़ लिखें जिसे आप छोड़ना चाहते हैं और एक चीज़ जिसे शुरू करना चाहते हैं।',
    ),
    AngelNumber(
      number: '111',
      keyDigits: [1],
      titleEn: 'Thoughts Becoming Reality',
      titleHi: 'सोच का हकीकत बनना',
      meaningEn:
          'Triple one is the number of new beginnings and focused thinking. It is believed to appear '
          'when your thoughts are very powerful, so it asks you to watch what you are thinking about.',
      meaningHi:
          'तीन बार आया एक नई शुरुआत और केंद्रित सोच का अंक है। माना जाता है कि यह तब दिखता है जब आपके '
          'विचार बहुत शक्तिशाली होते हैं, इसलिए यह आपसे कहता है कि अपनी सोच पर ध्यान दें।',
      messageEn:
          'Think about what you want, not about what you fear. Take the first small step, because '
          'a new door is opening and your courage is the key.',
      messageHi:
          'वह सोचिए जो आप चाहते हैं, वह नहीं जिससे आप डरते हैं। पहला छोटा कदम उठाइए, क्योंकि '
          'एक नया दरवाज़ा खुल रहा है और आपका हौसला उसकी चाबी है।',
      loveEn:
          'In relationships, it asks you to be clear about what you want and to speak honestly. '
          'A new connection or a new understanding in an old one may begin.',
      loveHi:
          'रिश्तों में यह आपसे कहता है कि साफ़ रहिए कि आप क्या चाहते हैं, और ईमानदारी से बोलिए। '
          'कोई नया रिश्ता या पुराने रिश्ते में नई समझ शुरू हो सकती है।',
      careerEn:
          'At work, it supports leadership, starting your own project and taking the first step on an idea. '
          'Make a clear goal and begin before you feel fully ready.',
      careerHi:
          'काम में यह नेतृत्व, अपना प्रोजेक्ट शुरू करने और किसी विचार पर पहला कदम उठाने का साथ देता है। '
          'एक साफ़ लक्ष्य बनाइए और पूरी तरह तैयार महसूस होने से पहले ही शुरू कर दीजिए।',
      actionEn:
          'Do this: write one clear goal in a single sentence and do one small action for it today.',
      actionHi:
          'यह करें: अपना एक साफ़ लक्ष्य एक वाक्य में लिखें और आज उसके लिए एक छोटा काम ज़रूर करें।',
    ),
    AngelNumber(
      number: '222',
      keyDigits: [2],
      titleEn: 'Balance and Trust',
      titleHi: 'संतुलन और भरोसा',
      meaningEn:
          '222 carries the energy of harmony, patience and partnership. It often appears when something '
          'you planted is still growing and you are tempted to give up too early.',
      meaningHi:
          '222 सामंजस्य, धैर्य और साझेदारी की ऊर्जा लेकर आता है। यह अक्सर तब दिखता है जब आपने जो बोया '
          'है वह अभी उग रहा हो और आप जल्दी हार मानने का सोचने लगें।',
      messageEn:
          'Have patience and keep faith - things are working out in the background. '
          'Balance your effort with rest, and your give with your take.',
      messageHi:
          'धैर्य रखिए और विश्वास बनाए रखिए - पर्दे के पीछे सब कुछ ठीक हो रहा है। '
          'अपनी मेहनत और आराम में, और देने और लेने में संतुलन रखिए।',
      loveEn:
          'In love, it is a sign of cooperation, understanding and a stable bond. '
          'A quarrel may settle if both sides listen with patience.',
      loveHi:
          'प्रेम में यह सहयोग, समझदारी और स्थिर रिश्ते का संकेत है। '
          'अगर दोनों पक्ष धैर्य से सुनें तो कोई झगड़ा शांत हो सकता है।',
      careerEn:
          'At work, it favours teamwork, partnerships and steady progress rather than sudden jumps. '
          'Share the load and trust the people you work with.',
      careerHi:
          'काम में यह अचानक छलांग के बजाय टीमवर्क, साझेदारी और धीमी पर पक्की तरक्की का साथ देता है। '
          'बोझ बाँटिए और अपने साथ काम करने वालों पर भरोसा रखिए।',
      actionEn:
          'Do this: do not force a result today. Do your part calmly and wait one more week before judging.',
      actionHi:
          'यह करें: आज किसी नतीजे को ज़बरदस्ती मत लाइए। अपना काम शांति से कीजिए और फ़ैसला करने से पहले एक हफ़्ता और रुकिए।',
    ),
    AngelNumber(
      number: '333',
      keyDigits: [3],
      titleEn: 'Creativity and Guidance',
      titleHi: 'रचनात्मकता और मार्गदर्शन',
      meaningEn:
          '333 is the number of creativity, joy and expression. It is believed to show that your guides '
          'and well-wishers are close and that your talent wants to come out.',
      meaningHi:
          '333 रचनात्मकता, खुशी और अभिव्यक्ति का अंक है। माना जाता है कि यह दिखाता है कि आपके '
          'मार्गदर्शक और शुभचिंतक पास हैं और आपकी प्रतिभा बाहर आना चाहती है।',
      messageEn:
          'Speak, write, create and share. You do not need to wait for perfection - '
          'your voice has value, and joy itself is a sign you are on the right path.',
      messageHi:
          'बोलिए, लिखिए, रचिए और बाँटिए। पूर्णता का इंतज़ार मत कीजिए - आपकी आवाज़ की कीमत है, '
          'और खुशी महसूस होना ही इस बात का संकेत है कि आप सही रास्ते पर हैं।',
      loveEn:
          'In love, it brings lightness, laughter and open communication. '
          'Say the kind things you usually keep inside.',
      loveHi:
          'प्रेम में यह हल्कापन, हँसी और खुलकर बातचीत लाता है। '
          'वे अच्छी बातें कह दीजिए जो आप आमतौर पर मन में रख लेते हैं।',
      careerEn:
          'At work, it supports art, teaching, speaking, marketing and any job where you share ideas. '
          'A creative solution will work better than a heavy one.',
      careerHi:
          'काम में यह कला, पढ़ाने, बोलने, मार्केटिंग और ऐसे हर काम का साथ देता है जिसमें आप विचार बाँटते हैं। '
          'कोई रचनात्मक हल भारी-भरकम हल से बेहतर चलेगा।',
      actionEn:
          'Do this: spend thirty minutes on something creative that has no purpose except enjoyment.',
      actionHi:
          'यह करें: तीस मिनट कोई ऐसा रचनात्मक काम कीजिए जिसका मकसद सिर्फ़ आनंद हो।',
    ),
    AngelNumber(
      number: '444',
      keyDigits: [4],
      titleEn: 'Protection and a Strong Base',
      titleHi: 'सुरक्षा और मज़बूत नींव',
      meaningEn:
          '444 is the number of foundation, discipline and protection. People believe it shows that '
          'you are supported while you build something lasting, brick by brick.',
      meaningHi:
          '444 नींव, अनुशासन और सुरक्षा का अंक है। लोग मानते हैं कि यह दिखाता है कि जब आप कुछ '
          'टिकाऊ बना रहे होते हैं, ईंट-दर-ईंट, तब आपको सहारा मिल रहा होता है।',
      messageEn:
          'Keep going with steady effort. You are safer than you feel, and your hard work is '
          'building something that will stand for a long time.',
      messageHi:
          'लगातार मेहनत करते रहिए। आप जितना महसूस करते हैं उससे ज़्यादा सुरक्षित हैं, और आपकी मेहनत '
          'कुछ ऐसा बना रही है जो लंबे समय तक टिकेगा।',
      loveEn:
          'In love, it stands for loyalty, trust and a stable home. '
          'Build the relationship through small, regular acts of care.',
      loveHi:
          'प्रेम में यह वफ़ादारी, भरोसे और स्थिर घर का प्रतीक है। '
          'छोटी-छोटी नियमित परवाह से रिश्ता मज़बूत कीजिए।',
      careerEn:
          'At work, it favours planning, savings, systems and discipline. '
          'It is a good time to organise accounts, documents and daily routine.',
      careerHi:
          'काम में यह योजना, बचत, व्यवस्था और अनुशासन का साथ देता है। '
          'हिसाब-किताब, दस्तावेज़ और रोज़ की दिनचर्या ठीक करने का यह अच्छा समय है।',
      actionEn:
          'Do this: fix one thing in your routine or paperwork that you have been postponing.',
      actionHi:
          'यह करें: अपनी दिनचर्या या कागज़ात की कोई एक चीज़ ठीक कीजिए जिसे आप टालते आ रहे हैं।',
    ),
    AngelNumber(
      number: '555',
      keyDigits: [5],
      titleEn: 'Big Change Ahead',
      titleHi: 'बड़ा बदलाव',
      meaningEn:
          '555 is the number of change, freedom and movement. It is seen when life is about to shift - '
          'a new place, a new job, a new habit or a new way of thinking.',
      meaningHi:
          '555 बदलाव, आज़ादी और गति का अंक है। यह तब दिखता है जब जीवन में कुछ बदलने वाला हो - '
          'नई जगह, नया काम, नई आदत या सोचने का नया तरीका।',
      messageEn:
          'Do not hold on too tightly to what is ending. Change is not an enemy here; '
          'it is clearing space for something better suited to who you are becoming.',
      messageHi:
          'जो खत्म हो रहा है उसे बहुत कसकर मत पकड़िए। यहाँ बदलाव दुश्मन नहीं है; '
          'वह उस चीज़ के लिए जगह बना रहा है जो आपके बनते हुए रूप के लिए ज़्यादा ठीक है।',
      loveEn:
          'In love, it can mean a new phase in a relationship or a fresh meeting. '
          'Stay flexible and honest, and avoid sudden decisions made only in anger.',
      loveHi:
          'प्रेम में इसका मतलब रिश्ते का नया दौर या कोई नई मुलाकात हो सकता है। '
          'लचीले और ईमानदार रहिए, और सिर्फ़ गुस्से में अचानक फ़ैसले मत लीजिए।',
      careerEn:
          'At work, it points to a transfer, a job switch, travel or a new method. '
          'Learn a new skill so that change finds you ready.',
      careerHi:
          'काम में यह तबादले, नौकरी बदलने, यात्रा या नए तरीके की ओर इशारा करता है। '
          'कोई नया हुनर सीखिए ताकि बदलाव आपको तैयार पाए।',
      actionEn:
          'Do this: make a small change on purpose - a new route, a new habit - to train yourself to welcome change.',
      actionHi:
          'यह करें: जानबूझकर एक छोटा बदलाव कीजिए - नया रास्ता, नई आदत - ताकि आप बदलाव का स्वागत करना सीखें।',
    ),
    AngelNumber(
      number: '666',
      keyDigits: [6],
      titleEn: 'Home, Care and Balance',
      titleHi: 'घर, परवाह और संतुलन',
      meaningEn:
          'Many people fear 666, but in numerology it is simply the energy of six tripled: '
          'family, love, duty and care. It usually appears when you are giving too much attention to material '
          'worries and need to bring your mind back to balance.',
      meaningHi:
          'बहुत लोग 666 से डरते हैं, पर अंक शास्त्र में यह सिर्फ़ छह की तिगुनी ऊर्जा है: '
          'परिवार, प्रेम, कर्तव्य और परवाह। यह अक्सर तब दिखता है जब आप भौतिक चिंताओं पर ज़्यादा ध्यान दे रहे हों '
          'और मन को वापस संतुलन में लाने की ज़रूरत हो।',
      messageEn:
          'Shift your thoughts from worry to care. Look after your home, your health and the people '
          'close to you, and remember to look after yourself as well.',
      messageHi:
          'अपनी सोच को चिंता से परवाह की ओर ले जाइए। अपने घर, अपनी सेहत और अपने करीबी लोगों का ध्यान रखिए, '
          'और खुद का ध्यान रखना भी मत भूलिए।',
      loveEn:
          'In love, it asks for tenderness and responsibility. '
          'Give time to family, but do not lose yourself in pleasing everyone.',
      loveHi:
          'प्रेम में यह कोमलता और ज़िम्मेदारी माँगता है। '
          'परिवार को समय दीजिए, पर सबको खुश करने में खुद को मत खो दीजिए।',
      careerEn:
          'At work, it suggests balancing money matters with peace of mind. '
          'Do not take on every burden - share and delegate where you can.',
      careerHi:
          'काम में यह पैसे की बातों और मन की शांति के बीच संतुलन रखने का सुझाव देता है। '
          'हर बोझ खुद मत उठाइए - जहाँ हो सके बाँटिए और ज़िम्मेदारी सौंपिए।',
      actionEn:
          'Do this: spend one real, phone-free hour with family or a close friend this week.',
      actionHi:
          'यह करें: इस हफ़्ते परिवार या किसी करीबी दोस्त के साथ एक घंटा बिना फ़ोन के बिताइए।',
    ),
    AngelNumber(
      number: '777',
      keyDigits: [7],
      titleEn: 'Inner Wisdom and Right Path',
      titleHi: 'अंदरूनी समझ और सही राह',
      meaningEn:
          '777 is considered a lucky and spiritual number. It is believed to show that your choices, '
          'learning and inner searching are taking you in the right direction.',
      meaningHi:
          '777 को शुभ और आध्यात्मिक अंक माना जाता है। माना जाता है कि यह दिखाता है कि आपके फ़ैसले, '
          'आपकी सीख और आपकी अंदरूनी तलाश आपको सही दिशा में ले जा रही हैं।',
      messageEn:
          'Trust your intuition and spend time in silence, study or prayer. '
          'Answers come more easily when you are calm than when you are in a hurry.',
      messageHi:
          'अपनी अंतरात्मा पर भरोसा कीजिए और मौन, अध्ययन या प्रार्थना में समय बिताइए। '
          'जल्दबाज़ी के बजाय शांत मन में जवाब ज़्यादा आसानी से मिलते हैं।',
      loveEn:
          'In love, it favours deep, honest and meaningful connection over show. '
          'A calm talk will do more than a dramatic one.',
      loveHi:
          'प्रेम में यह दिखावे के बजाय गहरे, ईमानदार और सार्थक जुड़ाव का साथ देता है। '
          'शांत बातचीत नाटकीय बातचीत से ज़्यादा काम करेगी।',
      careerEn:
          'At work, it supports research, study, analysis and skill-building. '
          'Becoming an expert in one area will bring more reward than doing many things half-way.',
      careerHi:
          'काम में यह शोध, पढ़ाई, विश्लेषण और हुनर बढ़ाने का साथ देता है। '
          'किसी एक क्षेत्र में माहिर बनना बहुत-से काम अधूरे करने से ज़्यादा फल देगा।',
      actionEn:
          'Do this: take ten minutes of silence daily this week and note any idea that comes to you.',
      actionHi:
          'यह करें: इस हफ़्ते रोज़ दस मिनट मौन रखिए और जो भी विचार आए उसे लिख लीजिए।',
    ),
    AngelNumber(
      number: '888',
      keyDigits: [8],
      titleEn: 'Abundance and Reward of Karma',
      titleHi: 'समृद्धि और कर्म का फल',
      meaningEn:
          '888 is the number of money, power and the return of your own actions. The sideways eight is also '
          'the sign of infinity, so it points to a flow that keeps moving - what you give comes back.',
      meaningHi:
          '888 धन, शक्ति और अपने कर्मों के लौटने का अंक है। आठ का लेटा हुआ रूप अनंत का चिह्न भी है, '
          'इसलिए यह बहते रहने वाले प्रवाह की ओर इशारा करता है - जो आप देते हैं, वही लौटकर आता है।',
      messageEn:
          'Good results from your earlier effort may be close. Stay honest in money matters, '
          'because this number rewards fairness and punishes shortcuts.',
      messageHi:
          'आपकी पिछली मेहनत के अच्छे नतीजे पास हो सकते हैं। पैसे के मामलों में ईमानदार रहिए, '
          'क्योंकि यह अंक ईमानदारी को फल देता है और शॉर्टकट को नहीं छोड़ता।',
      loveEn:
          'In love, it asks for fairness and equal give-and-take. '
          'A relationship does best when both people feel valued and secure.',
      loveHi:
          'प्रेम में यह निष्पक्षता और बराबर के लेन-देन की बात करता है। '
          'रिश्ता तब सबसे अच्छा चलता है जब दोनों खुद को मूल्यवान और सुरक्षित महसूस करें।',
      careerEn:
          'At work, it supports business, savings, investment and promotions. '
          'Plan for the long term and keep records clean.',
      careerHi:
          'काम में यह व्यापार, बचत, निवेश और तरक्की का साथ देता है। '
          'लंबे समय की योजना बनाइए और हिसाब साफ़ रखिए।',
      actionEn:
          'Do this: set aside a fixed small amount for savings and also give something to someone in need.',
      actionHi:
          'यह करें: बचत के लिए एक तय छोटी रकम अलग रखिए और किसी ज़रूरतमंद को भी कुछ दीजिए।',
    ),
    AngelNumber(
      number: '999',
      keyDigits: [9],
      titleEn: 'Completion and a New Chapter',
      titleHi: 'पूर्णता और नया अध्याय',
      meaningEn:
          '999 is the number of endings, completion and compassion. Nine is the last single digit, '
          'so this number is seen when a cycle in your life is closing.',
      meaningHi:
          '999 अंत, पूर्णता और करुणा का अंक है। नौ आखिरी इकाई अंक है, इसलिए यह नंबर तब दिखता है जब '
          'आपके जीवन का कोई चक्र पूरा हो रहा हो।',
      messageEn:
          'Finish what is pending, forgive where you can and close what no longer fits you. '
          'The ending is not a loss - it makes room for your next step.',
      messageHi:
          'जो काम अधूरा है उसे पूरा कीजिए, जहाँ हो सके माफ़ कीजिए और जो अब आपके लिए ठीक नहीं उसे बंद कीजिए। '
          'अंत कोई नुकसान नहीं है - वह आपके अगले कदम के लिए जगह बनाता है।',
      loveEn:
          'In love, it can mean healing an old hurt or letting a finished relationship go in peace. '
          'Kindness towards yourself and the other person is the theme.',
      loveHi:
          'प्रेम में इसका मतलब पुराने ज़ख्म का भरना या खत्म हो चुके रिश्ते को शांति से छोड़ना हो सकता है। '
          'अपने और दूसरे इंसान के प्रति दया इसका विषय है।',
      careerEn:
          'At work, it is a good time to complete projects, wrap up old accounts and think about service '
          'or teaching others what you know.',
      careerHi:
          'काम में यह प्रोजेक्ट पूरे करने, पुराने हिसाब निपटाने और जो आप जानते हैं वह दूसरों को सिखाने या '
          'उनकी सेवा के बारे में सोचने का अच्छा समय है।',
      actionEn:
          'Do this: finish one old pending task and write a thank-you note to someone who helped you.',
      actionHi:
          'यह करें: कोई एक पुराना अधूरा काम पूरा कीजिए और जिसने आपकी मदद की उसे धन्यवाद का संदेश लिखिए।',
    ),
    AngelNumber(
      number: '1111',
      keyDigits: [1],
      titleEn: 'The Awakening Gate',
      titleHi: 'जागृति का द्वार',
      meaningEn:
          '1111 is the most famous angel number. It is believed to show a moment of awareness, '
          'when your wishes and thoughts are very close to becoming real.',
      meaningHi:
          '1111 सबसे मशहूर एंजल नंबर है। माना जाता है कि यह जागरूकता का क्षण दिखाता है, '
          'जब आपकी इच्छाएँ और विचार हकीकत बनने के बहुत करीब होते हैं।',
      messageEn:
          'Make a wish with a clear and positive mind, and then act on it. '
          'Be careful with negative thinking right now, because your focus is strong.',
      messageHi:
          'साफ़ और सकारात्मक मन से कोई इच्छा कीजिए, और फिर उस पर काम कीजिए। '
          'इस समय नकारात्मक सोच से बचिए, क्योंकि आपका ध्यान बहुत प्रबल है।',
      loveEn:
          'In love, it can signal meeting someone who feels deeply familiar, or an awakening in an existing bond. '
          'Be open, but also use your judgement.',
      loveHi:
          'प्रेम में यह किसी बहुत जाने-पहचाने लगने वाले इंसान से मिलने, या मौजूदा रिश्ते में जागृति का संकेत हो सकता है। '
          'खुले रहिए, पर अपनी समझ भी इस्तेमाल कीजिए।',
      careerEn:
          'At work, it supports a bold new start and trusting your own idea. '
          'Say the idea aloud to the right person - you may get an unexpected opening.',
      careerHi:
          'काम में यह साहसिक नई शुरुआत और अपने विचार पर भरोसा करने का साथ देता है। '
          'अपना विचार सही व्यक्ति को बोलकर बताइए - अचानक कोई मौका मिल सकता है।',
      actionEn:
          'Do this: when you see 1111, pause, take three deep breaths and silently state what you wish for.',
      actionHi:
          'यह करें: जब 1111 दिखे, रुकिए, तीन गहरी साँसें लीजिए और मन ही मन अपनी इच्छा कह दीजिए।',
    ),
    AngelNumber(
      number: '1212',
      keyDigits: [1, 2],
      titleEn: 'Faith with Action',
      titleHi: 'विश्वास के साथ कर्म',
      meaningEn:
          '1212 joins the energy of 1 (action, beginning) with 2 (patience, trust). '
          'It is believed to say: you have started well, now keep the faith and keep going.',
      meaningHi:
          '1212 अंक 1 (कर्म, शुरुआत) और अंक 2 (धैर्य, भरोसा) की ऊर्जा को जोड़ता है। '
          'माना जाता है कि यह कहता है: आपने अच्छी शुरुआत की है, अब विश्वास बनाए रखिए और चलते रहिए।',
      messageEn:
          'Do not give up in the middle. Balance your action with patience, and keep your mind positive '
          'even when results seem slow.',
      messageHi:
          'बीच रास्ते में हार मत मानिए। अपने कर्म और धैर्य में संतुलन रखिए, और नतीजे धीमे लगें तब भी '
          'मन को सकारात्मक रखिए।',
      loveEn:
          'In love, it suggests a partnership that needs both effort and patience. '
          'Take one caring step, then give the other person time to respond.',
      loveHi:
          'प्रेम में यह ऐसे रिश्ते का सुझाव देता है जिसे मेहनत और धैर्य दोनों चाहिए। '
          'एक परवाह भरा कदम उठाइए, फिर दूसरे को जवाब देने का समय दीजिए।',
      careerEn:
          'At work, it supports steady teamwork and following through on a plan you have already started. '
          'Consistency will count more than speed.',
      careerHi:
          'काम में यह लगातार टीमवर्क और उस योजना को पूरा करने का साथ देता है जो आप पहले ही शुरू कर चुके हैं। '
          'गति से ज़्यादा निरंतरता मायने रखेगी।',
      actionEn:
          'Do this: pick one project you started and gave up on, and do its next small step today.',
      actionHi:
          'यह करें: कोई एक प्रोजेक्ट चुनिए जो आपने शुरू करके छोड़ दिया था, और आज उसका अगला छोटा कदम उठाइए।',
    ),
    AngelNumber(
      number: '101',
      keyDigits: [1, 0],
      titleEn: 'A Fresh Start with Faith',
      titleHi: 'विश्वास के साथ नई शुरुआत',
      meaningEn:
          '101 places the number 1 on both sides of a zero. The 1 stands for a new beginning and the 0 for the divine source, so the number is read as "begin, and you are held on both sides". It usually shows up when you are standing at the door of something new and feeling unsure.',
      meaningHi:
          '101 में अंक 1 शून्य के दोनों ओर खड़ा है। 1 नई शुरुआत है और 0 दिव्य स्रोत, इसलिए इसका मतलब माना जाता है: "शुरू कीजिए, आप दोनों ओर से सँभाले हुए हैं।" यह अक्सर तब दिखता है जब आप किसी नई चीज़ के दरवाज़े पर खड़े होकर घबरा रहे हों।',
      messageEn:
          'Do not wait until you feel completely ready. The message is that the first step matters more than the perfect plan, and that you will find the next step once you move. Your own thoughts are strong right now, so keep them kind and clear.',
      messageHi:
          'पूरी तरह तैयार महसूस होने का इंतज़ार मत कीजिए। संदेश यह है कि पहला कदम पूरी योजना से ज़्यादा ज़रूरी है, और चलते ही अगला कदम दिखने लगेगा। इस समय आपके विचार असरदार हैं, इसलिए उन्हें दयालु और साफ़ रखिए।',
      loveEn:
          'In love, it asks you to take the first honest step: a message, an apology or a simple "I care". It also suits people who are starting again after a hurt. Begin slowly and let trust grow, rather than expecting everything at once.',
      loveHi:
          'प्रेम में यह पहला सच्चा कदम उठाने को कहता है: एक संदेश, एक माफ़ी या सीधा सा "मुझे परवाह है"। चोट खाकर दोबारा शुरू करने वालों के लिए भी यह अच्छा है। सब कुछ एक साथ चाहने के बजाय धीरे शुरू कीजिए और भरोसा बढ़ने दीजिए।',
      careerEn:
          'At work it points to a new job, a new role, a new product or simply a new way of doing an old task. Take the lead on something small. Your confidence will grow with each step you finish.',
      careerHi:
          'काम में यह नई नौकरी, नई ज़िम्मेदारी, नए उत्पाद या पुराने काम को नए ढंग से करने का इशारा है। किसी छोटी चीज़ में अगुवाई कीजिए। हर पूरा किया कदम आपका आत्मविश्वास बढ़ाएगा।',
      actionEn:
          'Do this: write the one thing you keep postponing on a paper and do the first five minutes of it today.',
      actionHi:
          'यह करें: जो काम आप टालते आ रहे हैं उसे काग़ज़ पर लिखिए और आज उसके पहले पाँच मिनट कर डालिए।',
    ),
    AngelNumber(
      number: '123',
      keyDigits: [1, 2, 3],
      titleEn: 'Simple Steps, One by One',
      titleHi: 'एक-एक सीढ़ी, सरल कदम',
      meaningEn:
          '123 counts up in the most natural way: 1, then 2, then 3. It is read as a reminder that life does not need a huge jump, only the next simple step. It often appears when you are making things too complicated.',
      meaningHi:
          '123 सबसे स्वाभाविक ढंग से गिनता है: 1, फिर 2, फिर 3। इसे याद दिलाने वाला अंक माना जाता है कि ज़िंदगी को बड़ी छलाँग नहीं, बस अगला सरल कदम चाहिए। यह अक्सर तब दिखता है जब आप चीज़ों को ज़रूरत से ज़्यादा उलझा रहे हों।',
      messageEn:
          'Take it easy and keep it simple. Break your worry into three small parts and handle the first part only. Progress that is slow but steady is still progress, and it is the kind that lasts.',
      messageHi:
          'आराम से चलिए और बात को सरल रखिए। अपनी चिंता को तीन छोटे हिस्सों में बाँटिए और सिर्फ़ पहला हिस्सा सँभालिए। धीमी पर लगातार प्रगति भी प्रगति है, और वही टिकती है।',
      loveEn:
          'In love, it says to keep things light and easy. Do not over-think every message. Small, regular acts of care - a call, a shared meal, a kind word - build more than big promises.',
      loveHi:
          'प्रेम में यह बात को हल्का और सहज रखने को कहता है। हर संदेश पर ज़्यादा मत सोचिए। छोटे और नियमित परवाह भरे काम - एक फ़ोन, साथ खाना, मीठा बोल - बड़े वादों से ज़्यादा रिश्ता बनाते हैं।',
      careerEn:
          'At work, it supports learning step by step: a course, a new tool, a basic skill. Make a list of three tasks in order and finish them one after another. Order and rhythm will save you time.',
      careerHi:
          'काम में यह क्रम से सीखने का साथ देता है: कोई कोर्स, नया औज़ार या बुनियादी हुनर। क्रम से तीन काम लिखिए और एक के बाद एक पूरे कीजिए। क्रम और लय आपका समय बचाएगी।',
      actionEn:
          'Do this: write down three small steps for your biggest problem and finish step one before the day ends.',
      actionHi:
          'यह करें: अपनी सबसे बड़ी समस्या के तीन छोटे कदम लिखिए और दिन ख़त्म होने से पहले पहला पूरा कर लीजिए।',
    ),
    AngelNumber(
      number: '321',
      keyDigits: [1, 2, 3],
      titleEn: 'Countdown to Take-off',
      titleHi: 'उड़ान से पहले की उलटी गिनती',
      meaningEn:
          '321 counts down, like the moments before a launch. It is read as a sign that a period of preparation is about to end and that action is near. It often comes when you have thought and planned enough.',
      meaningHi:
          '321 उलटी गिनती है, जैसे किसी प्रक्षेपण से ठीक पहले। इसे संकेत माना जाता है कि तैयारी का दौर ख़त्म होने वाला है और काम का समय पास है। यह अक्सर तब आता है जब आप काफ़ी सोच और योजना बना चुके हों।',
      messageEn:
          'You have prepared enough. Stop collecting more advice and more tools. The message is to trust what you already know and to start, even if the start is small.',
      messageHi:
          'आप काफ़ी तैयारी कर चुके हैं। और सलाह और और साधन जोड़ना बंद कीजिए। संदेश है कि जो आप पहले से जानते हैं उस पर भरोसा कीजिए और शुरू कीजिए, चाहे शुरुआत छोटी ही हो।',
      loveEn:
          'In love, it can mean a conversation you have been preparing for is now due. Say what you feel in simple words. It can also mean the end of a waiting period and the start of clarity.',
      loveHi:
          'प्रेम में इसका मतलब हो सकता है कि जिस बातचीत की आप तैयारी कर रहे थे उसका समय आ गया है। जो महसूस करते हैं सरल शब्दों में कह दीजिए। यह इंतज़ार के दौर के अंत और साफ़ समझ की शुरुआत का भी संकेत हो सकता है।',
      careerEn:
          'At work, it supports launching: sending the application, opening the shop, publishing the work, asking for the raise. Fix a date, count down to it and go.',
      careerHi:
          'काम में यह शुरू कर देने का साथ देता है: आवेदन भेजना, दुकान खोलना, काम प्रकाशित करना, तनख़्वाह बढ़ाने की बात करना। एक तारीख़ तय कीजिए, उलटी गिनती कीजिए और चल पड़िए।',
      actionEn:
          'Do this: pick a launch date within seven days for the thing you have been preparing, and tell one person about it.',
      actionHi:
          'यह करें: जिस चीज़ की आप तैयारी कर रहे हैं उसके लिए सात दिन के भीतर की एक तारीख़ तय कीजिए और किसी एक व्यक्ति को बता दीजिए।',
    ),
    AngelNumber(
      number: '1010',
      keyDigits: [1, 0],
      titleEn: 'Awakening and Growth',
      titleHi: 'जागृति और बढ़त',
      meaningEn:
          '1010 repeats the pair 1 and 0, so the idea of beginning and divine support is doubled. It is read as a number of awakening: you are growing, and the growth is being noticed by a higher guidance.',
      meaningHi:
          '1010 में 1 और 0 की जोड़ी दोहराई गई है, इसलिए शुरुआत और दिव्य सहारे का भाव दुगुना है। इसे जागृति का अंक माना जाता है: आप बढ़ रहे हैं और इस बढ़त पर ऊपर की मार्गदर्शक शक्ति की नज़र है।',
      messageEn:
          'Trust your inner voice. If a new interest or a new thought keeps returning to you, treat it seriously. Keep your attention on what you want, not on what you fear.',
      messageHi:
          'अपनी अंदर की आवाज़ पर भरोसा कीजिए। कोई नई रुचि या नया विचार बार-बार लौट रहा हो तो उसे गंभीरता से लीजिए। ध्यान उस पर रखिए जो आप चाहते हैं, उस पर नहीं जिससे डरते हैं।',
      loveEn:
          'In love, it speaks of growing as a person so that the relationship can grow too. Be honest about who you are becoming, and let the other person grow beside you.',
      loveHi:
          'प्रेम में यह एक इंसान के रूप में बढ़ने की बात करता है ताकि रिश्ता भी बढ़ सके। जो आप बन रहे हैं उसके बारे में सच्चे रहिए और दूसरे को भी अपने साथ बढ़ने दीजिए।',
      careerEn:
          'At work, it suggests learning something new that your heart is already curious about. A small course, a book or a practice can open a larger door than you expect.',
      careerHi:
          'काम में यह कुछ नया सीखने का सुझाव देता है जिसके बारे में आपका मन पहले से उत्सुक है। छोटा कोर्स, किताब या अभ्यास उम्मीद से बड़ा दरवाज़ा खोल सकता है।',
      actionEn:
          'Do this: spend twenty minutes today on the thing you are most curious about, with no phone beside you.',
      actionHi:
          'यह करें: आज बीस मिनट उस चीज़ को दीजिए जिसके बारे में आप सबसे ज़्यादा उत्सुक हैं, फ़ोन को दूर रखकर।',
    ),
    AngelNumber(
      number: '1221',
      keyDigits: [1, 2],
      titleEn: 'Mirror of Balance',
      titleHi: 'संतुलन का दर्पण',
      meaningEn:
          '1221 reads the same forwards and backwards, like a mirror. The 1 on the outside and the 2 inside are seen as "self" holding "partnership". It appears when you need to find balance between your own needs and the needs of others.',
      meaningHi:
          '1221 आगे से भी वही और पीछे से भी वही पढ़ा जाता है, जैसे दर्पण। बाहर का 1 और भीतर का 2 "स्वयं" द्वारा "साझेदारी" को थामे हुए माने जाते हैं। यह तब दिखता है जब आपको अपनी ज़रूरतों और दूसरों की ज़रूरतों में संतुलन चाहिए।',
      messageEn:
          'Look at how you treat others and how you treat yourself, and see if they match. What you give out comes back in some form. Do not sacrifice yourself, and do not be selfish - find the middle.',
      messageHi:
          'देखिए कि आप दूसरों से कैसा व्यवहार करते हैं और ख़ुद से कैसा, और क्या दोनों मेल खाते हैं। आप जो देते हैं वह किसी न किसी रूप में लौटता है। ख़ुद को क़ुर्बान मत कीजिए और स्वार्थी भी मत बनिए - बीच का रास्ता खोजिए।',
      loveEn:
          'In love, it asks for equal give and take. If one person is doing all the work, speak about it gently. A calm talk now can prevent a long silence later.',
      loveHi:
          'प्रेम में यह बराबर लेन-देन माँगता है। अगर सारा काम एक ही व्यक्ति कर रहा है तो नरमी से कह दीजिए। अभी की शांत बातचीत आगे की लंबी चुप्पी रोक सकती है।',
      careerEn:
          'At work, it supports partnership and fair deals. Check that your workload, credit and pay are balanced. Good partners will welcome a clear and respectful discussion.',
      careerHi:
          'काम में यह साझेदारी और न्यायपूर्ण सौदों का साथ देता है। देखिए कि काम का बोझ, श्रेय और भुगतान संतुलित हैं या नहीं। अच्छे साझेदार साफ़ और आदरपूर्ण बातचीत का स्वागत करते हैं।',
      actionEn:
          'Do this: write two lists - what you give and what you receive in one important relationship - and see if they are close.',
      actionHi:
          'यह करें: किसी एक अहम रिश्ते में आप क्या देते हैं और क्या पाते हैं, दो सूचियाँ बनाइए और देखिए कि दोनों के क़रीब हैं या नहीं।',
    ),
    AngelNumber(
      number: '1234',
      keyDigits: [1, 2, 3, 4],
      titleEn: 'The Staircase of Progress',
      titleHi: 'प्रगति की सीढ़ी',
      meaningEn:
          '1234 climbs one stair at a time. It combines new beginning (1), patience (2), expression (3) and solid work (4). It is read as a promise that if you keep to the order, the result will be steady.',
      meaningHi:
          '1234 एक-एक सीढ़ी चढ़ता है। इसमें नई शुरुआत (1), धैर्य (2), अभिव्यक्ति (3) और ठोस मेहनत (4) जुड़ी हैं। इसे वादा माना जाता है कि अगर आप क्रम पर टिके रहे तो नतीजा स्थिर होगा।',
      messageEn:
          'There is no shortcut here, and you do not need one. Keep a routine, keep records and keep improving a little every week. Others may rush and fall, but your steady climb will take you further.',
      messageHi:
          'यहाँ कोई शॉर्टकट नहीं है और आपको उसकी ज़रूरत भी नहीं। एक दिनचर्या रखिए, हिसाब रखिए और हर हफ़्ते थोड़ा सुधरते रहिए। दूसरे भागकर गिर सकते हैं, पर आपकी स्थिर चढ़ाई आपको ज़्यादा दूर ले जाएगी।',
      loveEn:
          'In love, it suggests a relationship built stage by stage - friendship, trust, care and then commitment. Do not skip a stage because of pressure. A slow start can become a very firm bond.',
      loveHi:
          'प्रेम में यह चरण-दर-चरण बने रिश्ते का सुझाव देता है - दोस्ती, भरोसा, परवाह और फिर प्रतिबद्धता। दबाव में कोई चरण मत छोड़िए। धीमी शुरुआत बहुत मज़बूत बंधन बन सकती है।',
      careerEn:
          'At work, it is a good number for planning, studying for an exam, learning a trade and building a business on a clear base. Write your plan in four stages and tick them off.',
      careerHi:
          'काम में यह योजना बनाने, परीक्षा की पढ़ाई, कोई हुनर सीखने और साफ़ नींव पर कारोबार खड़ा करने के लिए अच्छा अंक है। अपनी योजना चार चरणों में लिखिए और एक-एक पर निशान लगाते जाइए।',
      actionEn:
          'Do this: divide your main goal into four stages, write a date next to each and keep the paper where you can see it.',
      actionHi:
          'यह करें: अपने मुख्य लक्ष्य को चार चरणों में बाँटिए, हर एक के आगे तारीख़ लिखिए और काग़ज़ ऐसी जगह रखिए जहाँ रोज़ दिखे।',
    ),
    AngelNumber(
      number: '1313',
      keyDigits: [1, 3],
      titleEn: 'Bright Thoughts, Open Voice',
      titleHi: 'उजले विचार, खुली आवाज़',
      meaningEn:
          '1313 joins the 1 (your own thought and will) with the 3 (expression, creativity and joy). It is read as an invitation to say what you think and to create something from it. It often comes when ideas are stuck inside you.',
      meaningHi:
          '1313 में 1 (आपका अपना विचार और इच्छा) और 3 (अभिव्यक्ति, रचनात्मकता और ख़ुशी) जुड़े हैं। इसे अपनी बात कहने और उससे कुछ रचने का न्योता माना जाता है। यह अक्सर तब आता है जब विचार आपके भीतर अटके हों।',
      messageEn:
          'Stay positive in your words and in your self-talk. Do not hide your ideas out of fear of what people will say. Express yourself through speaking, writing, drawing, singing or cooking - any form that feels like you.',
      messageHi:
          'अपने शब्दों में और ख़ुद से बातचीत में सकारात्मक रहिए। लोग क्या कहेंगे इस डर से अपने विचार मत छिपाइए। बोलकर, लिखकर, चित्र बनाकर, गाकर या खाना पकाकर - जिस रूप में आप ख़ुद जैसे लगें, उसी में ख़ुद को व्यक्त कीजिए।',
      loveEn:
          'In love, it asks you to speak openly and with warmth. Share compliments, jokes and small joys. A happy and light atmosphere can heal many old tensions.',
      loveHi:
          'प्रेम में यह खुलकर और गर्मजोशी से बोलने को कहता है। तारीफ़ें, हँसी-मज़ाक और छोटी ख़ुशियाँ बाँटिए। हँसता-हल्का माहौल कई पुरानी तनातनी ठीक कर सकता है।',
      careerEn:
          'At work, it favours talking, teaching, presenting, writing, designing and selling. Put your idea in front of people. Even a small audience will give you useful feedback.',
      careerHi:
          'काम में यह बोलने, पढ़ाने, प्रस्तुति देने, लिखने, डिज़ाइन करने और बेचने के पक्ष में है। अपना विचार लोगों के सामने रखिए। छोटे श्रोता भी काम की प्रतिक्रिया देंगे।',
      actionEn:
          'Do this: share one idea you have been keeping to yourself with one trusted person or on one small post today.',
      actionHi:
          'यह करें: जो विचार आप अपने तक रखे हुए थे उसे आज किसी एक भरोसेमंद व्यक्ति को या एक छोटी पोस्ट में बता दीजिए।',
    ),
    AngelNumber(
      number: '1717',
      keyDigits: [1, 7],
      titleEn: 'Inner Wisdom Leads',
      titleHi: 'भीतर की समझ आगे चले',
      meaningEn:
          '1717 joins the 1 (leadership, a new path) with the 7 (inner wisdom, study and spiritual depth). It is read as a sign that you are on a thoughtful path and that your quiet understanding should guide you more than noise from outside.',
      meaningHi:
          '1717 में 1 (नेतृत्व, नया रास्ता) और 7 (भीतर की समझ, अध्ययन और आध्यात्मिक गहराई) जुड़े हैं। इसे संकेत माना जाता है कि आप सोच-समझकर चल रहे हैं और बाहर के शोर से ज़्यादा आपकी शांत समझ आपका मार्गदर्शन करे।',
      messageEn:
          'Take time alone to think. Read, pray, walk or meditate, and then decide. Your decisions will be sharper after quiet. Do not follow the crowd only because it is loud.',
      messageHi:
          'अकेले सोचने का समय निकालिए। पढ़िए, प्रार्थना कीजिए, टहलिए या ध्यान कीजिए, फिर फ़ैसला कीजिए। शांति के बाद आपके फ़ैसले ज़्यादा तीखे होंगे। भीड़ के पीछे सिर्फ़ इसलिए मत चलिए कि वह शोर कर रही है।',
      loveEn:
          'In love, it asks for depth rather than show. Spend quiet time together and listen. If you need space to understand your own feelings, say so kindly instead of disappearing.',
      loveHi:
          'प्रेम में यह दिखावे से ज़्यादा गहराई माँगता है। साथ में शांत समय बिताइए और सुनिए। अगर अपनी भावनाएँ समझने के लिए जगह चाहिए तो ग़ायब होने के बजाय प्यार से कह दीजिए।',
      careerEn:
          'At work, it supports research, study, planning, advice-giving and careful analysis. Check the facts before you lead. Your well-prepared view will earn respect.',
      careerHi:
          'काम में यह शोध, पढ़ाई, योजना, सलाह देने और सावधानी से विश्लेषण का साथ देता है। नेतृत्व से पहले तथ्य जाँच लीजिए। आपकी अच्छी तरह तैयार राय को सम्मान मिलेगा।',
      actionEn:
          'Do this: take thirty minutes of silence today - no phone, no music - and write down any thought that comes.',
      actionHi:
          'यह करें: आज तीस मिनट मौन रखिए - न फ़ोन, न संगीत - और जो भी विचार आए उसे लिख लीजिए।',
    ),
    AngelNumber(
      number: '1818',
      keyDigits: [1, 8],
      titleEn: 'Leading Towards Abundance',
      titleHi: 'समृद्धि की ओर अगुवाई',
      meaningEn:
          '1818 joins the 1 (initiative) with the 8 (money, power and the fruit of karma). It is read as a sign that your effort can turn into real results when you lead with honesty. It often appears around money decisions and career choices.',
      meaningHi:
          '1818 में 1 (पहल) और 8 (धन, शक्ति और कर्म का फल) जुड़े हैं। इसे संकेत माना जाता है कि ईमानदारी से अगुवाई करने पर आपकी मेहनत सच्चे नतीजे में बदल सकती है। यह अक्सर पैसे के फ़ैसलों और करियर के चुनावों के आसपास दिखता है।',
      messageEn:
          'Take responsibility for your money and your work. Plan, save and invest with a clear head. The number supports fair earning; it warns against greed and shortcuts.',
      messageHi:
          'अपने पैसे और अपने काम की ज़िम्मेदारी लीजिए। साफ़ दिमाग़ से योजना बनाइए, बचाइए और निवेश कीजिए। यह अंक ईमानदार कमाई का साथ देता है; लालच और शॉर्टकट से सावधान करता है।',
      loveEn:
          'In love, it reminds you that love also needs responsibility: time, effort and fair sharing of money matters. Talk openly about expenses and plans to avoid quarrels.',
      loveHi:
          'प्रेम में यह याद दिलाता है कि प्रेम को ज़िम्मेदारी भी चाहिए: समय, मेहनत और पैसे की बातों का ईमानदार बँटवारा। झगड़ों से बचने के लिए ख़र्च और योजनाओं पर खुलकर बात कीजिए।',
      careerEn:
          'At work, it is a good sign for business, management, promotion and leadership roles. Set a clear target and keep the books honest. Rewards follow steady, ethical effort.',
      careerHi:
          'काम में यह कारोबार, प्रबंधन, तरक्की और नेतृत्व की भूमिकाओं के लिए अच्छा संकेत है। साफ़ लक्ष्य तय कीजिए और हिसाब ईमानदार रखिए। स्थिर और नैतिक मेहनत का फल मिलता है।',
      actionEn:
          'Do this: write your income, spending and one money goal for the next three months on one page.',
      actionHi:
          'यह करें: अपनी आमदनी, ख़र्च और अगले तीन महीने का एक पैसे का लक्ष्य एक पन्ने पर लिख लीजिए।',
    ),
    AngelNumber(
      number: '2020',
      keyDigits: [2, 0],
      titleEn: 'Patient Trust in Timing',
      titleHi: 'सही समय पर धैर्य का भरोसा',
      meaningEn:
          '2020 joins the 2 (patience, partnership) with the 0 (the divine source, a full circle). It is read as a number of quiet trust: things are working behind the scenes even if you cannot see them yet.',
      meaningHi:
          '2020 में 2 (धैर्य, साझेदारी) और 0 (दिव्य स्रोत, पूरा चक्र) जुड़े हैं। इसे शांत भरोसे का अंक माना जाता है: चीज़ें पर्दे के पीछे काम कर रही हैं भले आपको अभी दिख न रही हों।',
      messageEn:
          'Wait without worry. Do your part and then let time do its part. Keep your heart gentle, avoid forcing results and avoid comparing your speed with others.',
      messageHi:
          'बिना चिंता के इंतज़ार कीजिए। अपना हिस्सा कीजिए और बाक़ी समय पर छोड़ दीजिए। दिल को नरम रखिए, नतीजे ज़बरदस्ती मत खींचिए और अपनी रफ़्तार की दूसरों से तुलना मत कीजिए।',
      loveEn:
          'In love, it supports patience, forgiveness and quiet support. If a relationship is going through a slow phase, stay kind and consistent. If you are waiting for someone, use the time to become peaceful and whole.',
      loveHi:
          'प्रेम में यह धैर्य, क्षमा और शांत सहारे का साथ देता है। अगर रिश्ता धीमे दौर में है तो नरम और लगातार बने रहिए। अगर आप किसी का इंतज़ार कर रहे हैं तो इस समय का इस्तेमाल शांत और पूरे होने में कीजिए।',
      careerEn:
          'At work, it suggests cooperation, listening and not rushing a decision. A partner or a mentor may help. Sign nothing in a hurry; give each offer one more night of thought.',
      careerHi:
          'काम में यह सहयोग, सुनने और फ़ैसले में जल्दबाज़ी न करने का सुझाव देता है। कोई साझेदार या मार्गदर्शक मदद कर सकता है। जल्दी में कुछ मत हस्ताक्षर कीजिए; हर प्रस्ताव को एक रात और सोच लीजिए।',
      actionEn:
          'Do this: choose one worry you cannot fix today, write "I will look at this again in seven days" and let it rest.',
      actionHi:
          'यह करें: कोई एक चिंता चुनिए जो आज सुलझ नहीं सकती, लिखिए "मैं इसे सात दिन बाद फिर देखूँगा/देखूँगी" और उसे आराम करने दीजिए।',
    ),
  ];

  // ---------- Longer explanations made from the digits ----------
  /// "Digit by digit": what each digit in the number stands for.
  static String digitByDigit(AngelNumber a, bool hi) {
    final seen = <int>[];
    for (final c in a.number.split('')) {
      final d = int.parse(c);
      if (!seen.contains(d)) seen.add(d);
    }
    final parts = <String>[];
    for (final d in seen) {
      final n = a.number.split('').where((c) => c == '$d').length;
      final times = n > 1 ? (hi ? ' ($n बार)' : ' ($n times)') : '';
      parts.add(hi
          ? '$d$times: ${digitMeaning(d, true)}'
          : '$d$times: ${digitMeaning(d, false)}');
    }
    final head = hi
        ? 'इस नंबर के हर अंक का अपना अर्थ है। '
        : 'Every digit in this number carries its own meaning. ';
    final tail = seen.length < a.number.length
        ? (hi
            ? ' जो अंक दोहराया गया है उसका असर बढ़ा हुआ माना जाता है।'
            : ' A digit that repeats is believed to speak louder.')
        : '';
    return head + parts.join(hi ? '; ' : '; ') + '.' + tail;
  }

  /// "How to read it": a simple way to notice the number in daily life.
  static String howToRead(AngelNumber a, bool hi) {
    return hi
        ? 'जब ${a.number} दिखे तो ध्यान दीजिए कि उस समय आप कहाँ थे, क्या सोच रहे थे और किसके साथ थे। '
            'नंबर उस पल का आईना है। समय और विचार एक डायरी में लिख लीजिए; कुछ हफ़्तों में आपको अपना एक पैटर्न दिखने लगेगा। '
            'एक बार दिख जाना संयोग भी हो सकता है, लेकिन जब वही नंबर बार-बार उन्हीं विचारों के साथ आए तब उसे गंभीरता से पढ़िए।'
        : 'When ${a.number} appears, notice where you were, what you were thinking and who you were with. '
            'The number is a mirror for that moment. Write the time and the thought in a diary; after a few weeks you will see your own pattern. '
            'Seeing it once may be chance, but when the same number keeps coming with the same thoughts, read it seriously.';
  }

  /// An honest word, so nobody takes it as a promise.
  static String fairWord(bool hi) => hi
      ? 'एंजल नंबर एक मान्यता और ख़ुद को समझने का साधन हैं। ये किसी घटना की पक्की भविष्यवाणी या वैज्ञानिक प्रमाण नहीं हैं। इन्हें प्रेरणा की तरह लीजिए, और बड़े फ़ैसले अपनी समझ, तथ्यों और ज़रूरत हो तो जानकार लोगों की सलाह से कीजिए।'
      : 'Angel numbers are a belief and a tool for understanding yourself. They are not a sure prediction of any event and not scientific proof. Take them as inspiration, and make big decisions with your own judgement, the facts and, where needed, expert advice.';

  static AngelNumber? find(String number) {
    for (final a in all) {
      if (a.number == number) return a;
    }
    return null;
  }
}
