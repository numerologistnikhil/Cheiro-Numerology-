import 'root_profiles.dart' show L;

/// Traditional body-area associations for each number, with simple care
/// habits. These are traditional beliefs, not medical findings. Nothing here
/// diagnoses an illness or replaces a doctor.
class HealthInfo {
  final int root;
  final L planet;
  final L areas; // body areas traditionally linked
  final L watch; // problems to keep an eye on
  final L habits; // everyday care
  final L checkup; // check-ups worth doing regularly
  const HealthInfo(this.root, this.planet, this.areas, this.watch, this.habits, this.checkup);
}

class HealthGuide {
  static const L title = L('Health and Precautions', 'स्वास्थ्य और सावधानियाँ');
  static const L intro = L(
    'In traditional numerology each number is linked with a planet, and each planet with certain parts of the body. '
    'This page tells you which areas to take a little extra care of, so you can stay ahead of problems with simple habits and regular check-ups. '
    'It is a traditional belief, not a medical finding. It does not say you will fall ill, and it never replaces a doctor.',
    'पारंपरिक अंकशास्त्र में हर अंक एक ग्रह से और हर ग्रह शरीर के कुछ हिस्सों से जुड़ा है। '
    'यह पन्ना बताता है कि किन हिस्सों का थोड़ा ज़्यादा ध्यान रखें, ताकि सरल आदतों और नियमित जाँच से आप समस्या से पहले सतर्क रहें। '
    'यह पारंपरिक मान्यता है, चिकित्सीय निष्कर्ष नहीं। यह नहीं कहता कि आप बीमार पड़ेंगे, और यह डॉक्टर की जगह कभी नहीं लेता।');
  static const L mulankHead = L('For your Mulank', 'आपके मूलांक के लिए');
  static const L bhagyankHead = L('For your Bhagyank', 'आपके भाग्यांक के लिए');
  static const L planetLabel = L('Linked planet', 'संबंधित ग्रह');
  static const L areasLabel = L('Body areas linked', 'शरीर के संबंधित हिस्से');
  static const L watchLabel = L('Keep an eye on', 'इन पर नज़र रखें');
  static const L habitsLabel = L('Care habits', 'देखभाल की आदतें');
  static const L checkLabel = L('Check-ups worth doing', 'कराने लायक जाँच');
  static const L allTitle = L('All numbers 1 to 9', 'सभी अंक 1 से 9');
  static const L doctorTitle = L('See a doctor without delay if', 'तुरंत डॉक्टर को दिखाएँ यदि');
  static const L doctorBody = L(
    'you have chest pain or pressure, sudden breathlessness, sudden weakness or numbness on one side, trouble speaking, '
    'severe headache that is new for you, fainting, heavy bleeding, high fever that does not settle, thoughts of harming yourself, or any symptom that worries you. '
    'Do not wait for a numerology reading to decide. Do not stop or change any medicine on your own.',
    'सीने में दर्द या दबाव, अचानक साँस फूलना, एक तरफ़ अचानक कमज़ोरी या सुन्नपन, बोलने में दिक्कत, नए तरह का तेज़ सिरदर्द, चक्कर या बेहोशी, '
    'ज़्यादा खून बहना, न उतरने वाला तेज़ बुखार, खुद को नुकसान पहुँचाने के विचार, या कोई भी लक्षण जो आपको चिंतित करे। '
    'फ़ैसले के लिए अंकशास्त्र का इंतज़ार न करें। अपनी मर्ज़ी से कोई दवा बंद या बदलें नहीं।');

  static const Map<int, HealthInfo> byRoot = {
    1: HealthInfo(
      1,
      L('Sun', 'सूर्य'),
      L('Heart, spine and bones, eyes, head, blood pressure.', 'हृदय, रीढ़ और हड्डियाँ, आँखें, सिर, रक्तचाप।'),
      L('Blood pressure, heart strain, eye strain, headaches, back pain, over-heating and tiredness from over-work.',
        'रक्तचाप, हृदय पर बोझ, आँखों की थकान, सिरदर्द, पीठ दर्द, गर्मी और ज़्यादा काम से थकान।'),
      L('Morning sunlight, walking, less salt, regular sleep, short breaks from screens, and slowing down when angry or stressed.',
        'सुबह की धूप, सैर, कम नमक, नियमित नींद, स्क्रीन से छोटे ब्रेक, और गुस्से या तनाव में रुकना।'),
      L('Blood pressure, eye test, basic heart check after 35 to 40.', 'रक्तचाप, आँखों की जाँच, 35-40 के बाद हृदय की बुनियादी जाँच।')),
    2: HealthInfo(
      2,
      L('Moon', 'चंद्र'),
      L('Chest, stomach and digestion, fluids in the body, sleep, nerves and mind.', 'छाती, पेट और पाचन, शरीर के तरल, नींद, नसें और मन।'),
      L('Digestion trouble, cold and chest congestion, water retention, poor sleep, anxiety and mood swings, women\'s cycle irregularities.',
        'पाचन की दिक्कत, सर्दी-जुकाम और छाती में जमाव, पानी रुकना, कम नींद, चिंता और मूड बदलना, महिलाओं में मासिक चक्र की गड़बड़ी।'),
      L('Fixed meal times, warm light food, enough water, a calm bedtime routine, time with people you trust, and talking about worries early.',
        'खाने का तय समय, गर्म हल्का भोजन, पर्याप्त पानी, शांत सोने की दिनचर्या, भरोसेमंद लोगों के साथ समय, और चिंता जल्दी साझा करना।'),
      L('Digestive check, thyroid and hormones if symptoms, sleep review.', 'पाचन की जाँच, लक्षण हों तो थायरॉइड और हार्मोन, नींद की समीक्षा।')),
    3: HealthInfo(
      3,
      L('Jupiter', 'गुरु'),
      L('Liver, fat metabolism, thighs and hips, pancreas, ears.', 'लिवर, चर्बी का चयापचय, जाँघें और कूल्हे, अग्न्याशय, कान।'),
      L('Weight gain, high cholesterol, fatty liver, blood sugar changes, sluggishness, over-eating and sweet or oily food.',
        'वज़न बढ़ना, कोलेस्ट्रॉल, फैटी लिवर, शुगर में बदलाव, सुस्ती, ज़्यादा खाना और मीठा या तैलीय भोजन।'),
      L('Portion control, less sugar and fried food, daily walking, regular fasting only if your doctor agrees, and alcohol in strict moderation or none.',
        'खाने की मात्रा पर नियंत्रण, कम चीनी और तला भोजन, रोज़ की सैर, डॉक्टर सहमत हों तभी उपवास, और शराब बहुत कम या बिल्कुल नहीं।'),
      L('Blood sugar, lipid profile, liver function, weight and waist check.', 'ब्लड शुगर, लिपिड प्रोफ़ाइल, लिवर फ़ंक्शन, वज़न और कमर की जाँच।')),
    4: HealthInfo(
      4,
      L('Rahu', 'राहु'),
      L('Nerves, skin, allergies, sleep rhythm, sudden or unusual symptoms.', 'नसें, त्वचा, एलर्जी, नींद का चक्र, अचानक या अजीब लक्षण।'),
      L('Allergies, skin trouble, nerve strain, irregular sleep, stress from overthinking, symptoms that come suddenly and are hard to explain, and reactions to medicines.',
        'एलर्जी, त्वचा की समस्या, नसों पर तनाव, अनियमित नींद, ज़्यादा सोचने का तनाव, अचानक आने वाले अजीब लक्षण, और दवाओं से प्रतिक्रिया।'),
      L('Regular sleep and wake time, less caffeine and late-night screens, clean food and water, and telling your doctor about every medicine and allergy.',
        'सोने-जागने का नियमित समय, कम कैफ़ीन और रात की स्क्रीन, साफ़ भोजन और पानी, और डॉक्टर को हर दवा और एलर्जी बताना।'),
      L('Allergy and skin review, sleep check, a second opinion for unexplained symptoms.', 'एलर्जी और त्वचा की समीक्षा, नींद की जाँच, अनजाने लक्षणों पर दूसरी राय।')),
    5: HealthInfo(
      5,
      L('Mercury', 'बुध'),
      L('Nervous system, skin, lungs and breathing, throat, hands, speech.', 'तंत्रिका तंत्र, त्वचा, फेफड़े और साँस, गला, हाथ, वाणी।'),
      L('Nervous tension, anxiety, restlessness, breathing or throat problems, skin sensitivity, tiredness from too much thinking and talking.',
        'नसों का तनाव, चिंता, बेचैनी, साँस या गले की समस्या, त्वचा की संवेदनशीलता, ज़्यादा सोचने-बोलने की थकान।'),
      L('Breathing exercises, quiet time without the phone, steady meals, protecting the voice, avoiding smoke and dust, and one task at a time.',
        'साँस के व्यायाम, फ़ोन के बिना शांत समय, नियमित भोजन, आवाज़ की देखभाल, धुआँ-धूल से बचना, और एक समय में एक काम।'),
      L('Lung and throat check if you smoke or have a cough, stress and sleep review.', 'धूम्रपान या खाँसी हो तो फेफड़े-गले की जाँच, तनाव और नींद की समीक्षा।')),
    6: HealthInfo(
      6,
      L('Venus', 'शुक्र'),
      L('Kidneys and urinary system, throat, reproductive system, skin, sugar balance.', 'गुर्दे और मूत्र तंत्र, गला, प्रजनन तंत्र, त्वचा, शुगर का संतुलन।'),
      L('Kidney or urinary trouble, throat problems, sugar imbalance, hormonal issues, skin issues, and over-indulgence in sweets and rich food.',
        'गुर्दे या मूत्र की समस्या, गले की दिक्कत, शुगर असंतुलन, हार्मोन की समस्या, त्वचा की दिक्कत, और मिठाई-भारी भोजन की अति।'),
      L('Plenty of water, limited sweets, moderate salt, regular movement, enough rest, and not ignoring urinary or throat symptoms.',
        'भरपूर पानी, कम मिठाई, सीमित नमक, नियमित हरकत, पर्याप्त आराम, और मूत्र या गले के लक्षणों को नज़रअंदाज़ न करना।'),
      L('Kidney function and urine test, blood sugar, hormone check as advised.', 'गुर्दे की जाँच और यूरिन टेस्ट, ब्लड शुगर, सलाह पर हार्मोन जाँच।')),
    7: HealthInfo(
      7,
      L('Ketu', 'केतु'),
      L('Digestive system, nerves, immunity, skin, feet.', 'पाचन तंत्र, नसें, रोग प्रतिरोधक क्षमता, त्वचा, पैर।'),
      L('Digestive complaints, low immunity, vague tiredness, infections, nervous exhaustion, low mood from too much isolation, and being careless about small injuries.',
        'पाचन की शिकायतें, कमज़ोर प्रतिरोधक क्षमता, अस्पष्ट थकान, संक्रमण, नसों की थकान, ज़्यादा अकेलेपन से उदासी, और छोटी चोटों की लापरवाही।'),
      L('Light, clean food, hygiene, enough sleep, gentle yoga or meditation, time outdoors, and staying connected with friends and family.',
        'हल्का साफ़ भोजन, स्वच्छता, पर्याप्त नींद, हल्का योग या ध्यान, बाहर समय बिताना, और मित्रों-परिवार से जुड़े रहना।'),
      L('Digestive and vitamin check (D and B12), immunity review, mood check-in.', 'पाचन और विटामिन (D और B12) की जाँच, प्रतिरोधक क्षमता की समीक्षा, मन की स्थिति की जाँच।')),
    8: HealthInfo(
      8,
      L('Saturn', 'शनि'),
      L('Bones and joints, knees, teeth, ageing and long-term (chronic) conditions, nerves, mood.', 'हड्डियाँ और जोड़, घुटने, दाँत, बढ़ती उम्र और लंबी बीमारियाँ, नसें, मन।'),
      L('Joint and knee pain, back stiffness, tooth problems, low vitamin D and calcium, chronic tiredness, heaviness of mood and over-work.',
        'जोड़ों और घुटनों का दर्द, पीठ की अकड़न, दाँत की समस्या, विटामिन D और कैल्शियम की कमी, पुरानी थकान, मन का भारीपन और ज़्यादा काम।'),
      L('Regular gentle exercise, stretching, calcium and vitamin D with doctor advice, good posture, proper rest days, and sharing your load with others.',
        'नियमित हल्का व्यायाम, स्ट्रेचिंग, डॉक्टर की सलाह से कैल्शियम और विटामिन D, सही बैठने का ढंग, आराम के दिन, और बोझ दूसरों से बाँटना।'),
      L('Bone density and vitamin D, dental check twice a year, joint review.', 'हड्डी का घनत्व और विटामिन D, साल में दो बार दाँतों की जाँच, जोड़ों की समीक्षा।')),
    9: HealthInfo(
      9,
      L('Mars', 'मंगल'),
      L('Blood, muscles, head, blood pressure, heat in the body.', 'खून, मांसपेशियाँ, सिर, रक्तचाप, शरीर की गर्मी।'),
      L('Injuries and accidents from haste, fevers and inflammation, blood pressure, anger-linked tension, acidity, and low iron.',
        'जल्दबाज़ी से चोट और दुर्घटना, बुखार और सूजन, रक्तचाप, गुस्से से जुड़ा तनाव, एसिडिटी, और आयरन की कमी।'),
      L('Safe driving and tools, warm-up before exercise, cooling food in summer, giving energy to sport, and a pause before reacting.',
        'सुरक्षित ड्राइविंग और औज़ार, व्यायाम से पहले वार्म-अप, गर्मियों में ठंडक देने वाला भोजन, ऊर्जा को खेल में लगाना, और प्रतिक्रिया से पहले रुकना।'),
      L('Blood pressure, haemoglobin and iron, a full blood count once a year.', 'रक्तचाप, हीमोग्लोबिन और आयरन, साल में एक बार पूरा ब्लड काउंट।')),
  };

  // ---------------------------------------------------------- precautions
  static const L precTitle = L('Precautions for the Jatak (you)', 'जातक के लिए सावधानियाँ');
  static const L precIntro = L(
    'Numerology works best when it is used with care. Please read these points once.',
    'अंकशास्त्र तब सबसे अच्छा काम करता है जब उसे सावधानी से इस्तेमाल किया जाए। कृपया ये बातें एक बार पढ़ें।');

  static const List<L> precautions = [
    L('Numerology is a traditional tool for reflection. It does not predict or guarantee anything exactly. Treat every reading as guidance, never as a certainty.',
      'अंकशास्त्र चिंतन का पारंपरिक साधन है। यह कुछ भी ठीक-ठीक भविष्यवाणी या गारंटी नहीं देता। हर पाठ को मार्गदर्शन मानें, निश्चितता नहीं।'),
    L('Do not take medical, legal or big money decisions only on the basis of a number. Ask a qualified doctor, lawyer or financial adviser.',
      'सिर्फ़ किसी अंक के आधार पर मेडिकल, कानूनी या बड़े पैसे के फ़ैसले न लें। योग्य डॉक्टर, वकील या वित्तीय सलाहकार से पूछें।'),
    L('Never stop or change medicine because of a reading. Health pages here are habit reminders, not diagnosis.',
      'किसी पाठ के कारण दवा बंद या बदलें नहीं। यहाँ के स्वास्थ्य पन्ने आदत की याद दिलाते हैं, निदान नहीं।'),
    L('Be careful with anyone who promises a guaranteed result, asks for large money, or says a bad number can only be fixed by an expensive remedy.',
      'जो गारंटी वाले नतीजे का वादा करे, बड़ी रकम माँगे, या कहे कि बुरा अंक सिर्फ़ महँगे उपाय से ठीक होगा, उससे सावधान रहें।'),
    L('Buy gemstones and rudraksha only from a trusted seller with a written bill and return policy. Do not wear a stone you feel uncomfortable with; remove it and ask an adviser.',
      'रत्न और रुद्राक्ष सिर्फ़ भरोसेमंद विक्रेता से लिखित बिल और वापसी नीति के साथ लें। जिस रत्न से असहजता हो उसे न पहनें; उतारें और सलाहकार से पूछें।'),
    L('Change a name spelling only if you are comfortable using it everywhere. For any legal change of name, follow the official process and keep every document consistent.',
      'नाम की स्पेलिंग तभी बदलें जब आप उसे हर जगह इस्तेमाल करने में सहज हों। नाम का कानूनी बदलाव आधिकारिक प्रक्रिया से करें और सभी दस्तावेज़ एक जैसे रखें।'),
    L('Keep your date of birth, mobile number and reports private. Share reports only with people you trust.',
      'अपनी जन्म तिथि, मोबाइल नंबर और रिपोर्ट निजी रखें। रिपोर्ट सिर्फ़ भरोसेमंद लोगों से साझा करें।'),
    L('A challenging number is an area for extra awareness, not a curse. Every number has strengths. Do not let a reading make you fearful or stop you from acting.',
      'कठिन अंक अतिरिक्त सजगता का क्षेत्र है, श्राप नहीं। हर अंक की अपनी ताकत है। पाठ को अपने डर या रुकावट की वजह न बनने दें।'),
    L('If you feel very low, hopeless or unsafe, talk to a family member, friend or a mental health professional right away. A report cannot help with that.',
      'यदि आप बहुत उदास, निराश या असुरक्षित महसूस करें तो तुरंत परिवार, मित्र या मानसिक स्वास्थ्य विशेषज्ञ से बात करें। रिपोर्ट इसमें मदद नहीं कर सकती।'),
    L('Use remedies in a way that is gentle and affordable: colours, habits, kindness, charity and discipline come first. Effort, honesty and timing matter more than any number.',
      'उपाय सरल और सस्ते रखें: रंग, आदतें, दयालुता, दान और अनुशासन पहले आते हैं। किसी भी अंक से ज़्यादा मेहनत, ईमानदारी और सही समय मायने रखते हैं।'),
    L('Different numerologists (Chaldean, Pythagorean, Vedic) can give different readings. This is normal. Follow the system you trust and use it the same way each time.',
      'अलग अंकशास्त्री (कैल्डियन, पाइथागोरस, वैदिक) अलग पाठ दे सकते हैं। यह सामान्य है। जिस पद्धति पर भरोसा हो उसे हर बार एक ही तरह इस्तेमाल करें।'),
  ];
}
