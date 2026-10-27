import 'report_pages.dart' show PBi;

/// Detailed text for one personal month (1 to 9).
class MonthDetail {
  final PBi word;
  final PBi story;
  final PBi work;
  final PBi love;
  final PBi health;
  final PBi tip;
  const MonthDetail({
    required this.word,
    required this.story,
    required this.work,
    required this.love,
    required this.health,
    required this.tip,
  });
}

/// Month by month explanations used in the yearly part of the report.
class MonthDetails {
  static const PBi personalMonth = PBi('Personal month', 'पर्सनल मंथ');
  static const PBi workLabel = PBi('Work and money', 'काम और पैसा');
  static const PBi loveLabel = PBi('Love and family', 'प्रेम और परिवार');
  static const PBi healthLabel = PBi('Health', 'सेहत');
  static const PBi tipLabel = PBi('Simple tip', 'सरल सुझाव');

  static const Map<int, MonthDetail> all = {
    1: MonthDetail(
      word: PBi('new start', 'नई शुरुआत'),
      story: PBi(
        "This month feels like a fresh page. Ideas, energy and the wish to start something come up easily. Decide what you really want and take the first step instead of waiting for a perfect moment.",
        "यह महीना नए पन्ने जैसा है। नए विचार, जोश और कुछ शुरू करने की इच्छा आसानी से उठती है। तय कीजिए कि आप सच में क्या चाहते हैं और सही समय का इंतज़ार करने के बजाय पहला कदम उठाइए।",
      ),
      work: PBi(
        "Good time to begin a task, share an idea or take the lead. Do not start too many things at once; pick one or two and see them through.",
        "कोई काम शुरू करने, विचार रखने या आगे बढ़कर ज़िम्मेदारी लेने का अच्छा समय है। एक साथ बहुत कुछ शुरू मत कीजिए, एक-दो काम चुनकर उन्हें पूरा कीजिए।",
      ),
      love: PBi(
        "Be clear and kind in what you say at home. Do not let pride or the wish to win turn a small talk into an argument.",
        "घर में अपनी बात साफ़ और नरमी से कहिए। अहं या जीतने की ज़िद को छोटी बात बहस में मत बदलने दीजिए।",
      ),
      health: PBi(
        "Energy is good, so use it in a walk or light exercise. Watch out for headaches and rushing, and sleep on time.",
        "ऊर्जा अच्छी रहती है, इसे सैर या हल्की कसरत में लगाइए। सिरदर्द और जल्दबाज़ी से बचिए और समय पर सोइए।",
      ),
      tip: PBi(
        "On the first day, write down one goal for the month and take one small step towards it every week.",
        "महीने की पहली तारीख़ को एक लक्ष्य लिखिए और हर हफ़्ते उसकी ओर एक छोटा कदम बढ़ाइए।",
      ),
    ),
    2: MonthDetail(
      word: PBi('patience', 'धैर्य'),
      story: PBi(
        "A quieter, softer month. Things move slowly and results come through patience, cooperation and listening. Pushing hard will not help; steady, gentle effort will.",
        "यह शांत और नरम महीना है। काम धीरे चलते हैं और नतीजे धैर्य, सहयोग और सुनने से मिलते हैं। ज़ोर लगाने से नहीं, धीमी पर लगातार कोशिश से फ़ायदा होगा।",
      ),
      work: PBi(
        "Teamwork and partnerships go well. Be ready for small delays, do not take them personally and follow up politely.",
        "टीम में काम और साझेदारी अच्छी चलती है। छोटी देरी के लिए तैयार रहिए, उसे दिल पर मत लीजिए और विनम्रता से पीछा कीजिए।",
      ),
      love: PBi(
        "Feelings are sensitive now. Listen more than you speak and show care through small gestures.",
        "भावनाएँ इस महीने नाज़ुक रहती हैं। बोलने से ज़्यादा सुनिए और छोटे-छोटे इशारों से परवाह जताइए।",
      ),
      health: PBi(
        "Stress can settle in the stomach and in sleep. Keep meals regular and give yourself some quiet time.",
        "तनाव पेट और नींद पर असर डाल सकता है। खाना नियमित रखिए और खुद को शांत समय दीजिए।",
      ),
      tip: PBi(
        "Settle one old misunderstanding with a calm conversation.",
        "कोई एक पुरानी गलतफ़हमी शांति से बात करके सुलझा लीजिए।",
      ),
    ),
    3: MonthDetail(
      word: PBi('joy and talk', 'खुशी और बातचीत'),
      story: PBi(
        "A lively, social and creative month. You speak, write and express yourself easily, and people enjoy your company. Joy comes from small things, but scattered energy can waste the month.",
        "यह जोशीला, मिलनसार और रचनात्मक महीना है। बोलना, लिखना और खुद को ज़ाहिर करना आसान रहता है और लोग आपका साथ पसंद करते हैं। खुशी छोटी बातों में मिलती है, पर बिखरी ऊर्जा महीना बर्बाद कर सकती है।",
      ),
      work: PBi(
        "Good for meetings, promotion, writing, teaching and creative work. Finish what you started before taking up something new.",
        "मीटिंग, प्रचार, लिखने, पढ़ाने और रचनात्मक काम के लिए अच्छा। नया काम पकड़ने से पहले जो शुरू किया है उसे पूरा कीजिए।",
      ),
      love: PBi(
        "Warm time with friends and family, and a happy occasion is possible. Avoid careless words and gossip.",
        "दोस्तों और परिवार के साथ अच्छा समय रहता है, कोई खुशी का मौका भी बन सकता है। लापरवाह बातों और गपशप से बचिए।",
      ),
      health: PBi(
        "Mood is high, but late nights, outside food and too much talking can tire you. Look after the throat.",
        "मन खुश रहता है, पर देर रात जागना, बाहर का खाना और बहुत ज़्यादा बोलना थका सकता है। गले का ध्यान रखिए।",
      ),
      tip: PBi(
        "Spend a little on something you enjoy, but keep a limit.",
        "अपनी पसंद की किसी चीज़ पर थोड़ा खर्च कीजिए, पर सीमा रखिए।",
      ),
    ),
    4: MonthDetail(
      word: PBi('hard work', 'मेहनत'),
      story: PBi(
        "A month of hard, steady work. Paperwork, rules, repairs and duties need attention. It can feel heavy, but what you build now stands firm for a long time.",
        "यह मेहनत और स्थिरता का महीना है। काग़ज़ी काम, नियम, मरम्मत और ज़िम्मेदारियाँ ध्यान माँगेंगी। भारी लग सकता है, पर जो आप अभी बनाएँगे वह लंबे समय तक टिकेगा।",
      ),
      work: PBi(
        "Plan, organise and finish pending files. Avoid shortcuts and risky promises; accuracy matters more than speed.",
        "योजना बनाइए, चीज़ें व्यवस्थित कीजिए और अटकी फ़ाइलें निपटाइए। शॉर्टकट और जोखिम भरे वादों से बचिए, रफ़्तार से ज़्यादा सटीकता मायने रखती है।",
      ),
      love: PBi(
        "Be dependable for your family. Do not become too strict and do not forget to show affection.",
        "परिवार के लिए भरोसेमंद बनिए। ज़्यादा सख़्त मत बनिए और प्यार जताना मत भूलिए।",
      ),
      health: PBi(
        "Back, joints and tiredness need care. Take short breaks and stretch a little every day.",
        "पीठ, जोड़ों और थकान का ख़याल रखिए। बीच-बीच में आराम कीजिए और रोज़ थोड़ा स्ट्रेच कीजिए।",
      ),
      tip: PBi(
        "Make a simple written plan with dates and tick it off every day.",
        "तारीख़ों के साथ एक सीधी लिखित योजना बनाइए और रोज़ उसमें निशान लगाइए।",
      ),
    ),
    5: MonthDetail(
      word: PBi('change and travel', 'बदलाव और सफ़र'),
      story: PBi(
        "A month of change, movement and surprises. Plans may shift, news may come suddenly and you will want freedom. Stay flexible and curious, but do not act on impulse.",
        "यह बदलाव, भागदौड़ और अचानक खबरों का महीना है। योजनाएँ बदल सकती हैं और आज़ादी की चाह बढ़ेगी। लचीले और जिज्ञासु रहिए, पर आवेश में फ़ैसला मत लीजिए।",
      ),
      work: PBi(
        "Good for travel, sales, deals and learning new things. Read every paper carefully before you sign.",
        "यात्रा, बिक्री, सौदों और कुछ नया सीखने के लिए अच्छा। दस्तख़त से पहले हर काग़ज़ ध्यान से पढ़िए।",
      ),
      love: PBi(
        "Social and exciting, but restlessness can cause misunderstandings. Keep your word and tell people when plans change.",
        "मेल-मिलाप और रोमांच रहता है, पर बेचैनी से गलतफ़हमियाँ हो सकती हैं। अपनी बात निभाइए और योजना बदलने पर लोगों को बताइए।",
      ),
      health: PBi(
        "Nerves and sleep can be unsettled. Drive carefully, avoid overeating and keep a routine even while travelling.",
        "नसों और नींद पर असर पड़ सकता है। गाड़ी सावधानी से चलाइए, ज़्यादा खाने से बचिए और सफ़र में भी दिनचर्या रखिए।",
      ),
      tip: PBi(
        "Keep one fixed hour each day for yourself so the changes do not scatter you.",
        "रोज़ का एक समय सिर्फ़ अपने लिए तय रखिए ताकि बदलाव आपको बिखेर न दें।",
      ),
    ),
    6: MonthDetail(
      word: PBi('home and love', 'घर और प्रेम'),
      story: PBi(
        "A month of home, family, love and responsibility. People may need your time and care, and you want peace and beauty around you. Give love, but do not carry everyone's burden.",
        "यह घर, परिवार, प्रेम और ज़िम्मेदारी का महीना है। लोगों को आपके समय और परवाह की ज़रूरत पड़ सकती है और आप अपने आसपास शांति और सुंदरता चाहेंगे। प्यार दीजिए, पर सबका बोझ अपने ऊपर मत लीजिए।",
      ),
      work: PBi(
        "Good for service, teaching, care work, design and agreements. Keep your promises and honour your commitments.",
        "सेवा, पढ़ाने, देखभाल, डिज़ाइन और समझौतों के काम के लिए अच्छा। वादे निभाइए और ज़िम्मेदारियों का मान रखिए।",
      ),
      love: PBi(
        "A strong month for relationships, marriage talks and family functions. Avoid over-giving and expecting the same in return.",
        "रिश्तों, विवाह की बातों और पारिवारिक आयोजनों के लिए मज़बूत महीना। ज़रूरत से ज़्यादा देने और बदले में वही उम्मीद रखने से बचिए।",
      ),
      health: PBi(
        "Take care of the heart, the throat and your diet. Simple home-cooked food suits you best.",
        "दिल, गले और खान-पान का ध्यान रखिए। घर का सादा खाना आपको सबसे ज़्यादा सूट करता है।",
      ),
      tip: PBi(
        "Make time for one family meal or outing without phones.",
        "बिना फ़ोन के एक पारिवारिक भोजन या सैर के लिए समय निकालिए।",
      ),
    ),
    7: MonthDetail(
      word: PBi('rest and thought', 'आराम और चिंतन'),
      story: PBi(
        "A quiet, inward month. You want to think, study, rest or be alone, and answers come through reflection rather than action. Big launches and loud decisions can wait.",
        "यह शांत और अंतर्मुखी महीना है। आप सोचना, पढ़ना, आराम करना या अकेले रहना चाहेंगे और जवाब कार्रवाई से नहीं, चिंतन से मिलते हैं। बड़े शुभारंभ और शोर भरे फ़ैसले टाल सकते हैं।",
      ),
      work: PBi(
        "Good for research, study, planning, writing and building skills. Do not force results or push for sales.",
        "शोध, पढ़ाई, योजना, लिखने और हुनर बढ़ाने के लिए अच्छा। नतीजों या बिक्री के लिए ज़बरदस्ती मत कीजिए।",
      ),
      love: PBi(
        "You may seem distant. Tell your loved ones you need some quiet time so they do not feel left out.",
        "आप थोड़े दूर लग सकते हैं। अपनों को बता दीजिए कि आपको कुछ शांत समय चाहिए ताकि वे अकेला महसूस न करें।",
      ),
      health: PBi(
        "Rest, sleep and a calm mind matter most. Meditation, prayer or a quiet walk helps; avoid too much overthinking.",
        "आराम, नींद और शांत मन सबसे ज़रूरी हैं। ध्यान, प्रार्थना या शांत सैर से मदद मिलती है; बहुत ज़्यादा सोचने से बचिए।",
      ),
      tip: PBi(
        "Give 20 minutes each day to silence, prayer or reading.",
        "रोज़ 20 मिनट मौन, प्रार्थना या पढ़ने को दीजिए।",
      ),
    ),
    8: MonthDetail(
      word: PBi('money and power', 'पैसा और अधिकार'),
      story: PBi(
        "A month of money, work, authority and results. Chances to earn, lead and be recognised come, and so do pressure and big responsibilities. Stay fair and practical.",
        "यह पैसे, काम, अधिकार और नतीजों का महीना है। कमाने, नेतृत्व करने और पहचान पाने के मौके आते हैं, पर दबाव और बड़ी ज़िम्मेदारियाँ भी आती हैं। निष्पक्ष और व्यावहारिक रहिए।",
      ),
      work: PBi(
        "Good for business, deals, promotions and money planning. Keep accounts clean and avoid pride or harsh behaviour with staff.",
        "व्यापार, सौदों, तरक्की और पैसे की योजना के लिए अच्छा। हिसाब साफ़ रखिए और कर्मचारियों से घमंड या कठोरता से बचिए।",
      ),
      love: PBi(
        "Work can eat into family time. Make the effort to be present, because respect at home matters as much as success.",
        "काम परिवार के समय को खा सकता है। घर पर मौजूद रहने की कोशिश कीजिए, क्योंकि घर का सम्मान भी सफलता जितना ज़रूरी है।",
      ),
      health: PBi(
        "Stress, blood pressure and tiredness from overwork need watching. Fix a time to stop working.",
        "तनाव, रक्तचाप और ज़्यादा काम की थकान पर नज़र रखिए। काम बंद करने का एक समय तय कीजिए।",
      ),
      tip: PBi(
        "Save or invest a fixed part of any income this month before you spend.",
        "इस महीने जो भी कमाई हो, खर्च से पहले उसका एक तय हिस्सा बचाइए या निवेश कीजिए।",
      ),
    ),
    9: MonthDetail(
      word: PBi('finishing and giving', 'पूरा करना और देना'),
      story: PBi(
        "A month of finishing and letting go. Old tasks, habits and sometimes relationships reach their end so that space is made for a new cycle. Be generous, forgive and clear the clutter.",
        "यह पूरा करने और छोड़ने का महीना है। पुराने काम, आदतें और कभी-कभी रिश्ते भी अपने अंत पर पहुँचते हैं ताकि नए चक्र के लिए जगह बने। उदार बनिए, माफ़ कीजिए और बेकार का बोझ हटाइए।",
      ),
      work: PBi(
        "Complete pending work, close old accounts and tie up loose ends. Avoid starting big new ventures just now.",
        "अटके काम पूरे कीजिए, पुराने हिसाब बंद कीजिए और अधूरे सिरे समेटिए। अभी कोई बड़ा नया काम शुरू करने से बचिए।",
      ),
      love: PBi(
        "Emotions can run high. Forgive old hurts and do not hold on to what is already over.",
        "भावनाएँ तेज़ हो सकती हैं। पुरानी चोटों को माफ़ कीजिए और जो बात ख़त्म हो चुकी है उसे पकड़कर मत रखिए।",
      ),
      health: PBi(
        "Cleanse gently, rest well and do not push the body. Cut down habits that drain you.",
        "शरीर को हल्के से साफ़ कीजिए, अच्छी तरह आराम कीजिए और शरीर पर ज़ोर मत डालिए। जो आदतें थकाती हैं उन्हें कम कीजिए।",
      ),
      tip: PBi(
        "Give or donate something useful and clear one cupboard or drawer of old things.",
        "कोई उपयोगी चीज़ दान कीजिए और एक अलमारी या दराज़ की पुरानी चीज़ें निकाल दीजिए।",
      ),
    ),
  };
}
