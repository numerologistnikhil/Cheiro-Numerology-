// Ank Dhara - extra yearly details (English + Hindi)
// Personal Year 1 to 9: health, family, learning, inner life.
// Personal Month 1 to 9: one clear line for each month.

import 'report_pages.dart';

class YearExtra {
  final PBi health;
  final PBi family;
  final PBi study;
  final PBi spirit;
  const YearExtra(this.health, this.family, this.study, this.spirit);
}

class YearDetails {
  YearDetails._();

  static const Map<int, YearExtra> extra = {
    1: YearExtra(
      PBi('Energy is high, so you may push too hard. Keep a fixed sleep time, exercise regularly and watch for headaches and stress from overwork.',
          'ऊर्जा ज़्यादा रहती है, इसलिए आप खुद को ज़रूरत से ज़्यादा धक्का दे सकते हैं। सोने का समय तय रखिए, नियमित कसरत कीजिए और सिरदर्द तथा ज़्यादा काम के तनाव पर नज़र रखिए।'),
      PBi('You may want more independence at home. Explain your plans to the family early so that they feel included and not left behind.',
          'घर में आपको ज़्यादा आज़ादी चाहिए हो सकती है। अपनी योजनाएँ परिवार को पहले से समझाइए ताकि वे खुद को शामिल महसूस करें, पीछे छूटा हुआ नहीं।'),
      PBi('A good year to start a new course, a new skill or a new subject. Choose one thing and stay with it for the full year.',
          'नया कोर्स, नया हुनर या नया विषय शुरू करने के लिए अच्छा साल है। कोई एक चीज़ चुनिए और पूरे साल उसके साथ बने रहिए।'),
      PBi('Begin a small daily practice such as five minutes of quiet or prayer every morning. A new beginning in the mind supports a new beginning in life.',
          'हर सुबह पाँच मिनट मौन या प्रार्थना जैसा कोई छोटा रोज़ का अभ्यास शुरू कीजिए। मन की नई शुरुआत जीवन की नई शुरुआत को सहारा देती है।'),
    ),
    2: YearExtra(
      PBi('The body is sensitive this year, especially digestion, sleep and emotions. Eat on time, drink enough water and avoid holding feelings inside.',
          'इस साल शरीर संवेदनशील रहता है, खासकर पाचन, नींद और भावनाएँ। समय पर खाइए, पर्याप्त पानी पीजिए और भावनाओं को अंदर दबाकर मत रखिए।'),
      PBi('Relationships ask for patience. Listen more than you speak, and try to settle old misunderstandings gently.',
          'रिश्ते धैर्य माँगते हैं। बोलने से ज़्यादा सुनिए और पुरानी गलतफ़हमियों को नरमी से सुलझाने की कोशिश कीजिए।'),
      PBi('Learning is better in a group or with a partner. Join a class or study with a friend for steadier progress.',
          'समूह में या किसी साथी के साथ सीखना बेहतर रहता है। कोई कक्षा जॉइन कीजिए या दोस्त के साथ पढ़िए, तरक्की ज़्यादा टिकाऊ होगी।'),
      PBi('Practise calm breathing and gratitude. Trusting that things will unfold at their own pace is the lesson of this year.',
          'शांत साँसों और आभार का अभ्यास कीजिए। यह भरोसा रखना कि हर चीज़ अपनी गति से खुलेगी, इस साल की सीख है।'),
    ),
    3: YearExtra(
      PBi('Mood, throat, shoulders and nerves need care. Do not skip meals for social plans or work, and give yourself time to laugh and rest.',
          'मूड, गला, कंधे और नसों का ध्यान रखिए। मेल-मिलाप या काम के लिए खाना मत छोड़िए, और खुद को हँसने और आराम करने का समय दीजिए।'),
      PBi('A lively year with gatherings, celebrations and new friends. Keep your words kind because careless jokes can hurt someone close.',
          'मेल-मिलाप, उत्सव और नए दोस्तों वाला जीवंत साल। अपने शब्द मीठे रखिए, क्योंकि लापरवाही का मज़ाक किसी करीबी को चोट पहुँचा सकता है।'),
      PBi('Creative learning such as writing, speaking, music, design or languages brings good results. Share what you learn with others.',
          'लिखना, बोलना, संगीत, डिज़ाइन या भाषाएँ जैसी रचनात्मक पढ़ाई अच्छे नतीजे देती है। जो सीखें उसे दूसरों के साथ बाँटिए।'),
      PBi('Express your thanks through singing, writing or kind words. Joy itself is a spiritual practice this year.',
          'गाकर, लिखकर या मीठे शब्दों से अपना आभार जताइए। इस साल खुशी खुद एक आध्यात्मिक अभ्यास है।'),
    ),
    4: YearExtra(
      PBi('Hard work can tire the back, bones and joints. Take short breaks, improve your sitting posture and keep a regular routine for food and sleep.',
          'कड़ी मेहनत से पीठ, हड्डियाँ और जोड़ थक सकते हैं। छोटे ब्रेक लीजिए, बैठने का तरीका सुधारिए और खाने-सोने की नियमित दिनचर्या रखिए।'),
      PBi('The home needs repairs, planning or organisation. Be steady and dependable, but do not become too strict with loved ones.',
          'घर को मरम्मत, योजना या व्यवस्था की ज़रूरत हो सकती है। स्थिर और भरोसेमंद रहिए, पर अपनों के साथ बहुत सख़्त मत हो जाइए।'),
      PBi('Good for exams, certificates, accounts and technical learning. Make a timetable and follow it every day.',
          'परीक्षा, प्रमाणपत्र, हिसाब-किताब और तकनीकी पढ़ाई के लिए अच्छा साल। एक समय-सारणी बनाइए और रोज़ उसका पालन कीजिए।'),
      PBi('Discipline is your prayer this year. A fixed time and place for your practice builds a strong inner base.',
          'इस साल अनुशासन ही आपकी प्रार्थना है। अभ्यास के लिए तय समय और जगह एक मज़बूत अंदरूनी नींव बनाती है।'),
    ),
    5: YearExtra(
      PBi('Travel, irregular food and restless nights can disturb health. Keep a light routine even when plans change and avoid careless habits.',
          'यात्रा, बेतरतीब खाना और बेचैन रातें सेहत बिगाड़ सकती हैं। योजनाएँ बदलें तब भी हल्की दिनचर्या बनाए रखिए और लापरवाह आदतों से बचिए।'),
      PBi('Change at home, a move, travel or a new member may come. Stay flexible and keep communication open.',
          'घर में बदलाव, जगह बदलना, यात्रा या कोई नया सदस्य आ सकता है। लचीले रहिए और बातचीत का रास्ता खुला रखिए।'),
      PBi('Short courses, travel learning, languages and sales or media skills suit this year. Try new ways of learning.',
          'छोटे कोर्स, यात्रा से सीखना, भाषाएँ और सेल्स या मीडिया के हुनर इस साल को सूट करते हैं। सीखने के नए तरीके आज़माइए।'),
      PBi('Let go of the fear of change. A short pilgrimage or a quiet walk in nature can refresh your mind.',
          'बदलाव का डर छोड़िए। कोई छोटी तीर्थ यात्रा या प्रकृति में शांत सैर आपके मन को तरोताज़ा कर सकती है।'),
    ),
    6: YearExtra(
      PBi('You may take on everyone\'s burden. Look after the heart, throat and weight, and make time for your own check-ups and rest.',
          'आप सबका बोझ अपने ऊपर ले सकते हैं। दिल, गले और वज़न का ध्यान रखिए, और अपनी जाँच तथा आराम के लिए भी समय निकालिए।'),
      PBi('Home, marriage, children and parents come to the front. Love and responsibility both grow, so share the load and do not carry everything alone.',
          'घर, विवाह, बच्चे और माता-पिता आगे आते हैं। प्रेम और ज़िम्मेदारी दोनों बढ़ते हैं, इसलिए बोझ बाँटिए और सब कुछ अकेले मत उठाइए।'),
      PBi('Good for learning healing, teaching, cooking, art, beauty or home-related skills. Learning for the benefit of the family feels natural.',
          'उपचार, पढ़ाना, पाक कला, कला, सौंदर्य या घर से जुड़े हुनर सीखने के लिए अच्छा। परिवार के भले के लिए सीखना स्वाभाविक लगता है।'),
      PBi('Service at home and kindness to neighbours is your practice. Keep your home peaceful, clean and warm.',
          'घर में सेवा और पड़ोसियों के प्रति दया आपका अभ्यास है। अपने घर को शांत, साफ़ और स्नेहभरा रखिए।'),
    ),
    7: YearExtra(
      PBi('The mind needs rest more than the body. Protect your sleep, reduce screen time and make space for silence to avoid tiredness and worry.',
          'शरीर से ज़्यादा मन को आराम चाहिए। अपनी नींद बचाइए, स्क्रीन का समय घटाइए और थकान तथा चिंता से बचने के लिए मौन के लिए जगह बनाइए।'),
      PBi('You may want more privacy and time alone. Tell your family kindly that you need quiet, so they do not feel pushed away.',
          'आपको ज़्यादा एकांत और अकेला समय चाहिए हो सकता है। परिवार को प्यार से बताइए कि आपको शांति चाहिए, ताकि वे खुद को दूर किया हुआ न समझें।'),
      PBi('A very good year for deep study, research, spiritual reading and technical depth. Quality matters more than speed.',
          'गहरी पढ़ाई, शोध, आध्यात्मिक पठन और तकनीकी गहराई के लिए बहुत अच्छा साल। यहाँ गति से ज़्यादा गुणवत्ता मायने रखती है।'),
      PBi('Meditation, silence and prayer give real answers now. Trust your inner voice but check the facts before big steps.',
          'ध्यान, मौन और प्रार्थना अब सच्चे जवाब देते हैं। अपनी अंतरात्मा पर भरोसा कीजिए, पर बड़े कदम से पहले तथ्य जाँच लीजिए।'),
    ),
    8: YearExtra(
      PBi('Pressure from work and money can affect blood pressure, stress levels and sleep. Walk daily, limit caffeine and take proper rest even when busy.',
          'काम और पैसे का दबाव रक्तचाप, तनाव और नींद पर असर डाल सकता है। रोज़ टहलिए, कैफ़ीन सीमित रखिए और व्यस्त हों तब भी ठीक से आराम कीजिए।'),
      PBi('Most of your time may go to work and results. Give the family fixed time slots so that success does not cost you closeness.',
          'आपका ज़्यादातर समय काम और नतीजों में जा सकता है। परिवार को तय समय दीजिए ताकि सफलता की कीमत नज़दीकी न बने।'),
      PBi('Good for management, finance, law, business and leadership learning. Study how money and people work.',
          'प्रबंधन, वित्त, कानून, व्यापार और नेतृत्व सीखने के लिए अच्छा। यह समझने की कोशिश कीजिए कि पैसा और लोग कैसे काम करते हैं।'),
      PBi('Fair dealing and honest earning are your practice. Give a part of your income to a worthy cause.',
          'निष्पक्ष व्यवहार और ईमानदार कमाई आपका अभ्यास है। अपनी आमदनी का एक हिस्सा किसी अच्छे काम में दीजिए।'),
    ),
    9: YearExtra(
      PBi('A year to clean up. Finish pending medical checks, release old stress and avoid starting extreme diets or heavy new routines.',
          'यह सफ़ाई का साल है। बाकी स्वास्थ्य जाँचें पूरी कीजिए, पुराना तनाव छोड़िए और कोई अति वाली डाइट या भारी नई दिनचर्या शुरू करने से बचिए।'),
      PBi('Old relationships may end or change shape. Forgive, thank the people who helped you and make room for new ones.',
          'पुराने रिश्ते खत्म या बदल सकते हैं। माफ़ कीजिए, जिन्होंने आपकी मदद की उन्हें धन्यवाद दीजिए और नए रिश्तों के लिए जगह बनाइए।'),
      PBi('Good for completing courses, teaching others and learning about service, humanity or healing. Finish what is half done.',
          'कोर्स पूरे करने, दूसरों को सिखाने और सेवा, मानवता या उपचार के बारे में सीखने के लिए अच्छा। जो आधा बचा है उसे पूरा कीजिए।'),
      PBi('Charity, forgiveness and letting go are the heart of this year. Give away what you no longer need and close old accounts in the mind.',
          'दान, क्षमा और छोड़ देना इस साल का सार है। जिसकी अब ज़रूरत नहीं उसे दे दीजिए और मन के पुराने हिसाब बंद कीजिए।'),
    ),
  };

  static const Map<int, PBi> monthLine = {
    1: PBi('A good month to begin something. Take the first step, speak up and decide, but avoid being hasty or stubborn.',
        'कुछ शुरू करने के लिए अच्छा महीना। पहला कदम उठाइए, अपनी बात रखिए और फ़ैसला कीजिए, पर जल्दबाज़ी या ज़िद से बचिए।'),
    2: PBi('A soft and patient month. Listen, cooperate and wait for replies. Small kind gestures settle disputes.',
        'नरम और धैर्य वाला महीना। सुनिए, सहयोग कीजिए और जवाबों का इंतज़ार कीजिए। छोटे स्नेहभरे कदम झगड़े सुलझा देते हैं।'),
    3: PBi('A cheerful and social month. Express your ideas, meet people and enjoy yourself, but do not scatter your energy.',
        'खुशमिज़ाज और मेल-मिलाप वाला महीना। अपने विचार रखिए, लोगों से मिलिए और आनंद लीजिए, पर अपनी ऊर्जा बिखेरिए मत।'),
    4: PBi('A month for steady work. Organise papers, finish plans and stay disciplined. Take short rests to avoid tiredness.',
        'स्थिर काम का महीना। कागज़ात ठीक कीजिए, योजनाएँ पूरी कीजिए और अनुशासित रहिए। थकान से बचने के लिए छोटे आराम लीजिए।'),
    5: PBi('A month of movement and change. Travel, news and new offers may come. Stay flexible and think before spending.',
        'हलचल और बदलाव का महीना। यात्रा, खबरें और नए प्रस्ताव आ सकते हैं। लचीले रहिए और खर्च से पहले सोचिए।'),
    6: PBi('A month for home and loved ones. Look after family matters, be generous and keep your promises.',
        'घर और अपनों का महीना। परिवार के मामलों का ध्यान रखिए, उदार रहिए और अपने वादे निभाइए।'),
    7: PBi('A quiet and thoughtful month. Study, reflect and rest. Avoid forcing big decisions and keep your own company sometimes.',
        'शांत और सोच-विचार का महीना। पढ़िए, मनन कीजिए और आराम कीजिए। बड़े फ़ैसले ज़बरदस्ती मत कीजिए और कभी-कभी अपने साथ भी समय बिताइए।'),
    8: PBi('A powerful month for work and money. Plan, negotiate and push for results, but stay fair and avoid overworking.',
        'काम और पैसे के लिए ताकतवर महीना। योजना बनाइए, बातचीत कीजिए और नतीजों के लिए ज़ोर लगाइए, पर निष्पक्ष रहिए और ज़रूरत से ज़्यादा काम मत कीजिए।'),
    9: PBi('A month to complete and let go. Finish old tasks, forgive and offer help. Do not start heavy new things yet.',
        'पूरा करने और छोड़ देने का महीना। पुराने काम निपटाइए, माफ़ कीजिए और मदद दीजिए। अभी भारी नई चीज़ें शुरू मत कीजिए।'),
  };
}
