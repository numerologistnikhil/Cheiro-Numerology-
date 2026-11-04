import 'root_profiles.dart' show L;

/// One learning lesson: title, one-line summary, body and a small exercise.
class LearnLesson {
  final String id;
  final int level; // 1 beginner, 2 next step, 3 deeper
  final L title;
  final L gist;
  final L body;
  final L tryIt;
  const LearnLesson(this.id, this.level, this.title, this.gist, this.body, this.tryIt);
}

class LearnContent {
  static const L screenTitle = L('Learn Numerology', 'अंकशास्त्र सीखिए');
  static const L lessonsLabel = L('Lessons', 'पाठ');
  static const L quizLabel = L('Test yourself', 'खुद को परखें');
  static const L tryLabel = L('Try it yourself', 'खुद करके देखिए');
  static const L gistLabel = L('In one line', 'एक लाइन में');
  static const L markRead = L('Mark as read', 'पढ़ लिया');
  static const L doneLabel = L('Read', 'पढ़ा');
  static const L intro = L(
    'Short lessons in simple words. Start from level 1 and go step by step. Tap a lesson to open it, '
    'do the small exercise, then mark it as read.',
    'सरल भाषा में छोटे पाठ। स्तर 1 से शुरू करें और एक-एक करके आगे बढ़ें। पाठ खोलें, छोटा अभ्यास करें, फिर "पढ़ लिया" दबाएँ।');
  static const List<L> levelNames = [
    L('Level 1: Basics', 'स्तर 1: बुनियाद'),
    L('Level 2: The nine numbers', 'स्तर 2: नौ अंक'),
    L('Level 3: Using it in life', 'स्तर 3: जीवन में उपयोग'),
  ];
  static const L progress = L('lessons read', 'पाठ पढ़े');

  static const List<LearnLesson> lessons = [
    // ---------------------------------------------------------------- level 1
    LearnLesson('what', 1,
      L('What is numerology?', 'अंकशास्त्र क्या है?'),
      L('A traditional way to read patterns in numbers linked to you.', 'आपसे जुड़े अंकों के पैटर्न पढ़ने का पारंपरिक तरीका।'),
      L('Numerology studies the symbolism of numbers connected to a person: date of birth, name, mobile, house and vehicle numbers. '
        'In India it has been practised for a long time, and the Western Chaldean/Cheiro system is also widely used. '
        'It is an interpretive tradition for reflection, not a science, and it cannot promise outcomes. '
        'Think of it as a mirror: it helps you notice your strengths, your habits and the areas that need extra care.',
        'अंकशास्त्र आपसे जुड़े अंकों के प्रतीकों का अध्ययन है: जन्म तिथि, नाम, मोबाइल, घर और गाड़ी का नंबर। '
        'भारत में यह लंबे समय से चलन में है, और पश्चिमी कैल्डियन/कीरो पद्धति भी खूब इस्तेमाल होती है। '
        'यह चिंतन के लिए एक व्याख्यात्मक परंपरा है, विज्ञान नहीं, और यह नतीजों की गारंटी नहीं देती। '
        'इसे आईने की तरह लें: यह आपकी ताकत, आदतें और ज़्यादा ध्यान देने वाले क्षेत्र पहचानने में मदद करता है।'),
      L('Write down your date of birth. Which numbers can you already see in it?',
        'अपनी जन्म तिथि लिखिए। उसमें आपको कौन-कौन से अंक दिख रहे हैं?')),
    LearnLesson('root', 1,
      L('Root and compound numbers', 'मूल अंक और संयुक्त अंक'),
      L('Add the digits until one digit is left.', 'अंकों को तब तक जोड़ें जब तक एक अंक न बचे।'),
      L('A total such as 32 is called the compound number. Adding its digits gives the root number: 3 + 2 = 5. '
        'Cheiro gave a special meaning to each compound number from 10 to 52, so this app reads the compound number first and then the root. '
        'Example: 29 = 2 + 9 = 11 = 1 + 1 = 2. The compound number shows the story, the root number shows the main energy.',
        '32 जैसे जोड़ को संयुक्त अंक कहते हैं। उसके अंक जोड़ने पर मूल अंक मिलता है: 3 + 2 = 5। '
        'कीरो ने 10 से 52 तक हर संयुक्त अंक को ख़ास अर्थ दिया, इसलिए यह ऐप पहले संयुक्त अंक और फिर मूल अंक पढ़ता है। '
        'उदाहरण: 29 = 2 + 9 = 11 = 1 + 1 = 2। संयुक्त अंक कहानी बताता है, मूल अंक मुख्य ऊर्जा।'),
      L('Find the root of 47 and of 38. (Answers: 2 and 2.)', '47 और 38 का मूल अंक निकालिए। (उत्तर: 2 और 2।)')),
    LearnLesson('mulank', 1,
      L('Mulank and Bhagyank', 'मूलांक और भाग्यांक'),
      L('Mulank = day of birth. Bhagyank = whole date.', 'मूलांक = जन्म का दिन। भाग्यांक = पूरी तारीख।'),
      L('Mulank (psychic number) comes from the day of birth only. It shows your inner nature and how you see yourself. '
        'Bhagyank (destiny number) comes from every digit of day, month and year. It shows the path and lessons of your life. '
        'Born on 6 April 1988: Mulank is 6. Bhagyank is 6+4+1+9+8+8 = 36, then 3+6 = 9. '
        'If your day is 14, Mulank is 1+4 = 5. If your day is 29, Mulank is 2+9 = 11, then 2. '
        'Many people feel that Mulank is how they behave at home and Bhagyank is how life moves them.',
        'मूलांक जन्म के दिन से बनता है। यह आपका अंदरूनी स्वभाव और आप खुद को कैसे देखते हैं, बताता है। '
        'भाग्यांक दिन, महीने और साल के हर अंक से बनता है। यह जीवन का रास्ता और सबक बताता है। '
        '6 अप्रैल 1988: मूलांक 6। भाग्यांक 6+4+1+9+8+8 = 36, फिर 3+6 = 9। '
        'दिन 14 हो तो मूलांक 1+4 = 5। दिन 29 हो तो 2+9 = 11, फिर 2। '
        'कई लोग मानते हैं कि मूलांक घर का स्वभाव है और भाग्यांक वह दिशा जिसमें जीवन ले जाता है।'),
      L('Work out your own Mulank and Bhagyank, then compare with the app.',
        'अपना मूलांक और भाग्यांक निकालिए, फिर ऐप से मिलाइए।')),
    LearnLesson('chaldean', 1,
      L('Chaldean letter values', 'कैल्डियन अक्षर मान'),
      L('Each letter has a value from 1 to 8. Nobody gets 9.', 'हर अक्षर का मान 1 से 8 है। 9 किसी को नहीं मिलता।'),
      L('In the Chaldean system letters carry values from 1 to 8. The number 9 is treated as sacred and is not given to any letter. '
        'A, I, J, Q, Y = 1. B, K, R = 2. C, G, L, S = 3. D, M, T = 4. E, H, N, X = 5. U, V, W = 6. O, Z = 7. F, P = 8. '
        'Add the values of all letters of a name to get its compound number. Spelling matters: ANNU and ANU can give different totals.',
        'कैल्डियन पद्धति में अक्षरों का मान 1 से 8 होता है। 9 को पवित्र माना जाता है, इसलिए किसी अक्षर को नहीं दिया जाता। '
        'A, I, J, Q, Y = 1। B, K, R = 2। C, G, L, S = 3। D, M, T = 4। E, H, N, X = 5। U, V, W = 6। O, Z = 7। F, P = 8। '
        'नाम के सभी अक्षरों का मान जोड़ने पर संयुक्त अंक मिलता है। स्पेलिंग मायने रखती है: ANNU और ANU के जोड़ अलग हो सकते हैं।'),
      L('Add up the letters of your first name using the table.', 'तालिका से अपने पहले नाम के अक्षर जोड़िए।')),
    LearnLesson('wisely', 1,
      L('Using numerology wisely', 'अंकशास्त्र का समझदारी से उपयोग'),
      L('Numbers show tendencies, not fate.', 'अंक झुकाव दिखाते हैं, किस्मत नहीं।'),
      L('Numbers describe tendencies, not destiny. Do not take medical, legal or big money decisions on numerology alone. '
        'A challenging number is just an area where extra awareness helps, and every number has strengths. '
        'Use numerology to ask better questions, then use common sense, expert advice and effort to answer them. '
        'If anyone promises a guaranteed result for money, be careful.',
        'अंक झुकाव बताते हैं, तक़दीर नहीं। सिर्फ़ अंकशास्त्र पर मेडिकल, कानूनी या बड़े पैसे के फ़ैसले न लें। '
        'चुनौतीपूर्ण अंक बस वह जगह है जहाँ ज़्यादा सजगता काम आती है, और हर अंक की अपनी ताकत होती है। '
        'अंकशास्त्र से बेहतर सवाल पूछिए, फिर जवाब के लिए समझदारी, विशेषज्ञ की सलाह और मेहनत का इस्तेमाल कीजिए। '
        'पैसे लेकर पक्का नतीजा देने का वादा करने वाले से सावधान रहें।'),
      L('Think of one decision in your life where numbers can be an extra input, not the only one.',
        'अपने जीवन का ऐसा एक फ़ैसला सोचिए जहाँ अंक सिर्फ़ एक अतिरिक्त आधार हो सकते हैं।')),

    // ---------------------------------------------------------------- level 2
    LearnLesson('n1', 2,
      L('Number 1: Sun', 'अंक 1: सूर्य'),
      L('The leader, starter and one who stands alone.', 'नेता, शुरुआत करने वाला, अकेले खड़े होने वाला।'),
      L('Strengths: leadership, confidence, originality, willpower. Watch out: ego, stubbornness, not listening. '
        'Colours: gold, orange, warm yellow. Day: Sunday. Metal: gold or copper. '
        'Suits: management, own business, government or authority roles. '
        'Growth tip: lead by example and give credit to others.',
        'ताकत: नेतृत्व, आत्मविश्वास, मौलिकता, इच्छाशक्ति। ध्यान दें: अहं, ज़िद, दूसरों की न सुनना। '
        'रंग: सुनहरा, नारंगी, गहरा पीला। दिन: रविवार। धातु: सोना या ताँबा। '
        'उपयुक्त: मैनेजमेंट, अपना काम, सरकारी या अधिकार वाले पद। '
        'सुधार का सुझाव: उदाहरण बनकर नेतृत्व करें और दूसरों को श्रेय दें।'),
      L('Name one thing you started recently without waiting for anyone.', 'ऐसी एक चीज़ याद कीजिए जो आपने हाल में बिना किसी का इंतज़ार किए शुरू की।')),
    LearnLesson('n2', 2,
      L('Number 2: Moon', 'अंक 2: चंद्र'),
      L('The gentle, caring, sensitive partner.', 'कोमल, देखभाल करने वाला, संवेदनशील साथी।'),
      L('Strengths: sensitivity, cooperation, imagination, peacemaking. Watch out: mood swings, over-worry, dependence. '
        'Colours: white, cream, light green. Day: Monday. Metal: silver. '
        'Suits: counselling, hospitality, dairy, art, partnerships. '
        'Growth tip: say what you need clearly and rest when you are tired.',
        'ताकत: संवेदनशीलता, सहयोग, कल्पना, शांति कराना। ध्यान दें: मूड बदलना, ज़्यादा चिंता, निर्भरता। '
        'रंग: सफ़ेद, क्रीम, हल्का हरा। दिन: सोमवार। धातु: चाँदी। '
        'उपयुक्त: काउंसलिंग, होटल, डेयरी, कला, साझेदारी। '
        'सुधार का सुझाव: अपनी ज़रूरत साफ़ कहें और थकने पर आराम करें।'),
      L('Notice today when you felt others\' moods strongly.', 'आज ध्यान दीजिए कब आपने दूसरों का मूड गहराई से महसूस किया।')),
    LearnLesson('n3', 2,
      L('Number 3: Jupiter', 'अंक 3: गुरु'),
      L('The teacher, advisor and optimist.', 'शिक्षक, सलाहकार और आशावादी।'),
      L('Strengths: wisdom, teaching, optimism, respect for values. Watch out: preaching, overconfidence, spending on show. '
        'Colours: yellow, saffron. Day: Thursday. Metal: gold. '
        'Suits: education, finance, law, consulting, religious or social work. '
        'Growth tip: practise what you advise.',
        'ताकत: समझ, पढ़ाना, आशावाद, मूल्यों का सम्मान। ध्यान दें: उपदेश देना, अति-आत्मविश्वास, दिखावे पर खर्च। '
        'रंग: पीला, केसरिया। दिन: गुरुवार। धातु: सोना। '
        'उपयुक्त: शिक्षा, फ़ाइनेंस, कानून, कंसल्टिंग, धार्मिक या सामाजिक काम। '
        'सुधार का सुझाव: जो सलाह देते हैं उस पर खुद चलें।'),
      L('Teach one small thing you know to someone today.', 'आज किसी को अपनी जानी हुई एक छोटी बात सिखाइए।')),
    LearnLesson('n4', 2,
      L('Number 4: Rahu', 'अंक 4: राहु'),
      L('The unusual thinker who builds step by step.', 'हटके सोचने वाला जो कदम-कदम पर निर्माण करता है।'),
      L('Strengths: practical mind, original ideas, hard work, technical skill. Watch out: sudden ups and downs, suspicion, feeling misunderstood. '
        'Colours: blue, grey, electric shades. Day: Saturday and Sunday. '
        'Suits: IT, engineering, research, import-export. '
        'Growth tip: keep clean records and avoid shortcuts and risky promises.',
        'ताकत: व्यावहारिक सोच, मौलिक विचार, मेहनत, तकनीकी हुनर। ध्यान दें: अचानक उतार-चढ़ाव, शक, ग़लत समझे जाने का एहसास। '
        'रंग: नीला, स्लेटी, इलेक्ट्रिक रंग। दिन: शनिवार और रविवार। '
        'उपयुक्त: आईटी, इंजीनियरिंग, शोध, आयात-निर्यात। '
        'सुधार का सुझाव: हिसाब साफ़ रखें, शॉर्टकट और जोखिम भरे वादों से बचें।'),
      L('Write a small plan with 3 steps for one goal.', 'एक लक्ष्य के लिए 3 कदमों की छोटी योजना लिखिए।')),
    LearnLesson('n5', 2,
      L('Number 5: Mercury', 'अंक 5: बुध'),
      L('The quick thinker, talker and trader.', 'तेज़ सोचने, बोलने और व्यापार करने वाला।'),
      L('Strengths: quick mind, communication, adaptability, business sense. Watch out: restlessness, nervous energy, scattered focus. '
        'Colours: green, light grey. Day: Wednesday. Metal: bronze. '
        'Suits: trading, marketing, media, travel, writing. '
        'Growth tip: finish one thing before starting the next.',
        'ताकत: तेज़ दिमाग, बातचीत, ढल जाने की क्षमता, व्यापारिक समझ। ध्यान दें: बेचैनी, घबराहट, बिखरा ध्यान। '
        'रंग: हरा, हल्का स्लेटी। दिन: बुधवार। धातु: काँसा। '
        'उपयुक्त: ट्रेडिंग, मार्केटिंग, मीडिया, यात्रा, लेखन। '
        'सुधार का सुझाव: अगला शुरू करने से पहले एक काम पूरा करें।'),
      L('Pick one unfinished task and finish it today.', 'एक अधूरा काम चुनिए और आज ही पूरा कीजिए।')),
    LearnLesson('n6', 2,
      L('Number 6: Venus', 'अंक 6: शुक्र'),
      L('The lover of beauty, comfort and harmony.', 'सुंदरता, सुख और तालमेल को चाहने वाला।'),
      L('Strengths: charm, love of family, artistic taste, hospitality. Watch out: laziness, over-indulgence, jealousy. '
        'Colours: white, pink, pastel shades. Day: Friday. Metal: silver or platinum. '
        'Suits: fashion, beauty, hotels, design, entertainment. '
        'Growth tip: balance comfort with discipline.',
        'ताकत: आकर्षण, परिवार से प्यार, कलात्मक रुचि, मेहमाननवाज़ी। ध्यान दें: आलस्य, अति-भोग, जलन। '
        'रंग: सफ़ेद, गुलाबी, हल्के रंग। दिन: शुक्रवार। धातु: चाँदी या प्लैटिनम। '
        'उपयुक्त: फ़ैशन, ब्यूटी, होटल, डिज़ाइन, मनोरंजन। '
        'सुधार का सुझाव: आराम और अनुशासन में संतुलन रखें।'),
      L('Make one corner of your home or desk more beautiful today.', 'आज घर या डेस्क का एक कोना और सुंदर बनाइए।')),
    LearnLesson('n7', 2,
      L('Number 7: Ketu', 'अंक 7: केतु'),
      L('The thinker, seeker and researcher.', 'चिंतक, खोजी और शोधकर्ता।'),
      L('Strengths: deep thinking, intuition, research, spiritual interest. Watch out: isolation, doubt, moodiness. '
        'Colours: light green, white, pale shades. Day: Monday. '
        'Suits: research, writing, spiritual or healing work, analysis. '
        'Growth tip: share your thoughts with one trusted person.',
        'ताकत: गहरा चिंतन, अंतर्ज्ञान, शोध, आध्यात्मिक रुचि। ध्यान दें: अकेलापन, संदेह, मूड बदलना। '
        'रंग: हल्का हरा, सफ़ेद, फीके रंग। दिन: सोमवार। '
        'उपयुक्त: शोध, लेखन, आध्यात्मिक या उपचार का काम, विश्लेषण। '
        'सुधार का सुझाव: अपने विचार किसी एक भरोसेमंद व्यक्ति से बाँटें।'),
      L('Spend 10 quiet minutes without the phone and note what comes to mind.', '10 मिनट बिना फ़ोन के शांत बैठिए और जो मन में आए वह लिखिए।')),
    LearnLesson('n8', 2,
      L('Number 8: Saturn', 'अंक 8: शनि'),
      L('The worker who gets results through patience.', 'धैर्य से नतीजे पाने वाला मेहनती।'),
      L('Strengths: discipline, patience, responsibility, endurance. Watch out: delays, heaviness, being too serious, loneliness. '
        'Colours: dark blue, black, grey. Day: Saturday. Metal: iron. '
        'Suits: real estate, construction, law, administration, long projects. '
        'Growth tip: be fair with workers and keep promises; Saturn rewards honest effort.',
        'ताकत: अनुशासन, धैर्य, ज़िम्मेदारी, सहनशक्ति। ध्यान दें: देरी, भारीपन, ज़्यादा गंभीर रहना, अकेलापन। '
        'रंग: गहरा नीला, काला, स्लेटी। दिन: शनिवार। धातु: लोहा। '
        'उपयुक्त: रियल एस्टेट, निर्माण, कानून, प्रशासन, लंबी परियोजनाएँ। '
        'सुधार का सुझाव: कर्मचारियों के साथ न्यायपूर्ण रहें और वादे निभाएँ; शनि ईमानदार मेहनत का फल देता है।'),
      L('Set one daily habit and keep it for 7 days.', 'एक रोज़ की आदत चुनिए और 7 दिन निभाइए।')),
    LearnLesson('n9', 2,
      L('Number 9: Mars', 'अंक 9: मंगल'),
      L('The fighter, helper and finisher.', 'योद्धा, मददगार और काम पूरा करने वाला।'),
      L('Strengths: courage, energy, generosity, drive. Watch out: anger, rashness, arguments. '
        'Colours: red, maroon, coral. Day: Tuesday. Metal: copper. '
        'Suits: defence, sport, engineering, surgery, action-based work. '
        'Growth tip: pause before reacting and put energy into exercise or service.',
        'ताकत: साहस, ऊर्जा, उदारता, जोश। ध्यान दें: गुस्सा, जल्दबाज़ी, बहस। '
        'रंग: लाल, मरून, मूंगिया। दिन: मंगलवार। धातु: ताँबा। '
        'उपयुक्त: रक्षा, खेल, इंजीनियरिंग, सर्जरी, एक्शन वाले काम। '
        'सुधार का सुझाव: प्रतिक्रिया से पहले रुकें और ऊर्जा को व्यायाम या सेवा में लगाएँ।'),
      L('Next time you feel angry, count to ten, then decide what to say.', 'अगली बार गुस्सा आए तो दस तक गिनिए, फिर तय कीजिए क्या कहना है।')),

    // ---------------------------------------------------------------- level 3
    LearnLesson('friends', 3,
      L('Friendly and opposed numbers', 'मित्र और विरोधी अंक'),
      L('Some numbers support each other, some clash.', 'कुछ अंक एक-दूसरे का साथ देते हैं, कुछ टकराते हैं।'),
      L('In this tradition certain pairs are friendly (for example 1 with 2, 3, 9 and 5 with 6) and some are opposed (for example 1 with 8 and 4 with 9 are often called difficult pairs). '
        'Friendly pairs usually mean smoother cooperation. An opposed pair does not mean a relationship or business cannot work. It only shows where more patience is needed. '
        'The app uses friend, neutral and opposed to choose dates, names and numbers.',
        'इस परंपरा में कुछ जोड़े मित्र माने जाते हैं (जैसे 1 के साथ 2, 3, 9 और 5 के साथ 6) और कुछ विरोधी (जैसे 1 और 8, या 4 और 9 को अक्सर कठिन जोड़ी कहा जाता है)। '
        'मित्र जोड़ी आमतौर पर आसान सहयोग दिखाती है। विरोधी जोड़ी का मतलब यह नहीं कि रिश्ता या बिज़नेस चल नहीं सकता, बस वहाँ ज़्यादा धैर्य चाहिए। '
        'ऐप तारीख, नाम और अंक चुनने में मित्र, सम और विरोधी का इस्तेमाल करता है।'),
      L('Look at your Mulank and your partner\'s in Compatibility and read the reason.', 'कम्पैटिबिलिटी में अपना और साथी का मूलांक डालकर कारण पढ़िए।')),
    LearnLesson('loshu', 3,
      L('Lo Shu grid', 'लो शू ग्रिड'),
      L('A 3x3 box made from your birth date digits.', 'जन्म तिथि के अंकों से बना 3x3 का खाना।'),
      L('Write the digits of your birth date in a 3x3 grid: 4 9 2 / 3 5 7 / 8 1 6. A digit that appears is filled; a digit that does not appear is a missing number. '
        'Repeated digits show strong traits. Missing numbers show areas to build with habits. '
        'For example, a missing 5 may suggest paying more attention to balance and stability. Missing numbers are not bad luck, just a hint for what to practise.',
        'जन्म तिथि के अंकों को 3x3 ग्रिड में लिखें: 4 9 2 / 3 5 7 / 8 1 6। जो अंक आता है वह भरा जाता है, जो नहीं आता वह खाली (अनुपस्थित) अंक है। '
        'दोहराए अंक मज़बूत गुण दिखाते हैं। अनुपस्थित अंक वे क्षेत्र हैं जिन्हें आदतों से मज़बूत किया जा सकता है। '
        'जैसे 5 न हो तो संतुलन और स्थिरता पर ज़्यादा ध्यान देने का संकेत माना जाता है। अनुपस्थित अंक बुरी किस्मत नहीं, बस अभ्यास का इशारा है।'),
      L('Open the Lo Shu screen and see which numbers are missing for you.', 'लो शू स्क्रीन खोलकर देखिए आपके कौन से अंक अनुपस्थित हैं।')),
    LearnLesson('name', 3,
      L('Name numbers and name correction', 'नाम के अंक और नाम सुधार'),
      L('Spelling changes the total of your name.', 'स्पेलिंग बदलने से नाम का जोड़ बदलता है।'),
      L('The compound number of your full name shows how you are seen and how you act in daily life. '
        'Name correction compares small spelling changes (not a new name) and checks that the total suits your Mulank and Bhagyank. '
        'A heavy total such as 35 is treated with care by some numerologists, so check alternatives. '
        'Choose a spelling that you are comfortable to use everywhere, on documents, signature and social media.',
        'पूरे नाम का संयुक्त अंक बताता है कि लोग आपको कैसे देखते हैं और रोज़ आप कैसे व्यवहार करते हैं। '
        'नाम सुधार में छोटे स्पेलिंग बदलाव (नया नाम नहीं) जाँचे जाते हैं कि जोड़ आपके मूलांक और भाग्यांक से मेल खाता है या नहीं। '
        '35 जैसा भारी जोड़ कुछ अंकशास्त्री सावधानी से देखते हैं, इसलिए विकल्प जाँचिए। '
        'ऐसी स्पेलिंग चुनें जिसे आप दस्तावेज़ों, हस्ताक्षर और सोशल मीडिया पर हर जगह आराम से इस्तेमाल कर सकें।'),
      L('Compare two spellings of your name in Name Correction.', 'नाम सुधार में अपने नाम की दो स्पेलिंग की तुलना कीजिए।')),
    LearnLesson('home', 3,
      L('House, flat, mobile and vehicle numbers', 'घर, फ़्लैट, मोबाइल और गाड़ी के नंबर'),
      L('Numbers around you can be checked too.', 'आपके आसपास के नंबर भी जाँचे जा सकते हैं।'),
      L('Add all digits of a house or flat number to get its root, then see whether it is friendly with your Mulank and Bhagyank. '
        'For a house number with letters (like 12A) the letter is added using the Chaldean value. '
        'The same idea is used for vehicle and mobile numbers. If a number is not friendly, practical remedies in the app are colours, nameplate and habits. '
        'Do not change a home or vehicle only because of a number.',
        'घर या फ़्लैट नंबर के सभी अंक जोड़कर मूल अंक निकालें, फिर देखें कि वह आपके मूलांक और भाग्यांक का मित्र है या नहीं। '
        'अक्षर वाले नंबर (जैसे 12A) में अक्षर का कैल्डियन मान जोड़ा जाता है। '
        'यही तरीका गाड़ी और मोबाइल नंबर पर लगता है। नंबर अनुकूल न हो तो ऐप के व्यावहारिक उपाय हैं: रंग, नेमप्लेट और आदतें। '
        'सिर्फ़ किसी नंबर की वजह से घर या गाड़ी न बदलें।'),
      L('Check your house number in Lucky Number Kit.', 'लकी नंबर किट में अपना घर का नंबर जाँचिए।')),
    LearnLesson('business', 3,
      L('Starting a business: date, name and logo', 'बिज़नेस शुरू करना: तारीख, नाम और लोगो'),
      L('Three numbers should agree with the owner.', 'तीन अंक मालिक से मेल खाने चाहिए।'),
      L('Numerologists such as Sanjay B. Jumani teach that a business works best when the launch date number, the business name total and the logo colour or number all agree with the owner\'s Mulank and Bhagyank. '
        'Use Date Selection to find friendly dates, then keep the name total friendly and avoid heavy totals. '
        'Treat this as tradition, not a guarantee. A good product, cash flow and customer service matter far more.',
        'संजय बी. जुमानी जैसे अंकशास्त्री सिखाते हैं कि बिज़नेस तब बेहतर चलता है जब शुरू करने की तारीख का अंक, बिज़नेस के नाम का जोड़ और लोगो का रंग या अंक मालिक के मूलांक और भाग्यांक से मेल खाएँ। '
        'अनुकूल तारीख के लिए तिथि चयन इस्तेमाल करें, फिर नाम का जोड़ भी अनुकूल रखें और भारी जोड़ से बचें। '
        'इसे परंपरा मानें, गारंटी नहीं। अच्छा प्रोडक्ट, कैश फ़्लो और ग्राहक सेवा कहीं ज़्यादा मायने रखते हैं।'),
      L('Pick a business purpose in Date Selection and open one date to read why it is lucky.', 'तिथि चयन में बिज़नेस चुनिए और एक तारीख खोलकर पढ़िए कि वह शुभ क्यों है।')),
    LearnLesson('year', 3,
      L('Personal year and month', 'व्यक्तिगत वर्ष और महीना'),
      L('Each year has a theme that moves from 1 to 9.', 'हर साल की एक थीम होती है जो 1 से 9 तक घूमती है।'),
      L('Personal year = your birth day + birth month + the current year, reduced to one digit. '
        'Year 1 is for starting, 2 for patience and partnerships, 3 for expression, 4 for building, 5 for change, 6 for family, 7 for rest and learning, 8 for results, 9 for finishing. '
        'The personal month adds the calendar month to the personal year. Use it to plan: start new things in 1, consolidate in 4 and 8, let go in 9.',
        'व्यक्तिगत वर्ष = जन्म का दिन + जन्म का महीना + वर्तमान वर्ष, एक अंक तक घटाकर। '
        'वर्ष 1 शुरुआत का, 2 धैर्य और साझेदारी का, 3 अभिव्यक्ति का, 4 निर्माण का, 5 बदलाव का, 6 परिवार का, 7 विश्राम और सीखने का, 8 नतीजों का, 9 समेटने का। '
        'व्यक्तिगत महीना = कैलेंडर का महीना + व्यक्तिगत वर्ष। योजना के लिए इस्तेमाल करें: 1 में नया शुरू करें, 4 और 8 में मज़बूत करें, 9 में छोड़ना सीखें।'),
      L('Calculate your personal year for this year and compare with Predictions.', 'इस साल का अपना व्यक्तिगत वर्ष निकालिए और भविष्यवाणी से मिलाइए।')),
    LearnLesson('remedies', 3,
      L('Colours, gemstones and rudraksha', 'रंग, रत्न और रुद्राक्ष'),
      L('Simple habits first, stones and beads only with care.', 'पहले सरल आदतें, रत्न और मनके सिर्फ़ सावधानी से।'),
      L('Start with the easiest remedies: wear or keep your friendly colour, follow your lucky day, and build the habit linked with your number. '
        'Gemstones and rudraksha are traditional options. They should be genuine, comfortable and chosen with an advisor you trust, and they never replace medicine, effort or professional advice. '
        'Many people who wear an energised rudraksha feel it works better for them; this is a matter of faith and personal experience. '
        'The Gemstones and Rudraksha screens explain finger, weight, day, mantra, care and how to avoid fakes.',
        'सबसे आसान उपायों से शुरू करें: अपने मित्र रंग पहनें या रखें, अपने शुभ दिन का ध्यान रखें और अपने अंक से जुड़ी आदत बनाएँ। '
        'रत्न और रुद्राक्ष पारंपरिक विकल्प हैं। ये असली, आरामदायक और किसी भरोसेमंद सलाहकार की राय से चुने जाएँ, और ये दवा, मेहनत या पेशेवर सलाह की जगह कभी नहीं लेते। '
        'कई लोग मानते हैं कि प्राण-प्रतिष्ठा किया हुआ रुद्राक्ष उनके लिए ज़्यादा असरदार रहता है; यह आस्था और निजी अनुभव की बात है। '
        'रत्न और रुद्राक्ष स्क्रीन में उँगली, वज़न, दिन, मंत्र, देखभाल और नकली से बचने के तरीके समझाए गए हैं।'),
      L('Open Gemstones and Rudraksha and read the care and fake-check parts.', 'रत्न और रुद्राक्ष खोलकर देखभाल और नकली-जाँच वाले हिस्से पढ़िए।')),
  ];
}
