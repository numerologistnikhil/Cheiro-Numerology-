import 'root_profiles.dart' show L;

/// Bilingual quiz question. [answer] is the index of the correct option.
class QuizQ {
  final L question;
  final List<L> options;
  final int answer;
  final L explanation;
  const QuizQ(this.question, this.options, this.answer, this.explanation);
}

class QuizContent {
  static const L title = L('Quiz', 'क्विज़');
  static const L resultTitle = L('Quiz Result', 'क्विज़ परिणाम');
  static const L correct = L('Correct.', 'सही।');
  static const L wrong = L('Not quite.', 'पूरी तरह नहीं।');
  static const L next = L('Next', 'आगे');
  static const L seeResult = L('See Result', 'परिणाम देखें');
  static const L tryAgain = L('Try Again', 'फिर से कोशिश करें');
  static const L great = L('Excellent. You know your basics well.', 'शानदार। आपकी बुनियाद मज़बूत है।');
  static const L good = L('Good effort. Revisit the lessons and try again.', 'अच्छा प्रयास। पाठ दोबारा पढ़कर फिर कोशिश करें।');
  static const L start = L('A good start. Read the lessons once more and retry.', 'अच्छी शुरुआत। पाठ एक बार और पढ़कर फिर कोशिश करें।');

  static L n(String s) => L(s, s);

  static final List<QuizQ> questions = [
    QuizQ(
      const L('Which number is NOT given to any letter in the Chaldean system?', 'कैल्डियन पद्धति में कौन सा अंक किसी अक्षर को नहीं दिया जाता?'),
      [n('5'), n('8'), n('9'), n('1')], 2,
      const L('9 is treated as sacred and is left out of the letter table.', '9 को पवित्र माना जाता है, इसलिए अक्षर तालिका में नहीं रखा जाता।'),
    ),
    QuizQ(
      const L('What is the root number of 32?', '32 का मूल अंक क्या है?'),
      [n('3'), n('5'), n('2'), n('7')], 1,
      const L('3 + 2 = 5.', '3 + 2 = 5।'),
    ),
    QuizQ(
      const L('What is the root number of 47?', '47 का मूल अंक क्या है?'),
      [n('2'), n('4'), n('7'), n('11')], 0,
      const L('4 + 7 = 11, and 1 + 1 = 2.', '4 + 7 = 11, और 1 + 1 = 2।'),
    ),
    QuizQ(
      const L('The Mulank (psychic number) comes from...', 'मूलांक किससे बनता है?'),
      [
        const L('The full birth date', 'पूरी जन्म तिथि'),
        const L('The month only', 'सिर्फ़ महीना'),
        const L('The day of birth only', 'सिर्फ़ जन्म का दिन'),
        const L('The name', 'नाम'),
      ], 2,
      const L('Mulank uses the day of the month only.', 'मूलांक सिर्फ़ महीने के दिन से बनता है।'),
    ),
    QuizQ(
      const L('What is the Mulank of someone born on the 29th?', '29 तारीख को जन्मे व्यक्ति का मूलांक क्या है?'),
      [n('2'), n('9'), n('11'), n('1')], 0,
      const L('2 + 9 = 11, and 1 + 1 = 2.', '2 + 9 = 11, और 1 + 1 = 2।'),
    ),
    QuizQ(
      const L('What is the Bhagyank (destiny number) of someone born on 6 April 1988?', '6 अप्रैल 1988 को जन्मे व्यक्ति का भाग्यांक क्या है?'),
      [n('6'), n('9'), n('8'), n('5')], 1,
      const L('6+4+1+9+8+8 = 36, and 3 + 6 = 9.', '6+4+1+9+8+8 = 36, और 3 + 6 = 9।'),
    ),
    QuizQ(
      const L('Which planet is linked with number 1?', 'अंक 1 किस ग्रह से जुड़ा है?'),
      [const L('Moon', 'चंद्र'), const L('Sun', 'सूर्य'), const L('Mars', 'मंगल'), const L('Venus', 'शुक्र')], 1,
      const L('The Sun rules number 1.', 'अंक 1 का स्वामी सूर्य है।'),
    ),
    QuizQ(
      const L('Which planet is linked with number 6?', 'अंक 6 किस ग्रह से जुड़ा है?'),
      [const L('Saturn', 'शनि'), const L('Jupiter', 'गुरु'), const L('Venus', 'शुक्र'), const L('Mercury', 'बुध')], 2,
      const L('Venus rules number 6.', 'अंक 6 का स्वामी शुक्र है।'),
    ),
    QuizQ(
      const L('Which planet is linked with number 8?', 'अंक 8 किस ग्रह से जुड़ा है?'),
      [const L('Saturn', 'शनि'), const L('Mars', 'मंगल'), const L('Sun', 'सूर्य'), const L('Moon', 'चंद्र')], 0,
      const L('Saturn rules number 8: discipline and results through patience.', 'अंक 8 का स्वामी शनि है: अनुशासन और धैर्य से मिलने वाले नतीजे।'),
    ),
    QuizQ(
      const L('Which planet is linked with number 9?', 'अंक 9 किस ग्रह से जुड़ा है?'),
      [const L('Mars', 'मंगल'), const L('Mercury', 'बुध'), const L('Jupiter', 'गुरु'), const L('Moon', 'चंद्र')], 0,
      const L('Mars rules number 9: courage and energy.', 'अंक 9 का स्वामी मंगल है: साहस और ऊर्जा।'),
    ),
    QuizQ(
      const L('Which letter has the Chaldean value 8?', 'किस अक्षर का कैल्डियन मान 8 है?'),
      [n('F'), n('M'), n('S'), n('E')], 0,
      const L('F and P carry the value 8.', 'F और P का मान 8 है।'),
    ),
    QuizQ(
      const L('What is the Chaldean value of M?', 'M का कैल्डियन मान क्या है?'),
      [n('3'), n('4'), n('5'), n('6')], 1,
      const L('D, M and T carry the value 4.', 'D, M और T का मान 4 है।'),
    ),
    QuizQ(
      const L('What is the compound number of the name ANNU (A=1, N=5, N=5, U=6)?', 'नाम ANNU का संयुक्त अंक क्या है (A=1, N=5, N=5, U=6)?'),
      [n('15'), n('16'), n('17'), n('18')], 2,
      const L('1 + 5 + 5 + 6 = 17, and 1 + 7 = 8.', '1 + 5 + 5 + 6 = 17, और 1 + 7 = 8।'),
    ),
    QuizQ(
      const L('What compound range does this app use?', 'यह ऐप संयुक्त अंकों की कौन सी सीमा इस्तेमाल करता है?'),
      [n('1 to 99'), n('10 to 54'), n('10 to 52'), n('1 to 9')], 2,
      const L('Cheiro\'s original series of compound numbers runs from 10 to 52.', 'कीरो की मूल श्रृंखला में संयुक्त अंक 10 से 52 तक हैं।'),
    ),
    QuizQ(
      const L('Which of these pairs is treated as friendly in this app?', 'इस ऐप में इनमें से कौन सी जोड़ी मित्र मानी जाती है?'),
      [n('1 and 3'), n('1 and 8'), n('4 and 9'), n('2 and 4')], 0,
      const L('1 and 3 are friends. 1 and 8, 4 and 9, and 2 and 4 are treated as opposed.', '1 और 3 मित्र हैं। 1 और 8, 4 और 9, तथा 2 और 4 विरोधी माने जाते हैं।'),
    ),
    QuizQ(
      const L('A missing number in the Lo Shu grid is best seen as...', 'लो शू ग्रिड में अनुपस्थित अंक को सबसे अच्छा कैसे देखें?'),
      [
        const L('Bad luck that cannot change', 'बुरी किस्मत जो बदल नहीं सकती'),
        const L('An area to build with habits', 'ऐसा क्षेत्र जिसे आदतों से मज़बूत किया जा सकता है'),
        const L('A medical problem', 'कोई बीमारी'),
        const L('A reason to change your name at once', 'तुरंत नाम बदलने की वजह'),
      ], 1,
      const L('Missing numbers are hints for practice, not bad luck.', 'अनुपस्थित अंक अभ्यास का इशारा हैं, बुरी किस्मत नहीं।'),
    ),
    QuizQ(
      const L('What is the personal year in 2026 for someone born on 6 April?', '6 अप्रैल को जन्मे व्यक्ति का 2026 का व्यक्तिगत वर्ष क्या है?'),
      [n('1'), n('2'), n('6'), n('9')], 1,
      const L('6 + 4 + 2 + 0 + 2 + 6 = 20, and 2 + 0 = 2.', '6 + 4 + 2 + 0 + 2 + 6 = 20, और 2 + 0 = 2।'),
    ),
    QuizQ(
      const L('Which day is linked with number 2 (Moon)?', 'अंक 2 (चंद्र) से कौन सा दिन जुड़ा है?'),
      [const L('Monday', 'सोमवार'), const L('Tuesday', 'मंगलवार'), const L('Thursday', 'गुरुवार'), const L('Saturday', 'शनिवार')], 0,
      const L('Monday is the Moon\'s day.', 'सोमवार चंद्र का दिन है।'),
    ),
    QuizQ(
      const L('Which Mukhi rudraksha does this app suggest for almost everyone?', 'यह ऐप लगभग सभी के लिए कौन सा मुखी रुद्राक्ष बताता है?'),
      [n('1 Mukhi'), n('5 Mukhi'), n('9 Mukhi'), n('14 Mukhi')], 1,
      const L('5 Mukhi is the common, widely worn bead.', '5 मुखी सबसे आम और व्यापक रूप से पहना जाने वाला मनका है।'),
    ),
    QuizQ(
      const L('Which gemstone is traditionally linked with number 1?', 'परंपरा में अंक 1 से कौन सा रत्न जुड़ा है?'),
      [const L('Ruby', 'माणिक'), const L('Pearl', 'मोती'), const L('Emerald', 'पन्ना'), const L('Blue sapphire', 'नीलम')], 0,
      const L('Ruby (Manik) is linked with the Sun.', 'माणिक सूर्य से जुड़ा रत्न है।'),
    ),
    QuizQ(
      const L('Numerology is best used as...', 'अंकशास्त्र का सबसे अच्छा उपयोग किस रूप में है?'),
      [
        const L('A guarantee of results', 'नतीजों की गारंटी'),
        const L('A replacement for professional advice', 'पेशेवर सलाह की जगह'),
        const L('A tool for reflection', 'चिंतन का साधन'),
        const L('A medical diagnosis', 'मेडिकल निदान'),
      ], 2,
      const L('It is an interpretive lens for reflection, not a guarantee.', 'यह चिंतन का एक व्याख्यात्मक नज़रिया है, गारंटी नहीं।'),
    ),
  ];
}
