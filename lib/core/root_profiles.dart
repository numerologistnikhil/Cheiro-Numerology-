/// Deep profiles for root numbers 1-9 (English + Hindi).
///
/// These are tendencies, not guarantees. Gemstone and colour notes are
/// traditional beliefs, not medical, legal or financial advice.
class L {
  final String en;
  final String hi;
  const L(this.en, this.hi);
  String t(bool hindi) => hindi ? hi : en;
}

class RootProfile {
  final int number;
  final L title;
  final L planet;
  final L luckyDays;
  final L colours;
  final L gemstone;
  final L overview;
  final L personality;
  final L strengths;
  final L challenges;
  final L career;
  final L money;
  final L love;
  final L health;
  final L advice;

  const RootProfile({
    required this.number,
    required this.title,
    required this.planet,
    required this.luckyDays,
    required this.colours,
    required this.gemstone,
    required this.overview,
    required this.personality,
    required this.strengths,
    required this.challenges,
    required this.career,
    required this.money,
    required this.love,
    required this.health,
    required this.advice,
  });
}

class RootProfiles {
  static const String disclaimer =
      "Numerology describes tendencies and symbolism, not guaranteed outcomes. "
      "Gemstone and colour suggestions are traditional beliefs. For health, "
      "money or legal decisions, please consult a qualified professional.";
  static const String disclaimerHi =
      "अंक ज्योतिष प्रवृत्तियों और प्रतीकों को बताता है, पक्के नतीजों को नहीं। "
      "रत्न और रंग के सुझाव पारंपरिक मान्यताएँ हैं। सेहत, पैसे या कानून से जुड़े "
      "फैसलों के लिए किसी योग्य विशेषज्ञ से सलाह लें।";

  static RootProfile? of(int n) => profiles[n];

  static const Map<int, RootProfile> profiles = {
    1: RootProfile(
      number: 1,
      title: L("The Leader", "नेतृत्वकर्ता"),
      planet: L("Sun", "सूर्य"),
      luckyDays: L("Sunday, Monday", "रविवार, सोमवार"),
      colours: L("Gold, orange, warm yellow", "सुनहरा, नारंगी, गहरा पीला"),
      gemstone: L("Ruby (traditional)", "माणिक (पारंपरिक)"),
      overview: L(
        "Number 1 stands for the beginning, the self and the will to lead. It is linked with the Sun: a single centre that gives light to everything around it. People with this number often feel they are here to start things, not just follow them.",
        "अंक 1 शुरुआत, आत्म-विश्वास और नेतृत्व की इच्छा का प्रतीक है। इसका संबंध सूर्य से माना जाता है, जो अपने आप में एक केंद्र है और सबको रोशनी देता है। इस अंक के लोग अक्सर महसूस करते हैं कि वे काम शुरू करने के लिए बने हैं, सिर्फ़ किसी के पीछे चलने के लिए नहीं।",
      ),
      personality: L(
        "Confident, independent and direct. You like to decide for yourself and you dislike being told what to do. People notice you quickly, and others often look to you when a decision is needed.",
        "आप आत्मविश्वासी, स्वतंत्र और सीधी बात करने वाले होते हैं। अपने फैसले खुद लेना पसंद करते हैं और आदेश सुनना कम भाता है। लोग आपको जल्दी नोटिस करते हैं और फैसले की घड़ी में अक्सर आपकी ओर देखते हैं।",
      ),
      strengths: L(
        "Courage, originality, determination and the ability to take the first step when others hesitate. You can stay steady under pressure and inspire people with your own example.",
        "हिम्मत, मौलिकता, दृढ़ता और वह पहला कदम उठाने की क्षमता जब बाकी लोग झिझकते हैं। दबाव में भी आप स्थिर रह सकते हैं और अपने उदाहरण से दूसरों को प्रेरित करते हैं।",
      ),
      challenges: L(
        "Pride, impatience and a habit of taking control even when nobody asked. Listening to other views and sharing credit will make your leadership stronger, not weaker.",
        "अहंकार, अधीरता और बिना कहे सबकुछ अपने हाथ में ले लेने की आदत। दूसरों की बात सुनना और श्रेय बाँटना आपके नेतृत्व को कमज़ोर नहीं, बल्कि मज़बूत बनाएगा।",
      ),
      career: L(
        "Suits roles with authority and independence: business owner, manager, administrator, entrepreneur, government service, sales leadership, or any field where you can build something of your own.",
        "ऐसे काम सूट करते हैं जिनमें अधिकार और स्वतंत्रता हो: व्यवसायी, मैनेजर, प्रशासक, उद्यमी, सरकारी सेवा, सेल्स लीडरशिप या कोई भी क्षेत्र जहाँ आप अपना कुछ खड़ा कर सकें।",
      ),
      money: L(
        "Earning power is usually good, especially when you work for yourself or hold a position of responsibility. Spending on image and status can run high, so keep a fixed saving habit.",
        "कमाई की क्षमता आम तौर पर अच्छी रहती है, ख़ासकर जब आप अपना काम करें या ज़िम्मेदारी वाले पद पर हों। छवि और रुतबे पर ख़र्च बढ़ सकता है, इसलिए बचत की पक्की आदत रखें।",
      ),
      love: L(
        "Loyal and protective, but you may come across as bossy. Relationships grow when you show softness and ask for your partner's opinion before deciding.",
        "आप वफ़ादार और रक्षा करने वाले होते हैं, पर कभी-कभी रौबदार लग सकते हैं। रिश्ते तब निखरते हैं जब आप नरमी दिखाएँ और फैसले से पहले साथी की राय पूछें।",
      ),
      health: L(
        "Traditionally linked with the heart, spine, eyes and general vitality. Stress and overwork are the usual triggers; regular rest and exercise help. Use this only as a reminder to look after yourself, and see a doctor for any real concern.",
        "परंपरा में इसे हृदय, रीढ़, आँखों और सामान्य ऊर्जा से जोड़ा जाता है। तनाव और ज़्यादा काम आम कारण होते हैं; नियमित आराम और व्यायाम मदद करते हैं। इसे सिर्फ़ ख़्याल रखने की याद समझें और कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Lead with service, not ego. Start early in the day, keep one clear goal, and let your confidence be quiet and steady.",
        "अहं से नहीं, सेवा की भावना से नेतृत्व करें। दिन की शुरुआत जल्दी करें, एक साफ़ लक्ष्य रखें और अपने आत्मविश्वास को शांत और स्थिर रखें।",
      ),
    ),
    2: RootProfile(
      number: 2,
      title: L("The Peacemaker", "शांतिदूत"),
      planet: L("Moon", "चंद्रमा"),
      luckyDays: L("Monday, Sunday", "सोमवार, रविवार"),
      colours: L("White, cream, light green, silver", "सफ़ेद, क्रीम, हल्का हरा, चाँदी जैसा"),
      gemstone: L("Pearl (traditional)", "मोती (पारंपरिक)"),
      overview: L(
        "Number 2 stands for partnership, balance and feeling. It is linked with the Moon, which changes phase and moves tides. People with this number read moods well and often hold groups together quietly.",
        "अंक 2 साझेदारी, संतुलन और भावना का प्रतीक है। इसका संबंध चंद्रमा से माना जाता है, जो घटता-बढ़ता है और ज्वार को खींचता है। इस अंक के लोग मूड को अच्छी तरह पढ़ते हैं और अक्सर चुपचाप समूह को जोड़े रखते हैं।",
      ),
      personality: L(
        "Gentle, imaginative and sensitive. You notice small things in people and places. You prefer harmony to conflict, and you may think deeply before speaking.",
        "आप कोमल, कल्पनाशील और संवेदनशील होते हैं। लोगों और जगहों की छोटी बातें भी आपकी नज़र में आती हैं। टकराव से ज़्यादा सामंजस्य पसंद है और बोलने से पहले आप गहराई से सोचते हैं।",
      ),
      strengths: L(
        "Diplomacy, patience, intuition and the gift of listening. You are good at teamwork, counselling and creative work where feeling matters.",
        "कूटनीति, धैर्य, अंतर्ज्ञान और सुनने की कला। टीमवर्क, काउंसलिंग और ऐसे रचनात्मक काम में आप अच्छे होते हैं जहाँ भावना की अहमियत हो।",
      ),
      challenges: L(
        "Mood swings, over-sensitivity and difficulty saying no. You may absorb other people's worries. Learn to set limits and decide without waiting for everyone to agree.",
        "मूड का उतार-चढ़ाव, ज़्यादा संवेदनशीलता और ना कहने में कठिनाई। आप दूसरों की चिंताएँ अपने ऊपर ले सकते हैं। सीमाएँ तय करना और सबकी सहमति का इंतज़ार किए बिना फैसला लेना सीखें।",
      ),
      career: L(
        "Suits teaching, counselling, hospitality, arts, writing, design, nursing, public relations and partnership-based work. You often shine as the second-in-command who makes the leader better.",
        "शिक्षण, काउंसलिंग, होटल-सेवा, कला, लेखन, डिज़ाइन, नर्सिंग, जनसंपर्क और साझेदारी वाले काम सूट करते हैं। आप अक्सर उस सहयोगी के रूप में चमकते हैं जो लीडर को बेहतर बनाता है।",
      ),
      money: L(
        "Income tends to come through steady work and good relationships rather than big risks. Avoid emotional spending and lending money only because someone asked kindly.",
        "आमदनी आम तौर पर बड़े जोखिम से नहीं, बल्कि स्थिर काम और अच्छे संबंधों से आती है। भावुकता में ख़र्च करने से और सिर्फ़ किसी के प्यार से माँगने पर उधार देने से बचें।",
      ),
      love: L(
        "Caring, romantic and loyal. You give a lot in relationships, so make sure your own needs are also spoken aloud and not left for the other person to guess.",
        "आप स्नेही, रोमांटिक और वफ़ादार होते हैं। रिश्तों में बहुत कुछ देते हैं, इसलिए अपनी ज़रूरतें भी साफ़ बोलें, साथी के अंदाज़े पर न छोड़ें।",
      ),
      health: L(
        "Traditionally linked with emotions, sleep, digestion and fluid balance. Calm routines, enough sleep and time near water or nature are supportive. See a doctor for any real health concern.",
        "परंपरा में इसे भावनाओं, नींद, पाचन और शरीर में तरल संतुलन से जोड़ा जाता है। शांत दिनचर्या, पूरी नींद और प्रकृति या पानी के पास समय बिताना सहायक है। कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Trust your intuition, but back it with facts. Protect your peace, keep a regular routine and speak up early instead of keeping hurt inside.",
        "अपने अंतर्ज्ञान पर भरोसा करें, पर तथ्यों से उसकी पुष्टि भी करें। अपनी शांति की रक्षा करें, नियमित दिनचर्या रखें और चोट को मन में दबाने की जगह जल्दी बोल दें।",
      ),
    ),
    3: RootProfile(
      number: 3,
      title: L("The Communicator", "अभिव्यक्ति के धनी"),
      planet: L("Jupiter", "बृहस्पति"),
      luckyDays: L("Thursday, Tuesday, Friday", "गुरुवार, मंगलवार, शुक्रवार"),
      colours: L("Yellow, saffron, violet", "पीला, केसरिया, बैंगनी"),
      gemstone: L("Yellow sapphire (traditional)", "पुखराज (पारंपरिक)"),
      overview: L(
        "Number 3 stands for expression, growth and wisdom. It is linked with Jupiter, the planet of teachers and expansion. People with this number often carry a natural wish to teach, speak, guide or create.",
        "अंक 3 अभिव्यक्ति, विकास और ज्ञान का प्रतीक है। इसका संबंध बृहस्पति से माना जाता है, जो गुरु और विस्तार का ग्रह है। इस अंक के लोगों में सिखाने, बोलने, मार्ग दिखाने या कुछ रचने की स्वाभाविक इच्छा होती है।",
      ),
      personality: L(
        "Optimistic, social and witty. You like learning and sharing what you learn. You have a sense of dignity and principle and prefer to do things in a respectable way.",
        "आप आशावादी, मिलनसार और हाज़िरजवाब होते हैं। सीखना और जो सीखा उसे बाँटना आपको पसंद है। आपमें गरिमा और सिद्धांत की भावना होती है और आप काम सम्मानजनक ढंग से करना चाहते हैं।",
      ),
      strengths: L(
        "Communication, teaching, creativity, planning and a positive outlook that lifts a room. You are good at seeing the bigger picture and explaining it simply.",
        "संवाद, शिक्षण, रचनात्मकता, योजना बनाना और ऐसा सकारात्मक नज़रिया जो पूरे माहौल को हल्का कर दे। आप बड़ी तस्वीर देखने और उसे आसान भाषा में समझाने में माहिर हैं।",
      ),
      challenges: L(
        "Scattering energy over too many interests, giving advice nobody asked for, and over-spending when in a good mood. Finish what you start before adding new projects.",
        "बहुत सारी रुचियों में ऊर्जा बिखेर देना, बिन माँगे सलाह देना और अच्छे मूड में ज़्यादा ख़र्च कर देना। नया प्रोजेक्ट जोड़ने से पहले शुरू किया हुआ काम पूरा करें।",
      ),
      career: L(
        "Suits teaching, law, writing, speaking, advisory work, media, banking, religious or social leadership and creative direction.",
        "शिक्षण, कानून, लेखन, वक्तृत्व, सलाहकार का काम, मीडिया, बैंकिंग, धार्मिक या सामाजिक नेतृत्व और क्रिएटिव डायरेक्शन में यह अंक अच्छा माना जाता है।",
      ),
      money: L(
        "Money often grows through knowledge, advice and good contacts. Plan your budget in writing and avoid lending or guaranteeing loans for others.",
        "ज्ञान, सलाह और अच्छे संपर्कों से धन बढ़ता है। बजट लिखकर बनाएँ और दूसरों के लिए उधार देने या गारंटी देने से बचें।",
      ),
      love: L(
        "Warm, generous and respectful. You want a partner you can talk to for hours. Avoid lecturing in close relationships; listening builds more trust than advice.",
        "आप गर्मजोशी वाले, उदार और सम्मान देने वाले होते हैं। आपको ऐसा साथी चाहिए जिससे घंटों बात हो सके। नज़दीकी रिश्तों में भाषण देने से बचें; सलाह से ज़्यादा सुनना भरोसा बनाता है।",
      ),
      health: L(
        "Traditionally linked with liver, weight, thighs and blood sugar balance. Moderation in food and sweets is the usual reminder. See a doctor for any real health concern.",
        "परंपरा में इसे लिवर, वज़न, जाँघों और शुगर संतुलन से जोड़ा जाता है। खाने और मिठाई में संयम आम सलाह है। कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Keep learning, and practise what you teach. Choose depth over variety and give your good ideas a fixed schedule.",
        "सीखते रहें और जो सिखाते हैं उसे ख़ुद भी अपनाएँ। विविधता से ज़्यादा गहराई चुनें और अपने अच्छे विचारों को तय समय-सारिणी दें।",
      ),
    ),
    4: RootProfile(
      number: 4,
      title: L("The Builder", "निर्माता"),
      planet: L("Rahu (Indian system) / Uranus (Western)", "राहु (भारतीय पद्धति) / यूरेनस (पश्चिमी)"),
      luckyDays: L("Saturday, Sunday, Monday", "शनिवार, रविवार, सोमवार"),
      colours: L("Blue, grey, earthy shades", "नीला, स्लेटी, मिट्टी के रंग"),
      gemstone: L("Hessonite / Gomed (traditional)", "गोमेद (पारंपरिक)"),
      overview: L(
        "Number 4 stands for structure, rules and unconventional thinking. It is often described as the number of the builder who works hard, and sometimes the rebel who questions the system.",
        "अंक 4 ढाँचे, नियम और हटकर सोच का प्रतीक है। इसे अक्सर उस निर्माता का अंक कहा जाता है जो कड़ी मेहनत करता है, और कभी-कभी उस विद्रोही का जो व्यवस्था पर सवाल उठाता है।",
      ),
      personality: L(
        "Practical, disciplined and loyal, with a strong sense of duty. You like clear plans and honest work. Inside, you may feel misunderstood and carry a stubborn streak.",
        "आप व्यावहारिक, अनुशासित और वफ़ादार होते हैं और कर्तव्य का भाव मज़बूत होता है। साफ़ योजनाएँ और ईमानदार काम पसंद हैं। भीतर से कभी ग़लत समझे जाने का एहसास और ज़िद भी रह सकती है।",
      ),
      strengths: L(
        "Hard work, reliability, attention to detail, technical skill and the patience to build slowly. You are the person who turns an idea into something that stands.",
        "कड़ी मेहनत, भरोसेमंद होना, बारीकी पर ध्यान, तकनीकी कौशल और धीरे-धीरे निर्माण करने का धैर्य। आप वे हैं जो विचार को ठोस रूप देकर खड़ा कर देते हैं।",
      ),
      challenges: L(
        "Rigidity, worry, sudden mood changes and a feeling that effort is not always rewarded. Allow flexibility and rest, and share your thoughts with trusted people.",
        "अड़ियलपन, चिंता, अचानक मूड बदलना और यह लगना कि मेहनत का फल हमेशा नहीं मिलता। लचीलापन और आराम को जगह दें और भरोसेमंद लोगों से अपनी बात साझा करें।",
      ),
      career: L(
        "Suits engineering, construction, technology, accounting, research, property, administration, law-and-order roles and any field built on systems and process.",
        "इंजीनियरिंग, निर्माण, तकनीक, अकाउंटिंग, शोध, प्रॉपर्टी, प्रशासन, क़ानून-व्यवस्था और सिस्टम व प्रक्रिया पर टिके हर क्षेत्र में यह अंक अच्छा माना जाता है।",
      ),
      money: L(
        "Steady, earned income is more typical than sudden gains. Be careful with shortcuts, speculation and unclear paperwork. Slow saving works best for you.",
        "अचानक लाभ से ज़्यादा मेहनत की स्थिर कमाई आम है। शॉर्टकट, सट्टे और अस्पष्ट काग़ज़ात से सावधान रहें। धीरे-धीरे बचत आपके लिए सबसे अच्छी है।",
      ),
      love: L(
        "Faithful and dependable, though not always expressive. Say the caring words out loud and plan small surprises; your partner will value them greatly.",
        "आप वफ़ादार और भरोसेमंद होते हैं, पर हमेशा जताते नहीं। स्नेह के शब्द बोलकर कहें और छोटे सरप्राइज़ प्लान करें; साथी इन्हें बहुत मानेगा।",
      ),
      health: L(
        "Traditionally linked with nerves, joints, posture and stress-related tension. Regular movement, stretching and enough sleep help. See a doctor for any real health concern.",
        "परंपरा में इसे नसों, जोड़ों, बैठने-उठने की मुद्रा और तनाव से जुड़े खिंचाव से जोड़ा जाता है। नियमित चलना-फिरना, स्ट्रेचिंग और पूरी नींद मदद करती है। कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Build step by step, keep your records clean and avoid shortcuts. Stay open to new methods, and do not let worry decide for you.",
        "कदम-दर-कदम निर्माण करें, अपने रिकॉर्ड साफ़ रखें और शॉर्टकट से बचें। नए तरीक़ों के लिए खुले रहें और चिंता को अपने फैसले न करने दें।",
      ),
    ),
    5: RootProfile(
      number: 5,
      title: L("The Explorer", "खोजी"),
      planet: L("Mercury", "बुध"),
      luckyDays: L("Wednesday, Friday", "बुधवार, शुक्रवार"),
      colours: L("Green, light grey, white", "हरा, हल्का स्लेटी, सफ़ेद"),
      gemstone: L("Emerald (traditional)", "पन्ना (पारंपरिक)"),
      overview: L(
        "Number 5 stands for movement, curiosity and quick thinking. It is linked with Mercury, the planet of trade and communication. People with this number often love variety and change.",
        "अंक 5 गति, जिज्ञासा और तेज़ सोच का प्रतीक है। इसका संबंध बुध से माना जाता है, जो व्यापार और संवाद का ग्रह है। इस अंक के लोगों को अक्सर विविधता और बदलाव पसंद होता है।",
      ),
      personality: L(
        "Quick, curious, adaptable and charming. You pick up new ideas fast and make friends easily. A routine that never changes can feel heavy to you.",
        "आप तेज़, जिज्ञासु, अनुकूलनशील और आकर्षक होते हैं। नए विचार जल्दी पकड़ लेते हैं और दोस्त आसानी से बनाते हैं। कभी न बदलने वाली दिनचर्या आपको बोझिल लग सकती है।",
      ),
      strengths: L(
        "Business sense, communication, learning speed, humour and the ability to handle change calmly. You can explain, sell and negotiate well.",
        "व्यापारिक समझ, संवाद, सीखने की गति, हास्य और बदलाव को शांति से सँभालने की क्षमता। आप समझाने, बेचने और बातचीत करने में अच्छे होते हैं।",
      ),
      challenges: L(
        "Restlessness, nervous energy, impatience and starting more than you finish. Keep a simple daily structure so your freedom does not turn into scatter.",
        "बेचैनी, घबराहट भरी ऊर्जा, अधीरता और जितना पूरा करें उससे ज़्यादा शुरू कर देना। रोज़ का एक सरल ढाँचा रखें ताकि आपकी आज़ादी बिखराव न बन जाए।",
      ),
      career: L(
        "Suits business, trading, sales, marketing, media, travel, technology, writing, accounting and any work with people and movement.",
        "व्यवसाय, ट्रेडिंग, सेल्स, मार्केटिंग, मीडिया, यात्रा, तकनीक, लेखन, अकाउंटिंग और लोगों व गतिशीलता वाले हर काम में यह अंक अच्छा माना जाता है।",
      ),
      money: L(
        "Money can come from several sources and through quick thinking. Because income can be uneven, set aside a fixed part first and avoid risky quick-profit offers.",
        "पैसा कई स्रोतों से और तेज़ सोच से आ सकता है। आमदनी ऊपर-नीचे हो सकती है, इसलिए पहले एक तय हिस्सा अलग रखें और जल्दी मुनाफ़े वाले जोखिम भरे प्रस्तावों से बचें।",
      ),
      love: L(
        "Playful, lively and attractive, but you need freedom and fun. Be clear about your commitments, and give your partner your full attention at times.",
        "आप खिलंदड़, जीवंत और आकर्षक होते हैं, पर आपको आज़ादी और मज़ा चाहिए। अपनी प्रतिबद्धताओं के बारे में साफ़ रहें और कभी-कभी साथी को पूरा ध्यान दें।",
      ),
      health: L(
        "Traditionally linked with the nervous system, skin, throat and lungs. Calm breathing, regular sleep and less screen time are supportive. See a doctor for any real health concern.",
        "परंपरा में इसे नर्वस सिस्टम, त्वचा, गले और फेफड़ों से जोड़ा जाता है। शांत साँसें, नियमित नींद और कम स्क्रीन टाइम सहायक हैं। कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Use your speed for good decisions, not hasty ones. Travel, learn and talk, but come home to a steady base.",
        "अपनी तेज़ी का इस्तेमाल अच्छे फैसलों के लिए करें, जल्दबाज़ी के लिए नहीं। घूमें, सीखें और बात करें, पर लौटकर एक स्थिर ठिकाना रखें।",
      ),
    ),
    6: RootProfile(
      number: 6,
      title: L("The Nurturer", "पालनकर्ता"),
      planet: L("Venus", "शुक्र"),
      luckyDays: L("Friday, Wednesday", "शुक्रवार, बुधवार"),
      colours: L("White, pink, light blue, pastel shades", "सफ़ेद, गुलाबी, हल्का नीला, पेस्टल रंग"),
      gemstone: L("Diamond or white sapphire (traditional)", "हीरा या सफ़ेद पुखराज (पारंपरिक)"),
      overview: L(
        "Number 6 stands for love, beauty and responsibility. It is linked with Venus, the planet of harmony and art. People with this number often make a home, a family or a circle of care wherever they go.",
        "अंक 6 प्रेम, सौंदर्य और ज़िम्मेदारी का प्रतीक है। इसका संबंध शुक्र से माना जाता है, जो सामंजस्य और कला का ग्रह है। इस अंक के लोग जहाँ भी जाएँ, घर, परिवार या अपनेपन का दायरा बना लेते हैं।",
      ),
      personality: L(
        "Warm, artistic and family-minded. You like comfort, beauty and good company. People trust you with their problems because you care and you give your time.",
        "आप गर्मजोशी वाले, कलात्मक और परिवार से जुड़े होते हैं। आराम, सुंदरता और अच्छी संगत पसंद है। लोग आप पर अपनी समस्याएँ सौंप देते हैं क्योंकि आप परवाह करते हैं और समय देते हैं।",
      ),
      strengths: L(
        "Care, creativity, a sense of beauty, hospitality and the ability to bring people together. You are dependable in family and community matters.",
        "परवाह, रचनात्मकता, सौंदर्य-बोध, मेहमाननवाज़ी और लोगों को जोड़ने की क्षमता। परिवार और समाज के मामलों में आप भरोसेमंद होते हैं।",
      ),
      challenges: L(
        "Over-giving, worrying about others, jealousy or a love of luxury that stretches the budget. Care for yourself too and let others carry their share.",
        "ज़रूरत से ज़्यादा देना, दूसरों की चिंता करना, ईर्ष्या या ऐसी विलासिता-प्रियता जो बजट खींच दे। अपना ध्यान भी रखें और दूसरों को उनका हिस्सा उठाने दें।",
      ),
      career: L(
        "Suits arts, design, fashion, hospitality, beauty, healthcare, teaching, counselling, entertainment and family business.",
        "कला, डिज़ाइन, फ़ैशन, मेहमाननवाज़ी, ब्यूटी, स्वास्थ्य सेवा, शिक्षण, काउंसलिंग, मनोरंजन और पारिवारिक व्यवसाय में यह अंक अच्छा माना जाता है।",
      ),
      money: L(
        "Income often comes through creativity, service and people. Comfort spending can be high, so keep a monthly budget and an emergency fund.",
        "आमदनी अक्सर रचनात्मकता, सेवा और लोगों से आती है। आराम पर ख़र्च ज़्यादा हो सकता है, इसलिए मासिक बजट और इमरजेंसी फ़ंड रखें।",
      ),
      love: L(
        "Devoted and romantic; relationships are central to your life. Avoid possessiveness and expecting the same level of giving from everyone.",
        "आप समर्पित और रोमांटिक होते हैं; रिश्ते आपके जीवन का केंद्र हैं। अधिकार जताने से और हर किसी से उतने ही देने की उम्मीद रखने से बचें।",
      ),
      health: L(
        "Traditionally linked with throat, kidneys, skin and the reproductive system. Balanced food, hydration and relaxation are supportive. See a doctor for any real health concern.",
        "परंपरा में इसे गले, गुर्दों, त्वचा और प्रजनन तंत्र से जोड़ा जाता है। संतुलित भोजन, पर्याप्त पानी और विश्राम सहायक हैं। कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Give with love, but keep clear limits. Make beauty and order part of your day, and look after your own needs first at times.",
        "प्यार से दें, पर साफ़ सीमाएँ रखें। सुंदरता और व्यवस्था को अपने दिन का हिस्सा बनाएँ और कभी-कभी अपनी ज़रूरतों को पहले रखें।",
      ),
    ),
    7: RootProfile(
      number: 7,
      title: L("The Seeker", "साधक"),
      planet: L("Ketu (Indian system) / Neptune (Western)", "केतु (भारतीय पद्धति) / नेप्च्यून (पश्चिमी)"),
      luckyDays: L("Monday, Sunday", "सोमवार, रविवार"),
      colours: L("White, light green, pale yellow", "सफ़ेद, हल्का हरा, हल्का पीला"),
      gemstone: L("Cat's eye (traditional)", "लहसुनिया (पारंपरिक)"),
      overview: L(
        "Number 7 stands for inner search, analysis and spiritual interest. It is often described as the number of the thinker who needs quiet to understand life.",
        "अंक 7 भीतर की खोज, विश्लेषण और आध्यात्मिक रुचि का प्रतीक है। इसे अक्सर उस विचारक का अंक कहा जाता है जिसे जीवन समझने के लिए एकांत चाहिए।",
      ),
      personality: L(
        "Thoughtful, private and deep. You prefer a few real friends to a big crowd, and you need time alone to recharge. People may see you as mysterious or distant.",
        "आप विचारशील, निजी और गहरे होते हैं। भीड़ की जगह कुछ सच्चे दोस्त पसंद हैं और ऊर्जा पाने के लिए अकेला समय चाहिए। लोग आपको रहस्यमयी या दूर-दूर रहने वाला समझ सकते हैं।",
      ),
      strengths: L(
        "Research, analysis, intuition, focus and the ability to look beneath the surface. You are good at subjects that need study, patience and independent thinking.",
        "शोध, विश्लेषण, अंतर्ज्ञान, एकाग्रता और सतह के नीचे देखने की क्षमता। जिन विषयों में अध्ययन, धैर्य और स्वतंत्र सोच चाहिए, उनमें आप अच्छे होते हैं।",
      ),
      challenges: L(
        "Withdrawing, over-thinking, doubt and difficulty sharing feelings. Make time for people, and try to turn insight into action instead of staying in the mind.",
        "अपने में सिमट जाना, ज़्यादा सोचना, शक और भावनाएँ साझा करने में कठिनाई। लोगों के लिए समय निकालें और अंतर्दृष्टि को केवल मन में रखने की जगह कर्म में बदलें।",
      ),
      career: L(
        "Suits research, science, technology, philosophy, spirituality, writing, analysis, medicine, investigation and specialist or advisory work.",
        "शोध, विज्ञान, तकनीक, दर्शन, अध्यात्म, लेखन, विश्लेषण, चिकित्सा, जाँच-पड़ताल और विशेषज्ञ या सलाहकार के काम में यह अंक अच्छा माना जाता है।",
      ),
      money: L(
        "Money tends to follow expertise rather than chasing it. Keep finances simple and documented, and avoid decisions made in a mood of doubt or sudden impulse.",
        "पैसा पीछे भागने से नहीं, विशेषज्ञता से आता है। वित्त को सरल और दस्तावेज़ों में रखें और शक या अचानक आवेग में फैसले न लें।",
      ),
      love: L(
        "Loyal but reserved. A partner who respects your silence and shares your curiosity suits you well. Try to say what you feel instead of expecting to be understood without words.",
        "आप वफ़ादार पर संकोची होते हैं। ऐसा साथी जो आपकी चुप्पी का सम्मान करे और आपकी जिज्ञासा साझा करे, आपके लिए अच्छा है। जो महसूस करते हैं उसे कहें, बिना शब्दों के समझे जाने की उम्मीद न रखें।",
      ),
      health: L(
        "Traditionally linked with nerves, sleep, digestion and the mind. Quiet time, meditation, a walk in nature and a regular sleep schedule are supportive. See a doctor for any real health concern.",
        "परंपरा में इसे नसों, नींद, पाचन और मन से जोड़ा जाता है। शांत समय, ध्यान, प्रकृति में सैर और नियमित नींद सहायक हैं। कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Protect your quiet time but stay connected. Study deeply, trust your intuition, and balance thinking with simple action each day.",
        "अपने एकांत की रक्षा करें पर लोगों से जुड़े रहें। गहराई से अध्ययन करें, अंतर्ज्ञान पर भरोसा रखें और रोज़ सोच के साथ एक सरल कर्म भी जोड़ें।",
      ),
    ),
    8: RootProfile(
      number: 8,
      title: L("The Achiever", "कर्मयोगी"),
      planet: L("Saturn", "शनि"),
      luckyDays: L("Saturday, Wednesday, Friday", "शनिवार, बुधवार, शुक्रवार"),
      colours: L("Dark blue, black, deep grey", "गहरा नीला, काला, गहरा स्लेटी"),
      gemstone: L("Blue sapphire (traditional, use with great care)", "नीलम (पारंपरिक, बहुत सावधानी से)"),
      overview: L(
        "Number 8 stands for discipline, responsibility and results earned through time. It is linked with Saturn, the planet of karma and lessons. Life often asks this number for patience first and rewards afterwards.",
        "अंक 8 अनुशासन, ज़िम्मेदारी और समय के साथ मिलने वाले परिणामों का प्रतीक है। इसका संबंध शनि से माना जाता है, जो कर्म और सबक़ का ग्रह है। जीवन अक्सर इस अंक से पहले धैर्य माँगता है और बाद में फल देता है।",
      ),
      personality: L(
        "Serious, determined and responsible. You think in the long term and carry a strong sense of justice. You may look stern, but you are often deeply loyal.",
        "आप गंभीर, दृढ़ और ज़िम्मेदार होते हैं। लंबे समय की सोचते हैं और न्याय की भावना मज़बूत होती है। आप कठोर दिख सकते हैं, पर अक्सर बहुत वफ़ादार होते हैं।",
      ),
      strengths: L(
        "Endurance, organisation, financial sense, authority and the ability to keep going when others quit. You can manage people, money and large responsibilities.",
        "सहनशक्ति, संगठन क्षमता, वित्तीय समझ, अधिकार और दूसरों के छोड़ देने पर भी डटे रहने की ताक़त। आप लोगों, पैसे और बड़ी ज़िम्मेदारियों को सँभाल सकते हैं।",
      ),
      challenges: L(
        "Delays, heavy workload, rigidity, loneliness and being too hard on yourself. Celebrate small wins, delegate, and let people see your softer side.",
        "देरी, भारी काम का बोझ, कठोरता, अकेलापन और ख़ुद पर ज़्यादा सख़्ती। छोटी जीत का जश्न मनाएँ, काम बाँटें और लोगों को अपना नरम पक्ष भी दिखाएँ।",
      ),
      career: L(
        "Suits business management, finance, banking, real estate, law, administration, industry, politics and any long-term, high-responsibility role.",
        "बिज़नेस मैनेजमेंट, वित्त, बैंकिंग, रियल एस्टेट, क़ानून, प्रशासन, उद्योग, राजनीति और हर लंबे समय वाले ज़िम्मेदारी भरे काम में यह अंक अच्छा माना जाता है।",
      ),
      money: L(
        "Wealth is usually built slowly and steadily; success often improves with age. Keep honest accounts, avoid shortcuts and treat people fairly in money matters.",
        "धन आम तौर पर धीरे और स्थिर ढंग से बनता है; सफलता अक्सर उम्र के साथ बढ़ती है। हिसाब ईमानदार रखें, शॉर्टकट से बचें और पैसे के मामलों में लोगों से न्यायपूर्ण व्यवहार करें।",
      ),
      love: L(
        "Committed and protective, though not very expressive. Show your care through small daily actions and kind words, not only through providing.",
        "आप प्रतिबद्ध और रक्षक होते हैं, पर बहुत जताते नहीं। अपनी परवाह सिर्फ़ ज़रूरतें पूरी करके नहीं, छोटे रोज़ के कामों और मीठे शब्दों से भी दिखाएँ।",
      ),
      health: L(
        "Traditionally linked with bones, joints, teeth, knees and tiredness from overwork. Rest, warmth, calcium-rich food and gentle exercise are supportive. See a doctor for any real health concern.",
        "परंपरा में इसे हड्डियों, जोड़ों, दाँतों, घुटनों और ज़्यादा काम की थकान से जोड़ा जाता है। आराम, गर्माहट, कैल्शियम वाला भोजन और हल्का व्यायाम सहायक हैं। कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Stay patient, honest and consistent. Serve others with your strength, and remember that rest and warmth are also part of discipline.",
        "धैर्यवान, ईमानदार और निरंतर रहें। अपनी ताक़त से दूसरों की सेवा करें और याद रखें कि आराम और अपनापन भी अनुशासन का हिस्सा हैं।",
      ),
    ),
    9: RootProfile(
      number: 9,
      title: L("The Humanitarian", "परोपकारी योद्धा"),
      planet: L("Mars", "मंगल"),
      luckyDays: L("Tuesday, Thursday, Sunday", "मंगलवार, गुरुवार, रविवार"),
      colours: L("Red, maroon, coral", "लाल, मैरून, मूँगिया"),
      gemstone: L("Red coral (traditional)", "मूँगा (पारंपरिक)"),
      overview: L(
        "Number 9 stands for courage, energy and completion. It is linked with Mars, the planet of action. It is also the last single digit, so it carries a feeling of finishing, giving and serving a larger cause.",
        "अंक 9 साहस, ऊर्जा और पूर्णता का प्रतीक है। इसका संबंध मंगल से माना जाता है, जो कर्म का ग्रह है। यह अंतिम एकल अंक भी है, इसलिए इसमें पूरा करने, देने और किसी बड़े उद्देश्य की सेवा करने का भाव रहता है।",
      ),
      personality: L(
        "Energetic, brave, passionate and generous. You defend people you care about and dislike unfairness. Your temper can flare quickly, but it also cools quickly.",
        "आप ऊर्जावान, बहादुर, जोशीले और उदार होते हैं। जिनकी परवाह करते हैं उनकी रक्षा करते हैं और अन्याय आपको खटकता है। ग़ुस्सा जल्दी भड़क सकता है, पर जल्दी ठंडा भी हो जाता है।",
      ),
      strengths: L(
        "Courage, drive, leadership in a cause, generosity and the ability to act fast in a crisis. You inspire others to give their best.",
        "साहस, जोश, किसी उद्देश्य के लिए नेतृत्व, उदारता और संकट में तेज़ी से कदम उठाने की क्षमता। आप दूसरों को अपना सर्वश्रेष्ठ देने के लिए प्रेरित करते हैं।",
      ),
      challenges: L(
        "Anger, impatience, arguments and taking on too many fights. Pause before reacting, channel energy into sport or service, and let go of old grudges.",
        "ग़ुस्सा, अधीरता, बहस और बहुत सारी लड़ाइयाँ ओढ़ लेना। प्रतिक्रिया से पहले रुकें, ऊर्जा को खेल या सेवा में लगाएँ और पुराने गिले-शिकवे छोड़ दें।",
      ),
      career: L(
        "Suits defence and police services, sports, surgery and medicine, engineering, property, social work, activism and leadership roles that need action.",
        "रक्षा और पुलिस सेवाएँ, खेल, सर्जरी और चिकित्सा, इंजीनियरिंग, प्रॉपर्टी, समाज सेवा, सक्रियता और कर्म वाले नेतृत्व के कामों में यह अंक अच्छा माना जाता है।",
      ),
      money: L(
        "Earning is often good through effort and bold action. Spending can be generous and sudden, so avoid impulsive investments and arguments over money.",
        "मेहनत और साहसिक कदम से कमाई अक्सर अच्छी रहती है। ख़र्च उदार और अचानक हो सकता है, इसलिए आवेग में निवेश और पैसे को लेकर बहस से बचें।",
      ),
      love: L(
        "Passionate, protective and loyal. Disagreements may flare up, so practise listening and apologising early. Your warmth is your strength in close relationships.",
        "आप जोशीले, रक्षक और वफ़ादार होते हैं। मतभेद भड़क सकते हैं, इसलिए सुनने और जल्दी माफ़ी माँगने का अभ्यास करें। नज़दीकी रिश्तों में आपकी गर्मजोशी ही आपकी ताक़त है।",
      ),
      health: L(
        "Traditionally linked with blood pressure, heat in the body, injuries and headaches. Regular exercise, cooling food and anger management are supportive. See a doctor for any real health concern.",
        "परंपरा में इसे ब्लड प्रेशर, शरीर की गर्मी, चोटों और सिरदर्द से जोड़ा जाता है। नियमित व्यायाम, ठंडक वाला भोजन और ग़ुस्से पर नियंत्रण सहायक हैं। कोई समस्या हो तो डॉक्टर को दिखाएँ।",
      ),
      advice: L(
        "Turn your fire into service. Exercise daily, pause before speaking in anger, and finish old chapters so you can start fresh ones.",
        "अपनी आग को सेवा में बदलें। रोज़ व्यायाम करें, ग़ुस्से में बोलने से पहले रुकें और पुराने अध्याय पूरे करें ताकि नए शुरू कर सकें।",
      ),
    ),
  };
}
