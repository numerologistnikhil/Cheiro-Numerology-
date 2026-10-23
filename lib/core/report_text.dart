import 'root_profiles.dart';

/// Simple-language texts for the new story style report (English + Hindi).
/// These are friendly tendencies and traditional beliefs, not promises.

class YearStory {
  final L title;
  final L story;
  final L doThis;
  final L avoid;
  const YearStory({
    required this.title,
    required this.story,
    required this.doThis,
    required this.avoid,
  });
}

class YearAreas {
  final L work;
  final L money;
  final L love;
  const YearAreas({required this.work, required this.money, required this.love});
}

class Habit {
  final L habit;
  final L daan;
  final L avoid;
  const Habit({required this.habit, required this.daan, required this.avoid});
}

class ReportText {
  ReportText._();

  static const L reportTitle =
      L("Your Number Report", "आपकी अंक रिपोर्ट");
  static const L bornOn = L("Born on", "जन्म तिथि");
  static const L preparedOn = L("Prepared on", "रिपोर्ट की तारीख़");

  static const L howTitle =
      L("How to read this report", "इस रिपोर्ट को कैसे पढ़ें");
  static const L howBody = L(
    "Numbers are an old way of understanding a person's nature. Think of "
        "this report as a friendly mirror, not a fixed fate. Read it slowly, "
        "one part a day if you like. Take what feels true, try the small "
        "suggestions, and leave the rest. Your effort always matters more "
        "than any number.",
    "अंक-ज्योतिष इंसान के स्वभाव को समझने का एक पुराना तरीका है। इस रिपोर्ट "
        "को एक दोस्ताना आईना समझिए, पक्का भाग्य नहीं। इसे आराम से पढ़िए, चाहें "
        "तो रोज़ एक हिस्सा। जो बात आपको सही लगे उसे अपनाइए, छोटे सुझाव आज़माइए "
        "और बाकी छोड़ दीजिए। आपकी मेहनत हर अंक से ज़्यादा मायने रखती है।",
  );

  static const L coreTitle =
      L("Your two main numbers", "आपके दो मुख्य अंक");
  static const L psychicName =
      L("Your Birth Number (Mulank)", "आपका मूलांक (जन्म अंक)");
  static const L psychicWhat = L(
    "This comes from the day of the month you were born. It shows how you "
        "are inside: your nature, your habits, and how you feel and react.",
    "यह आपकी जन्म तारीख़ से बनता है। यह बताता है कि आप अंदर से कैसे हैं: "
        "आपका स्वभाव, आदतें और आप चीज़ों पर कैसे प्रतिक्रिया करते हैं।",
  );
  static const L destinyName =
      L("Your Life Path Number (Bhagyank)", "आपका भाग्यांक (जीवन-पथ अंक)");
  static const L destinyWhat = L(
    "This comes from your full date of birth. It shows the road that life "
        "keeps nudging you towards: your lessons, your work and your bigger "
        "goals.",
    "यह आपकी पूरी जन्म तिथि से बनता है। यह बताता है कि ज़िंदगी आपको किस "
        "राह की ओर ले जाती है: आपके सबक, आपका काम और आपके बड़े लक्ष्य।",
  );
  static const L sameNote = L(
    "Your two numbers are the same. This means your inner nature and your "
        "life road point the same way, so you often feel clear about what "
        "you want.",
    "आपके दोनों अंक एक ही हैं। इसका मतलब है कि आपका स्वभाव और आपकी जीवन-राह "
        "एक ही दिशा में हैं, इसलिए आपको अक्सर साफ़ पता होता है कि आप क्या "
        "चाहते हैं।",
  );

  static const L whoTitle = L("Who you are", "आप कैसे हैं");
  static const L planetLabel = L("Ruling planet", "स्वामी ग्रह");
  static const L luckyDaysLabel = L("Lucky days", "शुभ दिन");
  static const L coloursLabel = L("Lucky colours", "शुभ रंग");
  static const L gemLabel = L("Traditional stone", "पारंपरिक रत्न");
  static const L strengthsTitle = L("Your strengths", "आपकी ताक़तें");
  static const L careTitle =
      L("Where you need care", "जहाँ ध्यान देना है");
  static const L lifeTitle = L(
      "Work, money, love and health", "काम, पैसा, प्यार और सेहत");
  static const L careerTitle = L("Work and career", "काम और करियर");
  static const L moneyTitle = L("Money", "पैसा");
  static const L loveTitle = L("Love and family", "प्यार और परिवार");
  static const L healthTitle =
      L("Health (simple reminders)", "सेहत (आसान सुझाव)");
  static const L adviceTitle =
      L("Advice from your number", "आपके अंक की सलाह");

  static const L roadTitle = L("Your life road", "आपकी जीवन की राह");

  static const L nameTitle =
      L("Your name and its effect", "आपका नाम और उसका असर");
  static const L nameIntro = L(
    "Every letter in your name carries a number. Added together, they give "
        "your name number. A name that fits well with your birth number "
        "tends to feel smoother in daily life.",
    "आपके नाम के हर अक्षर का एक अंक होता है। सबको जोड़ने से आपका नाम-अंक बनता "
        "है। जो नाम आपके मूलांक से अच्छा मेल खाता है, वह रोज़मर्रा की "
        "ज़िंदगी में ज़्यादा सहज लगता है।",
  );
  static const L mobileTitle =
      L("Your mobile number", "आपका मोबाइल नंबर");
  static const L mobileIntro = L(
    "You use your phone every day, so its number quietly stays with you. "
        "Here is how it sits with your birth number.",
    "आप फ़ोन रोज़ इस्तेमाल करते हैं, इसलिए उसका नंबर चुपचाप आपके साथ रहता "
        "है। देखिए यह आपके मूलांक के साथ कैसा बैठता है।",
  );
  static const L compoundTitle =
      L("What this total number says", "इस कुल अंक का मतलब");

  static const L yearTitle =
      L("Your coming year", "आपका आने वाला साल");
  static const L yearIntro = L(
    "Every year has its own mood for you. Here is the mood of this year "
        "and the next one.",
    "हर साल आपके लिए अपना एक मिज़ाज लेकर आता है। देखिए इस साल और अगले साल "
        "का मिज़ाज कैसा है।",
  );
  static const L doLabel = L("Do this", "यह करें");
  static const L takeCareLabel = L("Take care", "इनसे बचें");

  static const L monthsTitle =
      L("Your 12 months at a glance", "आपके 12 महीने एक नज़र में");
  static const L monthsIntro = L(
    "Each month has a number. The small word under it tells you the mood "
        "of that month.",
    "हर महीने का एक अंक होता है। उसके नीचे का छोटा शब्द उस महीने का मिज़ाज "
        "बताता है।",
  );

  static const L remediesTitle =
      L("Simple things that may help", "आसान उपाय जो मदद कर सकते हैं");
  static const L remediesIntro = L(
    "These are traditional beliefs. Try only what feels comfortable to "
        "you. None of them is a must.",
    "ये पारंपरिक मान्यताएँ हैं। सिर्फ़ वही आज़माइए जो आपको सहज लगे। इनमें से "
        "कुछ भी ज़रूरी नहीं है।",
  );
  static const L habitLabel = L("A daily habit", "रोज़ की एक आदत");
  static const L daanLabel = L("Giving (daan)", "दान");
  static const L avoidLabel =
      L("Try to avoid", "इनसे बचने की कोशिश करें");

  static const L actionTitle = L("Your next 30 days", "आपके अगले 30 दिन");
  static const L actionIntro = L(
    "Five small steps. Start today and repeat them for a month.",
    "पाँच छोटे कदम। आज से शुरू कीजिए और एक महीने तक दोहराइए।",
  );
  static const L actAdvice = L("Advice for you", "आपके लिए सलाह");
  static const L actHabit = L("Daily habit", "रोज़ की आदत");
  static const L actYear = L("This year", "इस साल");
  static const L actCare = L("Take care", "ध्यान रखें");
  static const L actDay = L("Lucky day", "शुभ दिन");

  static const L closingTitle = L("A last word", "आख़िरी बात");
  static const L closingBody = L(
    "Numbers can show a direction, but you are the one who walks. Come "
        "back to this report whenever you feel confused. Read your own "
        "part again, and you will often notice something new.",
    "अंक दिशा दिखा सकते हैं, पर चलना आपको ही है। जब भी उलझन लगे, इस रिपोर्ट "
        "पर लौट आइए। अपना हिस्सा फिर से पढ़िए, अक्सर कुछ नया दिखाई देगा।",
  );

  static const L relFriendly = L(
    "These two numbers get along well and support each other.",
    "ये दोनों अंक आपस में मेल खाते हैं और एक-दूसरे का साथ देते हैं।",
  );
  static const L relNeutral = L(
    "These two numbers neither help nor harm much. Your own effort decides "
        "the result.",
    "ये दोनों अंक न ज़्यादा मदद करते हैं, न नुकसान। नतीजा आपकी अपनी मेहनत से "
        "तय होगा।",
  );
  static const L relTense = L(
    "These two numbers pull a little in different directions. Nothing to "
        "fear. Just be a bit more patient and careful here.",
    "ये दोनों अंक थोड़ा अलग-अलग दिशा में खींचते हैं। डरने की बात नहीं है, बस "
        "यहाँ थोड़ा ज़्यादा धैर्य और सावधानी रखिए।",
  );

  static const List<String> monthsEn = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  static const List<String> monthsHi = [
    'जनवरी', 'फ़रवरी', 'मार्च', 'अप्रैल', 'मई', 'जून',
    'जुलाई', 'अगस्त', 'सितंबर', 'अक्टूबर', 'नवंबर', 'दिसंबर',
  ];

  static const Map<int, L> monthWord = {
    1: L("Start", "शुरुआत"),
    2: L("Patience", "धैर्य"),
    3: L("Joy", "ख़ुशी"),
    4: L("Hard work", "मेहनत"),
    5: L("Change", "बदलाव"),
    6: L("Family", "परिवार"),
    7: L("Rest", "आराम"),
    8: L("Money", "पैसा"),
    9: L("Finish", "समापन"),
  };

  static const Map<int, YearStory> years = {
    1: YearStory(
      title: L("A fresh start", "नई शुरुआत"),
      story: L(
        "This is a year to begin. Ideas you kept aside can now move. You "
            "may feel more energy and courage than usual.",
        "यह साल शुरू करने का है। जो विचार आपने किनारे रख दिए थे, अब आगे बढ़ "
            "सकते हैं। आपमें सामान्य से ज़्यादा ऊर्जा और हिम्मत महसूस हो सकती है।",
      ),
      doThis: L(
        "Start the one thing you kept postponing. Take the first step "
            "yourself and do not wait for others.",
        "वह एक काम शुरू करें जिसे आप टालते आ रहे थे। पहला कदम ख़ुद उठाएँ, "
            "दूसरों का इंतज़ार न करें।",
      ),
      avoid: L(
        "Stubbornness and hurry. Listen to one good piece of advice before "
            "you decide.",
        "ज़िद और जल्दबाज़ी से बचें। फ़ैसले से पहले एक अच्छी सलाह ज़रूर सुनें।",
      ),
    ),
    2: YearStory(
      title: L("Patience and partnership", "धैर्य और साझेदारी"),
      story: L(
        "This year moves slowly and softly. Results come through people, "
            "patience and small steady steps.",
        "यह साल धीरे और नरमी से चलता है। नतीजे लोगों के साथ, धैर्य और "
            "छोटे-छोटे स्थिर कदमों से मिलते हैं।",
      ),
      doThis: L(
        "Work together with others, listen more and keep your promises.",
        "दूसरों के साथ मिलकर काम करें, ज़्यादा सुनें और अपने वादे निभाएँ।",
      ),
      avoid: L(
        "Forcing results, and taking offence too quickly.",
        "नतीजों के लिए ज़बरदस्ती करना और छोटी बातों पर जल्दी बुरा मान जाना।",
      ),
    ),
    3: YearStory(
      title: L("Joy and expression", "ख़ुशी और अभिव्यक्ति"),
      story: L(
        "A lighter, brighter year. Talking, learning, creating and meeting "
            "people bring good things.",
        "यह साल हल्का और रौशन है। बात करना, कुछ सीखना, कुछ रचना और लोगों से "
            "मिलना अच्छे नतीजे लाता है।",
      ),
      doThis: L(
        "Share your ideas, learn something new and spend time with friends.",
        "अपने विचार बाँटें, कुछ नया सीखें और दोस्तों के साथ समय बिताएँ।",
      ),
      avoid: L(
        "Spreading your money and energy over too many things at once.",
        "एक साथ बहुत सारी चीज़ों में पैसा और ऊर्जा बिखेरना।",
      ),
    ),
    4: YearStory(
      title: L("Building the base", "नींव बनाने का साल"),
      story: L(
        "A year of steady effort. It may feel slow, but you are building "
            "something that will last.",
        "यह साल लगातार मेहनत का है। धीमा लग सकता है, पर आप कुछ ऐसा बना रहे "
            "हैं जो टिकेगा।",
      ),
      doThis: L(
        "Make a plan, keep your accounts, and look after your health and "
            "home.",
        "योजना बनाएँ, हिसाब-किताब रखें और अपनी सेहत व घर का ध्यान रखें।",
      ),
      avoid: L(
        "Shortcuts and loose promises. Slow and honest work pays here.",
        "शॉर्टकट और ढीले वादे। यहाँ धीमा और ईमानदार काम ही फल देता है।",
      ),
    ),
    5: YearStory(
      title: L("Change and movement", "बदलाव और हलचल"),
      story: L(
        "Life moves fast this year. Travel, new people, new chances and "
            "sudden changes are possible.",
        "इस साल ज़िंदगी तेज़ चलती है। यात्रा, नए लोग, नए मौक़े और अचानक बदलाव "
            "हो सकते हैं।",
      ),
      doThis: L(
        "Stay open and flexible, learn quickly and keep your papers in "
            "order.",
        "खुले मन और लचीले रहें, जल्दी सीखें और अपने काग़ज़ात ठीक रखें।",
      ),
      avoid: L(
        "Hasty decisions and risky money moves.",
        "जल्दबाज़ी में फ़ैसले और जोखिम भरे पैसों के दाँव।",
      ),
    ),
    6: YearStory(
      title: L("Home and responsibility", "घर और ज़िम्मेदारी"),
      story: L(
        "Family, home and close relationships come to the front. You may "
            "carry more duty, but also receive more warmth.",
        "परिवार, घर और क़रीबी रिश्ते सामने आते हैं। ज़िम्मेदारी बढ़ सकती है, "
            "पर अपनापन भी बढ़ता है।",
      ),
      doThis: L(
        "Give time to family, make your home pleasant and care for those "
            "who depend on you.",
        "परिवार को समय दें, घर का माहौल सुंदर रखें और जो आप पर निर्भर हैं "
            "उनका ख़याल रखें।",
      ),
      avoid: L(
        "Trying to please everyone and forgetting yourself.",
        "सबको ख़ुश करने की कोशिश में अपना ख़याल भूल जाना।",
      ),
    ),
    7: YearStory(
      title: L("Rest and understanding", "आराम और समझ"),
      story: L(
        "A quieter, inward year. It is good for study, thinking, health and "
            "a calmer mind.",
        "यह साल शांत और भीतर की ओर है। पढ़ाई, सोच-विचार, सेहत और मन की शांति "
            "के लिए अच्छा है।",
      ),
      doThis: L(
        "Rest well, read, think, and spend some time alone each day.",
        "अच्छा आराम करें, पढ़ें, सोचें और रोज़ कुछ समय अकेले बिताएँ।",
      ),
      avoid: L(
        "Big risks and big launches. Be patient and plan carefully.",
        "बड़े जोखिम और बड़ी शुरुआतें। धैर्य रखें और सोचकर योजना बनाएँ।",
      ),
    ),
    8: YearStory(
      title: L("Work and rewards", "काम और फल"),
      story: L(
        "A strong year for career and money. Your past effort can show "
            "results, and your responsibility grows.",
        "करियर और पैसे के लिए मज़बूत साल। पिछली मेहनत का फल दिख सकता है और "
            "ज़िम्मेदारी बढ़ती है।",
      ),
      doThis: L(
        "Be organised and fair, take the lead, and plan your money with "
            "care.",
        "व्यवस्थित और न्यायपूर्ण रहें, पहल करें और पैसों की योजना "
            "सोच-समझकर बनाएँ।",
      ),
      avoid: L(
        "Greed, harshness, and taking on more than you can manage.",
        "लालच, कठोरता और ज़रूरत से ज़्यादा काम ओढ़ लेना।",
      ),
    ),
    9: YearStory(
      title: L("Finishing and letting go", "समापन और छोड़ना"),
      story: L(
        "A year of closing old chapters. Finish pending work and let go of "
            "what no longer helps you.",
        "यह साल पुराने अध्याय बंद करने का है। अधूरे काम पूरे करें और जो अब "
            "काम का नहीं उसे छोड़ दें।",
      ),
      doThis: L(
        "Complete old tasks, forgive, help others and clear the clutter.",
        "पुराने काम पूरे करें, माफ़ करें, दूसरों की मदद करें और बेकार का "
            "सामान हटाएँ।",
      ),
      avoid: L(
        "Starting big new things, or holding on to old anger.",
        "बड़ी नई शुरुआतें या पुराना ग़ुस्सा पकड़े रखना।",
      ),
    ),
  };

  static const L glanceTitle =
      L("Year by year at a glance", "साल-दर-साल एक नज़र में");
  static const L cycleNote = L(
    "Your personal years repeat in a 9-year cycle. When a number comes "
        "again, a similar mood returns, but with new people and new chances.",
    "आपके व्यक्तिगत साल 9 साल के चक्र में दोहराते हैं। जब कोई अंक फिर आता है "
        "तो मिलता-जुलता मिज़ाज लौटता है, पर नए लोगों और नए मौक़ों के साथ।",
  );
  static const L yearsIntro = L(
    "Below is a year-by-year picture. Read it as a weather forecast: it "
        "helps you prepare, but it does not decide for you.",
    "नीचे साल-दर-साल की तस्वीर है। इसे मौसम के पूर्वानुमान की तरह पढ़िए: यह "
        "तैयारी में मदद करता है, आपके लिए फ़ैसला नहीं करता।",
  );

  static const Map<int, YearAreas> yearAreas = {
    1: YearAreas(
      work: L(
        "A good time to start a new job, business or project. Take the lead.",
        "नई नौकरी, कारोबार या प्रोजेक्ट शुरू करने का अच्छा समय। आगे बढ़कर पहल करें।",
      ),
      money: L(
        "New ways of earning can open. Spend on things that help you grow, "
            "not on show.",
        "कमाई के नए रास्ते खुल सकते हैं। दिखावे पर नहीं, आगे बढ़ाने वाली चीज़ों "
            "पर ख़र्च करें।",
      ),
      love: L(
        "Be clear and kind. Do not let ego decide in relationships.",
        "साफ़ और नरम रहिए। रिश्तों में अहंकार को फ़ैसला न करने दें।",
      ),
    ),
    2: YearAreas(
      work: L(
        "Teamwork and partnerships help more than working alone.",
        "अकेले काम करने से ज़्यादा टीमवर्क और साझेदारी फ़ायदा देती है।",
      ),
      money: L(
        "Small, steady savings do better than big risks.",
        "बड़े जोखिम से ज़्यादा छोटी, लगातार बचत फ़ायदेमंद है।",
      ),
      love: L(
        "A good year to mend a bond with softness and patience.",
        "नरमी और धैर्य से किसी रिश्ते को सुधारने का अच्छा साल।",
      ),
    ),
    3: YearAreas(
      work: L(
        "Speaking, teaching, writing and creative work shine.",
        "बोलना, पढ़ाना, लिखना और रचनात्मक काम चमकते हैं।",
      ),
      money: L(
        "Money comes through your skills and contacts, but it can slip away "
            "on fun.",
        "पैसा आपके हुनर और जान-पहचान से आता है, पर मौज-मस्ती में निकल भी "
            "सकता है।",
      ),
      love: L(
        "Warm, social and cheerful. Good for meeting people.",
        "गर्मजोशी भरा और मिलनसार साल। लोगों से मिलने के लिए अच्छा।",
      ),
    ),
    4: YearAreas(
      work: L(
        "Hard work and discipline pay. Finish what you start.",
        "मेहनत और अनुशासन फल देते हैं। जो शुरू करें उसे पूरा करें।",
      ),
      money: L(
        "Save, avoid loans and keep clean records.",
        "बचत करें, क़र्ज़ से बचें और हिसाब साफ़ रखें।",
      ),
      love: L(
        "Show love through actions and time, not only words.",
        "प्यार सिर्फ़ शब्दों से नहीं, समय और काम से दिखाइए।",
      ),
    ),
    5: YearAreas(
      work: L(
        "Good for sales, travel, media and new contacts. Keep your focus.",
        "बिक्री, यात्रा, मीडिया और नए संपर्कों के लिए अच्छा। ध्यान बनाए रखें।",
      ),
      money: L(
        "Income can swing up and down. Keep a safety fund.",
        "आमदनी ऊपर-नीचे हो सकती है। आपात कोष ज़रूर रखें।",
      ),
      love: L(
        "Exciting but changeable. Be honest to keep trust.",
        "रोमांचक पर बदलता हुआ। भरोसा बनाए रखने के लिए ईमानदार रहें।",
      ),
    ),
    6: YearAreas(
      work: L(
        "Work involving care, beauty, teaching or service does well.",
        "देखभाल, सुंदरता, शिक्षा या सेवा से जुड़े काम अच्छे चलते हैं।",
      ),
      money: L(
        "Spending on home and family rises. Plan it in advance.",
        "घर और परिवार पर ख़र्च बढ़ता है। पहले से योजना बनाएँ।",
      ),
      love: L(
        "A strong year for marriage, family and deep bonds.",
        "विवाह, परिवार और गहरे रिश्तों के लिए मज़बूत साल।",
      ),
    ),
    7: YearAreas(
      work: L(
        "Research, study, writing and skill-building do well. Avoid hasty "
            "launches.",
        "शोध, पढ़ाई, लेखन और हुनर निखारने के काम अच्छे रहते हैं। लॉन्च में "
            "जल्दबाज़ी न करें।",
      ),
      money: L(
        "Be careful with new investments. Do your homework first.",
        "नए निवेश में सावधानी रखें। पहले अच्छी जाँच-पड़ताल करें।",
      ),
      love: L(
        "You may want more quiet time. Tell your people kindly.",
        "आपको ज़्यादा एकांत चाहिए हो सकता है। अपनों को प्यार से बता दें।",
      ),
    ),
    8: YearAreas(
      work: L(
        "Promotion, leadership and bigger responsibility are likely.",
        "तरक़्क़ी, नेतृत्व और बड़ी ज़िम्मेदारी की संभावना है।",
      ),
      money: L(
        "Good earning potential. Manage it well and stay fair in dealings.",
        "कमाई की अच्छी संभावना है। संभालकर चलिए और लेन-देन में निष्पक्ष रहिए।",
      ),
      love: L(
        "Work can eat your time. Make room for loved ones.",
        "काम आपका समय खा सकता है। अपनों के लिए जगह निकालिए।",
      ),
    ),
    9: YearAreas(
      work: L(
        "Wrap up old projects. Good for service and helping work.",
        "पुराने प्रोजेक्ट समेटें। सेवा और मदद वाले काम के लिए अच्छा।",
      ),
      money: L(
        "Clear old dues and unneeded spending. Gains come later.",
        "पुराने बकाये और फ़ालतू ख़र्च निपटाइए। फ़ायदा बाद में आता है।",
      ),
      love: L(
        "Forgive and release. Old ties may end or heal.",
        "माफ़ करें और छोड़ें। पुराने रिश्ते ख़त्म या ठीक हो सकते हैं।",
      ),
    ),
  };

  static const Map<int, Habit> habits = {
    1: Habit(
      habit: L(
        "Spend ten minutes in the morning sunlight and plan your day with a "
            "clear head.",
        "सुबह दस मिनट धूप में बिताएँ और शांत मन से दिन की योजना बनाएँ।",
      ),
      daan: L(
        "Give wheat or jaggery to someone in need, on Sundays if you wish.",
        "ज़रूरतमंद को गेहूँ या गुड़ दें, चाहें तो रविवार को।",
      ),
      avoid: L(
        "Pride, and arguing just to prove a point.",
        "घमंड और बात मनवाने की ज़िद।",
      ),
    ),
    2: Habit(
      habit: L(
        "Drink water slowly, and sit quietly for five minutes at night to "
            "notice how you feel.",
        "आराम से पानी पिएँ, रात को पाँच मिनट शांत बैठें और अपने मन का हाल "
            "देखें।",
      ),
      daan: L(
        "Give rice or milk to someone in need, on Mondays if you wish.",
        "ज़रूरतमंद को चावल या दूध दें, चाहें तो सोमवार को।",
      ),
      avoid: L(
        "Overthinking, and taking decisions in a low mood.",
        "ज़रूरत से ज़्यादा सोचना और उदास मन से फ़ैसले लेना।",
      ),
    ),
    3: Habit(
      habit: L(
        "Read or learn something small every day, and respect an elder.",
        "रोज़ कुछ छोटा सा सीखें या पढ़ें और किसी बड़े का सम्मान करें।",
      ),
      daan: L(
        "Give chana dal, yellow sweets or a useful book, on Thursdays if "
            "you wish.",
        "चना दाल, पीली मिठाई या कोई काम की किताब दें, चाहें तो गुरुवार को।",
      ),
      avoid: L(
        "Promising more than you can do.",
        "जितना निभा सकें उससे ज़्यादा वादा करना।",
      ),
    ),
    4: Habit(
      habit: L(
        "Keep a small notebook, write tomorrow's three tasks, and walk "
            "outdoors for a while.",
        "एक छोटी डायरी रखें, कल के तीन काम लिखें और थोड़ी देर बाहर टहलें।",
      ),
      daan: L(
        "Give warm clothes or a meal to someone in need.",
        "ज़रूरतमंद को गर्म कपड़े या खाना दें।",
      ),
      avoid: L(
        "Hurry and shortcuts.",
        "जल्दबाज़ी और शॉर्टकट।",
      ),
    ),
    5: Habit(
      habit: L(
        "Care for a green plant, and keep your phone away for the first "
            "half hour of the day.",
        "एक हरे पौधे की देखभाल करें और दिन के पहले आधे घंटे फ़ोन से दूर रहें।",
      ),
      daan: L(
        "Give green moong, or help with someone's studies, on Wednesdays "
            "if you wish.",
        "हरी मूँग दें या किसी की पढ़ाई में मदद करें, चाहें तो बुधवार को।",
      ),
      avoid: L(
        "Doing too many things at once, and careless words.",
        "एक साथ बहुत सारे काम और लापरवाही से बोले गए शब्द।",
      ),
    ),
    6: Habit(
      habit: L(
        "Keep your home neat and pleasant, and share one meal with family "
            "without phones.",
        "घर को साफ़ और सुंदर रखें और रोज़ एक बार बिना फ़ोन के परिवार के साथ "
            "खाना खाएँ।",
      ),
      daan: L(
        "Give sweets, rice or flowers to someone, on Fridays if you wish.",
        "किसी को मिठाई, चावल या फूल दें, चाहें तो शुक्रवार को।",
      ),
      avoid: L(
        "Showing off, and spending just to impress.",
        "दिखावा और दूसरों को प्रभावित करने के लिए खर्च।",
      ),
    ),
    7: Habit(
      habit: L(
        "Keep ten quiet minutes every day for prayer, silence or a slow "
            "walk.",
        "रोज़ दस मिनट प्रार्थना, मौन या धीमी सैर के लिए रखें।",
      ),
      daan: L(
        "Give water to the thirsty, or grain to the birds.",
        "प्यासे को पानी पिलाएँ या पक्षियों को दाना डालें।",
      ),
      avoid: L(
        "Cutting yourself off from people when you feel low.",
        "मन उदास होने पर लोगों से कट जाना।",
      ),
    ),
    8: Habit(
      habit: L(
        "Be on time, finish the hardest task first, and thank someone who "
            "works for you.",
        "समय पर रहें, दिन का सबसे कठिन काम सबसे पहले निपटाएँ और अपने साथ काम "
            "करने वाले को धन्यवाद दें।",
      ),
      daan: L(
        "Give clothes, food or a fair payment to a worker or helper, on "
            "Saturdays if you wish.",
        "किसी मज़दूर या सहायक को कपड़े, खाना या पूरा मेहनताना दें, चाहें तो "
            "शनिवार को।",
      ),
      avoid: L(
        "Greed, and taking anyone's due.",
        "लालच और किसी का हक़ मारना।",
      ),
    ),
    9: Habit(
      habit: L(
        "Do some exercise every day and drink plenty of water.",
        "रोज़ थोड़ी कसरत करें और खूब पानी पिएँ।",
      ),
      daan: L(
        "Give masoor dal or jaggery, or help a good cause, on Tuesdays if "
            "you wish.",
        "मसूर दाल या गुड़ दें, या किसी अच्छे काम में मदद करें, चाहें तो "
            "मंगलवार को।",
      ),
      avoid: L(
        "Anger, and reacting too quickly.",
        "गुस्सा और जल्दी प्रतिक्रिया देना।",
      ),
    ),
  };
}
