// Ank Dhara - fixed pages of the PDF report (English + Hindi)
// Pure Dart. Disclaimer, precautions, how to read, customer page labels.

class PBi {
  final String en;
  final String hi;
  const PBi(this.en, this.hi);
  String t(bool hindi) => hindi ? hi : en;
}

class Sec {
  final PBi title;
  final PBi body;
  const Sec(this.title, this.body);
}

class ReportPages {
  ReportPages._();

  // ---------------- Cover ----------------
  static const PBi coverKicker = PBi('PERSONAL NUMEROLOGY REPORT', 'व्यक्तिगत अंक शास्त्र रिपोर्ट');
  static const PBi preparedFor = PBi('Prepared for', 'यह रिपोर्ट बनी है');
  static const PBi coverTagline = PBi(
    'Know your numbers. Understand your path. Walk it with confidence.',
    'अपने अंकों को जानिए, अपने रास्ते को समझिए और भरोसे के साथ आगे बढ़िए।',
  );

  // ---------------- Customer page ----------------
  static const PBi customerTitle = PBi('Personal Details', 'जातक का विवरण');
  static const PBi coverTitle = PBi('Premium Numerology Report', 'प्रीमियम अंक ज्योतिष रिपोर्ट');
  static const PBi customerIntro = PBi(
    'Please check every detail on this page. The whole report is calculated from these details, so if any spelling or digit is wrong, please ask for the report to be made again with the correct details.',
    'कृपया इस पन्ने की हर जानकारी ध्यान से जाँच लीजिए। पूरी रिपोर्ट इन्हीं जानकारियों से बनी है, इसलिए अगर कोई वर्तनी या अंक गलत हो तो सही जानकारी के साथ रिपोर्ट दोबारा बनवाइए।',
  );
  static const PBi labelName = PBi('Full name', 'पूरा नाम');
  static const PBi labelDob = PBi('Date of birth', 'जन्म तिथि');
  static const PBi labelDay = PBi('Day of birth', 'जन्म का वार');
  static const PBi labelMobile = PBi('Mobile number', 'मोबाइल नंबर');
  static const PBi labelMulank = PBi('Birth number (Mulank)', 'मूलांक');
  static const PBi labelBhagyank = PBi('Destiny number (Bhagyank)', 'भाग्यांक');
  static const PBi labelPlanet = PBi('Ruling planet of Mulank', 'मूलांक का स्वामी ग्रह');
  static const PBi labelNameNo = PBi('Name number', 'नाम का अंक');
  static const PBi labelMobileNo = PBi('Mobile number total', 'मोबाइल नंबर का अंक');
  static const PBi labelLang = PBi('Report language', 'रिपोर्ट की भाषा');
  static const PBi labelYears = PBi('Future years covered', 'आगे के कितने साल');
  static const PBi labelDate = PBi('Report date', 'रिपोर्ट की तारीख');
  static const PBi labelBy = PBi('Prepared by', 'तैयार करने वाला');
  static const PBi preparedByValue = PBi('Ank Dhara Numerology App', 'अंक धारा न्यूमेरोलॉजी ऐप');
  static const PBi notGiven = PBi('Not given', 'दिया नहीं गया');
  static const PBi langEnglish = PBi('English', 'अंग्रेज़ी');
  static const PBi langHindi = PBi('Hindi', 'हिन्दी');
  static const PBi glanceTitle = PBi('Your key numbers at a glance', 'आपके मुख्य अंक एक नज़र में');
  static const PBi includesTitle = PBi('What is inside this report', 'इस रिपोर्ट में क्या-क्या है');

  static const List<String> weekEn = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  static const List<String> weekHi = ['सोमवार', 'मंगलवार', 'बुधवार', 'गुरुवार', 'शुक्रवार', 'शनिवार', 'रविवार'];

  // ---------------- Notice / disclaimer ----------------
  static const PBi noticeTitle = PBi('Important Notice and Disclaimer', 'ज़रूरी सूचना और अस्वीकरण');
  static const PBi noticeIntro = PBi(
    'Please read this page and the next page before you start reading your report. It takes only a few minutes and it helps you use the report in the right way.',
    'अपनी रिपोर्ट पढ़ना शुरू करने से पहले कृपया यह पन्ना और अगला पन्ना पढ़ लीजिए। इसमें बस कुछ मिनट लगते हैं और इससे आप रिपोर्ट का सही इस्तेमाल कर पाएँगे।',
  );

  static const List<Sec> notice = [
    Sec(
      PBi('What this report is', 'यह रिपोर्ट क्या है'),
      PBi(
        'This report is prepared by the Ank Dhara app from the name, date of birth and mobile number given by you. It uses the Chaldean letter values and the traditional Cheiro compound number series (10 to 52). Numerology is a belief-based tradition of interpretation. It is meant to help you think about yourself, understand your tendencies and plan your days with more awareness.',
        'यह रिपोर्ट अंक धारा ऐप ने आपके दिए हुए नाम, जन्म तिथि और मोबाइल नंबर से तैयार की है। इसमें कैल्डियन अक्षर मान और चीरो की परंपरागत संयुक्त अंक श्रृंखला (10 से 52) इस्तेमाल हुई है। अंक शास्त्र मान्यता पर आधारित एक पारंपरिक व्याख्या-पद्धति है। इसका मकसद है कि आप खुद के बारे में सोचें, अपनी प्रवृत्तियाँ समझें और अपने दिनों की योजना ज़्यादा जागरूकता से बनाएँ।',
      ),
    ),
    Sec(
      PBi('What this report is not', 'यह रिपोर्ट क्या नहीं है'),
      PBi(
        'This report is not a scientific proof and not a guarantee of any result. It is not medical, legal, financial or professional advice, and it does not predict illness, accidents, loss or death. Please do not take any big decision such as a job change, an investment, a marriage, a loan or a treatment only because of this report. Use it together with your own good sense and the advice of qualified people.',
        'यह रिपोर्ट कोई वैज्ञानिक प्रमाण नहीं है और किसी नतीजे की गारंटी भी नहीं है। यह चिकित्सा, कानूनी, वित्तीय या किसी पेशेवर सलाह की जगह नहीं लेती, और यह बीमारी, दुर्घटना, नुकसान या मृत्यु की भविष्यवाणी नहीं करती। कृपया नौकरी बदलना, निवेश, विवाह, कर्ज़ या इलाज जैसा कोई बड़ा फ़ैसला सिर्फ़ इस रिपोर्ट के आधार पर न लें। इसे अपनी समझदारी और योग्य लोगों की सलाह के साथ इस्तेमाल कीजिए।',
      ),
    ),
    Sec(
      PBi('Your details must be correct', 'आपकी जानकारी सही होनी चाहिए'),
      PBi(
        'Every number in this report is calculated from the spelling of the name, the date of birth and the mobile number you entered. If even one letter or digit is wrong, the numbers and the messages can change. Please check the details on the personal details page before you rely on the report.',
        'इस रिपोर्ट का हर अंक आपके लिखे नाम की वर्तनी, जन्म तिथि और मोबाइल नंबर से निकाला गया है। अगर एक भी अक्षर या अंक गलत हो तो अंक और संदेश बदल सकते हैं। रिपोर्ट पर भरोसा करने से पहले कृपया जातक विवरण वाले पन्ने की जानकारी जाँच लीजिए।',
      ),
    ),
    Sec(
      PBi('Habits, colours and gemstones', 'आदतें, रंग और रत्न'),
      PBi(
        'The colours, lucky days, simple habits and charity ideas in this report are gentle traditional suggestions. They are not treatments and not magic. A gemstone is mentioned only as a traditional belief, so please do not buy or wear an expensive stone only because of this report. Speak to a trusted and qualified person first, and never stop any medicine or treatment because of a number.',
        'इस रिपोर्ट में दिए गए रंग, शुभ दिन, सरल आदतें और दान के सुझाव परंपरा पर आधारित कोमल सुझाव हैं। ये इलाज नहीं हैं और कोई जादू भी नहीं हैं। रत्न का ज़िक्र सिर्फ़ एक पारंपरिक मान्यता के रूप में है, इसलिए कृपया सिर्फ़ इस रिपोर्ट की वजह से कोई महँगा रत्न न खरीदें या पहनें। पहले किसी भरोसेमंद और योग्य व्यक्ति से बात कीजिए, और किसी अंक की वजह से कोई दवा या इलाज कभी बंद न करें।',
      ),
    ),
    Sec(
      PBi('Your privacy', 'आपकी निजता'),
      PBi(
        'The report is created on your own phone and is not uploaded by the app. It contains your name, date of birth and mobile number, so share it only with people you trust and keep the printed copy in a safe place.',
        'रिपोर्ट आपके अपने फ़ोन पर बनती है और ऐप उसे कहीं अपलोड नहीं करता। इसमें आपका नाम, जन्म तिथि और मोबाइल नंबर है, इसलिए इसे सिर्फ़ भरोसेमंद लोगों से साझा कीजिए और छपी हुई कॉपी सुरक्षित जगह रखिए।',
      ),
    ),
    Sec(
      PBi('Your responsibility', 'आपकी ज़िम्मेदारी'),
      PBi(
        'The choices you make in life are yours. The makers of the app and the person who shares this report with you cannot be held responsible for any decision taken only on the basis of this report.',
        'जीवन में आप जो भी चुनाव करते हैं वे आपके अपने हैं। सिर्फ़ इस रिपोर्ट के आधार पर लिए गए किसी भी फ़ैसले के लिए ऐप बनाने वाले या यह रिपोर्ट आपको देने वाले व्यक्ति ज़िम्मेदार नहीं होंगे।',
      ),
    ),
  ];

  // ---------------- Precautions ----------------
  static const PBi precautionsTitle = PBi('Precautions', 'सावधानियाँ');
  static const PBi precautionsIntro = PBi(
    'These simple precautions will help you get the best out of your report and keep you comfortable while reading it.',
    'ये सरल सावधानियाँ आपको रिपोर्ट से सबसे अच्छा फ़ायदा लेने में और पढ़ते समय सहज रहने में मदद करेंगी।',
  );

  static const List<Sec> precautions = [
    Sec(
      PBi('Read the whole report calmly', 'पूरी रिपोर्ट शांति से पढ़िए'),
      PBi(
        'Every number has strengths and also things to be careful about. If you find a hard sentence, please do not worry. It points to a place where extra care or effort helps. It is not a fixed future.',
        'हर अंक में खूबियाँ भी होती हैं और संभलकर चलने की बातें भी। अगर कोई वाक्य कठिन लगे तो चिंता मत कीजिए। वह बस उस जगह की ओर इशारा करता है जहाँ थोड़ी ज़्यादा सावधानी या मेहनत काम आएगी। यह कोई तय भविष्य नहीं है।',
      ),
    ),
    Sec(
      PBi('Different teachers, different views', 'अलग गुरु, अलग राय'),
      PBi(
        'Chaldean, Pythagorean and Vedic numerology use different methods, so another numerologist may give you a different reading. This is normal. This report follows one method and follows it the same way every time.',
        'कैल्डियन, पाइथागोरियन और वैदिक अंक शास्त्र अलग-अलग तरीके अपनाते हैं, इसलिए कोई दूसरा अंक शास्त्री आपको अलग व्याख्या दे सकता है। यह सामान्य बात है। यह रिपोर्ट एक ही पद्धति पर चलती है और हर बार उसे एक जैसा ही लागू करती है।',
      ),
    ),
    Sec(
      PBi('Do not change things suddenly', 'अचानक बदलाव मत कीजिए'),
      PBi(
        'Please do not change your legal name, signature, mobile number or vehicle number in a hurry. Legal documents have proper procedures. If you wish to try a new spelling, begin with small things such as a signature or a social media name, and observe for a few months.',
        'कृपया अपना कानूनी नाम, हस्ताक्षर, मोबाइल नंबर या गाड़ी का नंबर जल्दबाज़ी में न बदलिए। कानूनी दस्तावेज़ों की अपनी प्रक्रिया होती है। अगर कोई नई वर्तनी आज़मानी हो तो छोटी चीज़ों से शुरू कीजिए, जैसे हस्ताक्षर या सोशल मीडिया का नाम, और कुछ महीने देखिए।',
      ),
    ),
    Sec(
      PBi('Money and health decisions', 'पैसे और सेहत के फ़ैसले'),
      PBi(
        'For money, loans, investments, pregnancy, illness or any health matter, please consult a qualified professional. Numbers can support your thinking but they can never replace expert advice.',
        'पैसे, कर्ज़, निवेश, गर्भावस्था, बीमारी या सेहत की किसी भी बात के लिए कृपया योग्य विशेषज्ञ से सलाह लीजिए। अंक आपकी सोच को सहारा दे सकते हैं, पर विशेषज्ञ की सलाह की जगह कभी नहीं ले सकते।',
      ),
    ),
    Sec(
      PBi('Reports made for children', 'बच्चों के लिए बनी रिपोर्ट'),
      PBi(
        'If this report is made for a child, parents and teachers should read it first and share only the encouraging parts in simple words. A child should never be labelled or compared with others because of a number.',
        'अगर यह रिपोर्ट किसी बच्चे के लिए बनी है तो माता-पिता और शिक्षक पहले इसे पढ़ें और सिर्फ़ हौसला बढ़ाने वाली बातें सरल शब्दों में बच्चे को बताएँ। किसी अंक की वजह से बच्चे पर कोई ठप्पा नहीं लगना चाहिए और न ही दूसरों से उसकी तुलना होनी चाहिए।',
      ),
    ),
    Sec(
      PBi('When you feel low', 'जब मन उदास हो'),
      PBi(
        'If you feel very sad, anxious or hopeless, please talk to a family member, a friend, a doctor or a counsellor. A report should never be your only support in a difficult time.',
        'अगर आपको बहुत उदासी, घबराहट या निराशा महसूस हो तो कृपया परिवार के किसी सदस्य, दोस्त, डॉक्टर या काउंसलर से बात कीजिए। मुश्किल समय में कोई रिपोर्ट आपका अकेला सहारा नहीं होनी चाहिए।',
      ),
    ),
    Sec(
      PBi('Predictions show tendencies', 'भविष्यवाणी रुझान दिखाती है'),
      PBi(
        'The yearly and monthly sections show the likely mood and theme of a period. Your effort, your timing and the choices you make still count the most.',
        'सालाना और मासिक हिस्से किसी दौर का संभावित मिज़ाज और विषय दिखाते हैं। आपकी मेहनत, आपका सही समय और आपके चुनाव फिर भी सबसे ज़्यादा मायने रखते हैं।',
      ),
    ),
  ];

  // ---------------- How to read ----------------
  static const PBi readTitle = PBi('How to Read This Report', 'इस रिपोर्ट को कैसे पढ़ें');
  static const PBi readIntro = PBi(
    'Here is a short guide to the words and the order of this report, so that every page feels easy.',
    'यहाँ इस रिपोर्ट के शब्दों और क्रम की एक छोटी गाइड है, ताकि हर पन्ना आपको आसान लगे।',
  );

  static const List<Sec> read = [
    Sec(
      PBi('Order of the report', 'रिपोर्ट का क्रम'),
      PBi(
        'After these pages come your core numbers, then who you are, your name and mobile number, your coming years with a month-by-month guide, simple remedies, angel numbers and finally an action plan.',
        'इन पन्नों के बाद आपके मुख्य अंक आते हैं, फिर आप कौन हैं, आपका नाम और मोबाइल नंबर, आने वाले सालों का महीने-दर-महीने मार्गदर्शन, सरल उपाय, एंजल नंबर और आख़िर में एक कार्य योजना।',
      ),
    ),
    Sec(
      PBi('Mulank (Birth number)', 'मूलांक (जन्म अंक)'),
      PBi(
        'The single digit made from the day of the month you were born. It shows your nature, habits and the way you react to life.',
        'आपके जन्म की तारीख (दिन) से बना एक अंक। यह आपके स्वभाव, आदतों और जीवन के प्रति आपकी प्रतिक्रिया को दिखाता है।',
      ),
    ),
    Sec(
      PBi('Bhagyank (Destiny number)', 'भाग्यांक'),
      PBi(
        'The single digit made from your complete date of birth. It shows the path and the main lessons of your life.',
        'आपकी पूरी जन्म तिथि से बना एक अंक। यह आपके जीवन के रास्ते और मुख्य सीखों को दिखाता है।',
      ),
    ),
    Sec(
      PBi('Personal Year and Personal Month', 'पर्सनल ईयर और पर्सनल मंथ'),
      PBi(
        'Every year and every month has its own number, made from your birth day, your birth month and that year or month. It shows the theme of that period for you.',
        'हर साल और हर महीने का अपना अंक होता है, जो आपके जन्म के दिन, जन्म के महीने और उस साल या महीने से बनता है। यह आपके लिए उस दौर का विषय बताता है।',
      ),
    ),
    Sec(
      PBi('Compound number (10 to 52)', 'संयुक्त अंक (10 से 52)'),
      PBi(
        'The two-digit total before it is brought down to a single digit. In the Cheiro system every compound number has its own small story and its own caution.',
        'वह दो अंकों का जोड़ जो एक अंक में बदलने से पहले आता है। चीरो पद्धति में हर संयुक्त अंक की अपनी छोटी कहानी और अपनी चेतावनी होती है।',
      ),
    ),
    Sec(
      PBi('Angel numbers', 'एंजल नंबर'),
      PBi(
        'Repeating numbers such as 111 or 777 that you notice again and again in daily life. This report shows which of them are closest to your date of birth.',
        '111 या 777 जैसे दोहराए जाने वाले अंक जो आपको रोज़ की ज़िंदगी में बार-बार दिखते हैं। यह रिपोर्ट बताती है कि इनमें से कौन-से आपकी जन्मतिथि के सबसे करीब हैं।',
      ),
    ),
  ];

  // ---------------- Yearly extra labels ----------------
  static const PBi healthLabel = PBi('Health', 'सेहत');
  static const PBi familyLabel = PBi('Family and home', 'परिवार और घर');
  static const PBi studyLabel = PBi('Learning', 'सीखना');
  static const PBi spiritLabel = PBi('Inner life', 'अंदरूनी जीवन');
  static const PBi monthByMonth = PBi('Month by month', 'महीने-दर-महीने');
  static const PBi monthByMonthIntro = PBi(
    'Each month of this year has its own number. Below, every month is explained one by one: the mood of the month, work and money, love and family, health and one simple tip.',
    'इस साल के हर महीने का अपना अंक है। नीचे हर महीना एक-एक करके समझाया गया है: महीने का मिज़ाज, काम और पैसा, प्रेम और परिवार, सेहत और एक सरल सुझाव।',
  );

  // ---------------- Angel number labels ----------------
  static const PBi angelMeaning = PBi('Meaning', 'मतलब');
  static const PBi angelMessage = PBi('Message', 'संदेश');
  static const PBi angelLove = PBi('Love', 'प्रेम');
  static const PBi angelCareer = PBi('Work', 'काम');
  static const PBi angelStep = PBi('Small step', 'छोटा कदम');
  static const PBi angelYourBirth = PBi('Angel numbers and your date of birth', 'एंजल नंबर और आपकी जन्मतिथि');
  static const PBi angelAll = PBi('All angel numbers explained', 'सभी एंजल नंबर विस्तार से');
  static const PBi angelAllIntro = PBi(
    'The numbers closest to your date of birth come first. The others follow, so you can read the meaning of any number you see.',
    'आपकी जन्मतिथि के सबसे करीब वाले अंक सबसे पहले हैं। बाकी उनके बाद हैं, ताकि आप जो भी अंक देखें उसका मतलब पढ़ सकें।',
  );
}
