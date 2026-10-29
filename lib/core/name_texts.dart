import 'report_pages.dart' show PBi;

/// Texts for the name suggestion feature (app screen and PDF report).
class NameTexts {
  static const PBi title = PBi('Better spellings for your name', 'आपके नाम के बेहतर वर्तनी-सुझाव');
  static const PBi intro = PBi(
    'A small change in how a name is spelled changes its number, and so the way the name sits with your birth numbers. The spellings below keep the sound of your name the same. Each one is judged in the same simple way: the Chaldean total of its letters, how fortunate that number is traditionally believed to be, and how well it sits with your Mulank and Bhagyank. Read each suggestion in detail before you choose.',
    'नाम की वर्तनी में छोटा-सा बदलाव उसका अंक बदल देता है, और इसी से यह भी बदलता है कि नाम आपके जन्म के अंकों के साथ कैसा बैठता है। नीचे की वर्तनियों में नाम की आवाज़ वही रहती है। हर एक को एक ही सरल तरीके से परखा गया है: अक्षरों का कलडीन जोड़, उस अंक को परंपरा में कितना शुभ माना जाता है, और वह आपके मूलांक और भाग्यांक के साथ कितना मेल खाता है। चुनने से पहले हर सुझाव को विस्तार से पढ़िए।',
  );
  static const PBi current = PBi('Your current spelling', 'आपकी मौजूदा वर्तनी');
  static const PBi better = PBi('Better than current', 'मौजूदा से बेहतर');
  static const PBi similar = PBi('Similar to current', 'मौजूदा जैसी');
  static const PBi noneBetter = PBi(
    'Your current spelling already scores well. The spellings below are only alternatives, and there is no need to change.',
    'आपकी मौजूदा वर्तनी पहले से अच्छे अंक पाती है। नीचे की वर्तनियाँ सिर्फ़ विकल्प हैं, बदलने की कोई ज़रूरत नहीं है।',
  );
  static const PBi noLatin = PBi(
    'Please enter the name in English letters (A to Z) to get suggestions.',
    'सुझाव पाने के लिए कृपया नाम अंग्रेज़ी अक्षरों (A से Z) में लिखिए।',
  );
  static const PBi needDob = PBi(
    'Add the date of birth too, so the suggestions can also match your Mulank and Bhagyank.',
    'जन्म तिथि भी भरिए, ताकि सुझाव आपके मूलांक और भाग्यांक से भी मेल खा सकें।',
  );
  static const PBi changes = PBi('What changes', 'क्या बदलता है');
  static const PBi totalLabel = PBi('Total and root', 'जोड़ और मूल अंक');
  static const PBi withMulank = PBi('With your Mulank', 'आपके मूलांक के साथ');
  static const PBi withBhagyank = PBi('With your Bhagyank', 'आपके भाग्यांक के साथ');
  static const PBi guide = PBi('Name guide', 'नाम का संकेत');
  static const PBi compound = PBi('Compound number', 'संयुक्त अंक');
  static const PBi strengthsL = PBi('Strengths', 'खूबियाँ');
  static const PBi carefulL = PBi('Be careful', 'सावधानी');
  static const PBi workL = PBi('Work', 'काम');
  static const PBi moneyL = PBi('Money', 'पैसा');
  static const PBi adviceL = PBi('Advice', 'सलाह');
  static const PBi friendly = PBi('friendly', 'अनुकूल');
  static const PBi neutral = PBi('neutral', 'सामान्य');
  static const PBi challenging = PBi('challenging', 'चुनौतीपूर्ण');

  static const PBi chooseTitle = PBi('How to choose', 'कैसे चुनें');
  static const PBi chooseBody = PBi(
    'Pick the spelling you like to see and to say. A name works best when you feel good writing it. Use the same spelling for a few months everywhere you sign: messages, visiting card, social media and your signature, and notice how you feel.',
    'वही वर्तनी चुनिए जिसे देखना और बोलना आपको अच्छा लगे। नाम तभी सबसे अच्छा काम करता है जब उसे लिखकर आपको अच्छा लगे। कुछ महीने हर जगह यही वर्तनी इस्तेमाल कीजिए: संदेश, विज़िटिंग कार्ड, सोशल मीडिया और हस्ताक्षर, और देखिए कि आपको कैसा लगता है।',
  );
  static const PBi cautionTitle = PBi('Before you change anything', 'कुछ भी बदलने से पहले');
  static const PBi cautionBody = PBi(
    'Changing the spelling in legal papers (Aadhaar, PAN, passport, school and bank records) needs proper formal steps and takes time. Do not hurry, and do not pay anyone who promises results from a name change. Numerology is a traditional belief and gives no guarantee.',
    'क़ानूनी काग़ज़ों (आधार, पैन, पासपोर्ट, स्कूल और बैंक के रिकॉर्ड) में वर्तनी बदलने के लिए सही औपचारिक कदम उठाने पड़ते हैं और समय लगता है। जल्दबाज़ी मत कीजिए, और नाम बदलने से नतीजों का वादा करने वाले किसी को पैसे मत दीजिए। अंक शास्त्र एक पारंपरिक मान्यता है, इसकी कोई गारंटी नहीं।',
  );
  static const PBi chosenTitle = PBi('Your chosen spelling', 'आपकी चुनी हुई वर्तनी');

  // App screen
  static const PBi suggestButton = PBi('Suggest better spellings', 'बेहतर वर्तनी सुझाइए');
  static const PBi chooseButton = PBi('Choose this name', 'यह नाम चुनिए');
  static const PBi chosenButton = PBi('Chosen', 'चुना हुआ');
  static const PBi clearChoice = PBi('Remove my choice', 'मेरी पसंद हटाइए');
  static const PBi compareTitle = PBi('Compare two spellings yourself', 'दो वर्तनियों की खुद तुलना कीजिए');
  static const PBi altLabel = PBi('Alternative spelling', 'दूसरी वर्तनी');
  static const PBi compareButton = PBi('Compare', 'तुलना कीजिए');
  static const PBi nameLabel = PBi('Full name (English letters)', 'पूरा नाम (अंग्रेज़ी अक्षरों में)');
  static const PBi method = PBi(
    'Method: Chaldean letter values and the traditional compound numbers 10 to 52. Numerology is a traditional belief system, not a scientific way to predict outcomes.',
    'तरीका: कलडीन अक्षर-मान और परंपरागत संयुक्त अंक 10 से 52। अंक शास्त्र एक पारंपरिक मान्यता है, नतीजे बताने का वैज्ञानिक तरीका नहीं।',
  );
}
