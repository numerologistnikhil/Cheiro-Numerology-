import 'heavy_numbers.dart';
import 'numerology_engine.dart';
import 'numerology_tools.dart';
import 'root_profiles.dart' show L;
import 'signature_analysis.dart';

enum SizeVsHand { bigger, same, smaller }

enum Legibility { clear, partly, unreadable }

/// One observation about the signature with a traditional reading and a tip.
class SigFinding {
  final L title;
  final String measured; // plain facts, e.g. "Leans right about 18 degrees"
  final L reading;
  final L tip;
  final int tone; // 1 = strength, 0 = neutral, -1 = take care
  const SigFinding(this.title, this.measured, this.reading, this.tip, this.tone);
}

class SigNumber {
  final int total;
  final int root;
  final Relation withMulank;
  final Relation withBhagyank;
  final bool heavy;
  const SigNumber(this.total, this.root, this.withMulank, this.withBhagyank, this.heavy);
}

class SignatureReading {
  final List<SigFinding> findings;
  final SigNumber? number;
  const SignatureReading(this.findings, this.number);

  // ------------------------------------------------------------ texts
  static const L title = L('Signature Analysis', 'हस्ताक्षर विश्लेषण');
  static const L intro = L(
    'Upload a photo of your signature. The app measures the lean, direction, pressure, shape and ending of your signature and explains what handwriting readers (graphologists) traditionally say about each. '
    'It also checks the number of the name you sign with. Your picture stays on your phone.',
    'अपने हस्ताक्षर की फोटो डालिए। ऐप हस्ताक्षर का झुकाव, दिशा, दबाव, बनावट और अंत नापता है और बताता है कि हस्तलेख-विशेषज्ञ (ग्राफ़ोलॉजिस्ट) परंपरा से हर बात के बारे में क्या कहते हैं। '
    'साथ ही आप जिस नाम से हस्ताक्षर करते हैं उसका अंक भी जाँचता है। आपकी तस्वीर आपके फ़ोन में ही रहती है।');
  static const L honest = L(
    'Please read this: handwriting analysis is a traditional practice. Research has not shown that it can reliably tell character or predict the future, so treat it as a mirror for reflection and fun, not as a test. '
    'Never use it to judge a job applicant, a relationship, health or money. A signature also changes with mood, pen, paper and speed.',
    'कृपया ध्यान दें: हस्तलेख विश्लेषण एक पारंपरिक विधा है। शोध में यह साबित नहीं हुआ कि यह चरित्र बता सकता है या भविष्य का भरोसेमंद अनुमान दे सकता है। इसे चिंतन और मनोरंजन का आईना मानें, परीक्षा नहीं। '
    'इसे नौकरी के उम्मीदवार, रिश्ते, सेहत या पैसे के फ़ैसले के लिए कभी इस्तेमाल न करें। हस्ताक्षर मूड, कलम, कागज़ और रफ़्तार से भी बदलता है।');
  static const L photoTips = L(
    'How to take the photo: sign with your normal pen on plain white paper. Keep the paper flat in good light, no shadow. Crop so that only the signature is in the picture. Take 2 or 3 signatures separately if you like and try each.',
    'फोटो कैसे लें: अपनी सामान्य कलम से सादे सफ़ेद कागज़ पर हस्ताक्षर करें। कागज़ सीधा और रोशनी अच्छी रखें, परछाईं न हो। फोटो को इस तरह काटें कि सिर्फ़ हस्ताक्षर दिखे। चाहें तो 2-3 हस्ताक्षर अलग-अलग लेकर देखें।');
  static const L nameLabel = L('Name you sign with', 'जिस नाम से हस्ताक्षर करते हैं');
  static const L sizeQ = L('Compared with your normal handwriting, your signature is', 'आपके सामान्य हस्तलेख की तुलना में आपका हस्ताक्षर');
  static const L legQ = L('Can another person read your signature?', 'क्या कोई और आपके हस्ताक्षर को पढ़ सकता है?');
  static const Map<SizeVsHand, L> sizeOpt = {
    SizeVsHand.bigger: L('Bigger', 'बड़ा'),
    SizeVsHand.same: L('About the same', 'लगभग बराबर'),
    SizeVsHand.smaller: L('Smaller', 'छोटा'),
  };
  static const Map<Legibility, L> legOpt = {
    Legibility.clear: L('Yes, clearly', 'हाँ, साफ़'),
    Legibility.partly: L('Partly', 'कुछ हद तक'),
    Legibility.unreadable: L('No, it is a scribble', 'नहीं, घसीट है'),
  };
  static const L pick = L('Choose signature photo', 'हस्ताक्षर की फोटो चुनें');
  static const L change = L('Choose another photo', 'दूसरी फोटो चुनें');
  static const L analyse = L('Analyse my signature', 'मेरे हस्ताक्षर का विश्लेषण करें');
  static const L working = L('Analysing...', 'विश्लेषण हो रहा है...');
  static const L noInk = L('I could not find a clear signature in this picture. Use a dark pen on white paper, crop closely and try again.', 'इस फोटो में साफ़ हस्ताक्षर नहीं मिला। सफ़ेद कागज़ पर गहरी कलम से लिखें, पास से काटें और फिर कोशिश करें।');
  static const L bad = L('This file could not be opened as a picture.', 'यह फ़ाइल फोटो की तरह नहीं खुल सकी।');
  static const L resultHead = L('What I found', 'मुझे क्या मिला');
  static const L measuredLabel = L('Measured', 'नाप');
  static const L tipLabel = L('Tip', 'सुझाव');
  static const L numberHead = L('Number of your signed name', 'आपके हस्ताक्षर वाले नाम का अंक');
  static const L summaryHead = L('In short', 'संक्षेप में');
  static const L strengths = L('Strong points', 'मज़बूत बातें');
  static const L care = L('Points to watch', 'ध्यान देने की बातें');
  static const L improveHead = L('Simple ways to refine your signature', 'हस्ताक्षर को निखारने के सरल तरीके');
  static const L addToPdf = L('Add this to my PDF report', 'इसे मेरी PDF रिपोर्ट में जोड़ें');
  static const L openPdf = L('Open my report with the signature', 'हस्ताक्षर के साथ मेरी रिपोर्ट खोलें');
  static const L added = L('The signature page will appear in your next report.', 'हस्ताक्षर का पन्ना आपकी अगली रिपोर्ट में आएगा।');
  static const L pdfTitle = L('Signature Analysis', 'हस्ताक्षर विश्लेषण');
  static const L pdfPhoto = L('Your signature', 'आपका हस्ताक्षर');

  static const List<L> improve = [
    L('Sign the same way every time and everywhere. A steady signature builds trust and a steady identity.', 'हर बार और हर जगह एक ही तरह हस्ताक्षर करें। स्थिर हस्ताक्षर भरोसा और स्थिर पहचान बनाता है।'),
    L('Make the first letter clear. It is traditionally linked with how you present yourself to the world.', 'पहला अक्षर साफ़ लिखें। परंपरा में इसे इस बात से जोड़ा जाता है कि आप दुनिया के सामने खुद को कैसे रखते हैं।'),
    L('Keep the signature readable enough that someone can tell your name. A tangled scribble hides you.', 'हस्ताक्षर इतना पढ़ने योग्य रखें कि कोई आपका नाम पहचान सके। उलझी घसीट आपको छिपा देती है।'),
    L('Let the line rise gently to the right, not fall. Many handwriting readers connect this with optimism and drive.', 'रेखा को दाईं ओर हल्का ऊपर उठने दें, गिरने न दें। कई हस्तलेख-विशेषज्ञ इसे आशावाद और उत्साह से जोड़ते हैं।'),
    L('Do not cross out or strike through your name. It is traditionally seen as turning against yourself.', 'अपने नाम को काटें या उस पर लकीर न खींचें। परंपरा इसे खुद के विरुद्ध जाना मानती है।'),
    L('Check that the number of your signed name suits your Mulank and Bhagyank. Small spelling changes can be tried in Name Correction.', 'देखें कि हस्ताक्षर वाले नाम का अंक आपके मूलांक और भाग्यांक से मेल खाता है या नहीं। छोटे स्पेलिंग बदलाव नाम सुधार में आज़माए जा सकते हैं।'),
  ];

  static String _d(double v) => v.abs().toStringAsFixed(0);

  /// Build the reading from measurements and the two answers.
  static SignatureReading build({
    required SignatureMetrics m,
    required SizeVsHand size,
    required Legibility legibility,
    String name = '',
    int? mulank,
    int? bhagyank,
  }) {
    final f = <SigFinding>[];

    // slant
    if (m.slantDeg > 25) {
      f.add(SigFinding(const L('Slant', 'झुकाव'), 'Leans right about ${_d(m.slantDeg)} degrees',
          const L('A strong right lean is traditionally read as an emotional, outgoing and impulsive nature that reaches towards people and the future.',
              'तेज़ दाईं ओर झुकाव को परंपरा में भावुक, मिलनसार और आवेगी स्वभाव माना जाता है जो लोगों और भविष्य की ओर बढ़ता है।'),
          const L('Pause before big decisions so feeling does not run ahead of thought.', 'बड़े फ़ैसलों से पहले रुकें, ताकि भावना सोच से आगे न निकल जाए।'), 0));
    } else if (m.slantDeg > 8) {
      f.add(SigFinding(const L('Slant', 'झुकाव'), 'Leans right about ${_d(m.slantDeg)} degrees',
          const L('A gentle right lean is read as friendly, open and willing to connect, with feelings in good balance.',
              'हल्का दाईं ओर झुकाव मिलनसार, खुले और जुड़ने को तैयार स्वभाव का संकेत माना जाता है, जिसमें भावनाएँ संतुलित हैं।'),
          const L('Keep this warmth; it helps in work with people.', 'यह गर्मजोशी बनाए रखें; लोगों के साथ काम में मदद करती है।'), 1));
    } else if (m.slantDeg >= -8) {
      f.add(SigFinding(const L('Slant', 'झुकाव'), 'Almost upright (${m.slantDeg.toStringAsFixed(0)} degrees)',
          const L('An upright signature is read as self-controlled, practical and independent, someone who decides with the head.',
              'सीधा हस्ताक्षर आत्म-नियंत्रित, व्यावहारिक और स्वतंत्र स्वभाव का संकेत माना जाता है, जो दिमाग से फ़ैसला करता है।'),
          const L('Let a little warmth show with people close to you.', 'अपनों के साथ थोड़ी गर्मजोशी भी दिखाइए।'), 1));
    } else {
      f.add(SigFinding(const L('Slant', 'झुकाव'), 'Leans left about ${_d(m.slantDeg)} degrees',
          const L('A left lean is traditionally read as reserved, private and cautious, someone who thinks first and shares little.',
              'बाईं ओर झुकाव को परंपरा में संकोची, निजी और सतर्क स्वभाव माना जाता है, जो पहले सोचता है और कम बाँटता है।'),
          const L('Share your thoughts with one trusted person; it lightens the load.', 'अपने विचार एक भरोसेमंद व्यक्ति से बाँटिए; बोझ हल्का होता है।'), 0));
    }

    // baseline
    if (m.baselineDeg > 4) {
      f.add(SigFinding(const L('Direction of the line', 'रेखा की दिशा'), 'Rises about ${_d(m.baselineDeg)} degrees',
          const L('A line that climbs to the right is read as optimism, ambition and energy.', 'दाईं ओर चढ़ती रेखा आशावाद, महत्वाकांक्षा और ऊर्जा का संकेत मानी जाती है।'),
          const L('Good. Keep goals realistic so enthusiasm does not tire you.', 'अच्छा है। लक्ष्य वास्तविक रखें ताकि उत्साह थका न दे।'), 1));
    } else if (m.baselineDeg >= -4) {
      f.add(SigFinding(const L('Direction of the line', 'रेखा की दिशा'), 'Fairly level',
          const L('A level line is read as steadiness, even moods and a practical outlook.', 'सीधी रेखा स्थिरता, संतुलित मूड और व्यावहारिक नज़रिये का संकेत मानी जाती है।'),
          const L('Add a small upward lift at the end if you want to show more drive.', 'ज़्यादा जोश दिखाना हो तो अंत में हल्की ऊपर की ओर उठान दीजिए।'), 1));
    } else {
      f.add(SigFinding(const L('Direction of the line', 'रेखा की दिशा'), 'Falls about ${_d(m.baselineDeg)} degrees',
          const L('A falling line is traditionally read as tiredness, caution or a low mood at the time of writing. It often changes with rest.',
              'गिरती रेखा को परंपरा में थकान, सतर्कता या लिखते समय उदास मन का संकेत माना जाता है। आराम के बाद यह अक्सर बदल जाती है।'),
          const L('Look after your sleep and rest, then sign again and compare.', 'नींद और आराम का ध्यान रखें, फिर दोबारा हस्ताक्षर करके तुलना करें।'), -1));
    }

    // pressure
    if (m.thickness > 0.07) {
      f.add(SigFinding(const L('Pressure and stroke', 'दबाव और लकीर'), 'Bold strokes',
          const L('Heavy, bold strokes are read as strong feelings, energy and determination. Very heavy pressure can also mean tension.',
              'भारी, गहरी लकीरें प्रबल भावनाओं, ऊर्जा और दृढ़ता का संकेत मानी जाती हैं। बहुत ज़्यादा दबाव तनाव भी हो सकता है।'),
          const L('Relax your grip now and then; strength does not need force.', 'बीच-बीच में पकड़ ढीली कीजिए; ताकत को ज़ोर की ज़रूरत नहीं।'), 0));
    } else if (m.thickness < 0.03) {
      f.add(SigFinding(const L('Pressure and stroke', 'दबाव और लकीर'), 'Fine, light strokes',
          const L('Light, fine strokes are read as sensitivity, refinement and a gentle nature, sometimes low physical energy.',
              'हल्की, पतली लकीरें संवेदनशीलता, परिष्कृत रुचि और कोमल स्वभाव का संकेत मानी जाती हैं, कभी-कभी कम शारीरिक ऊर्जा का भी।'),
          const L('Build stamina with sleep, food and exercise.', 'नींद, भोजन और व्यायाम से सहनशक्ति बढ़ाइए।'), 0));
    } else {
      f.add(SigFinding(const L('Pressure and stroke', 'दबाव और लकीर'), 'Medium strokes',
          const L('Medium pressure is read as a balance between feeling and control, with steady energy.', 'मध्यम दबाव भावना और नियंत्रण के संतुलन तथा स्थिर ऊर्जा का संकेत माना जाता है।'),
          const L('A good balance; keep it.', 'अच्छा संतुलन है; बनाए रखें।'), 1));
    }

    // size against handwriting
    switch (size) {
      case SizeVsHand.bigger:
        f.add(const SigFinding(L('Size', 'आकार'), 'Bigger than your handwriting',
            L('A signature larger than the writing is read as confidence and a wish to be noticed.', 'लेखन से बड़ा हस्ताक्षर आत्मविश्वास और ध्यान में आने की इच्छा का संकेत माना जाता है।'),
            L('Confidence is good. Make sure it is matched with listening.', 'आत्मविश्वास अच्छा है। उसके साथ सुनना भी जोड़ें।'), 1));
        break;
      case SizeVsHand.same:
        f.add(const SigFinding(L('Size', 'आकार'), 'Same as your handwriting',
            L('A signature the same size as the writing is read as a natural, consistent person.', 'लेखन जितना ही हस्ताक्षर स्वाभाविक और एकरूप व्यक्तित्व का संकेत माना जाता है।'),
            L('Nothing to change.', 'कुछ बदलने की ज़रूरत नहीं।'), 1));
        break;
      case SizeVsHand.smaller:
        f.add(const SigFinding(L('Size', 'आकार'), 'Smaller than your handwriting',
            L('A small signature is read as modest, focused and sometimes guarded, or shy of the limelight.', 'छोटा हस्ताक्षर विनम्र, एकाग्र और कभी-कभी संकोची या प्रसिद्धि से दूर रहने वाले स्वभाव का संकेत माना जाता है।'),
            L('Try signing a little larger on important papers to practise presence.', 'ज़रूरी कागज़ों पर थोड़ा बड़ा हस्ताक्षर करके अपनी उपस्थिति का अभ्यास करें।'), 0));
        break;
    }

    // readability and pieces
    final flow = m.pieces <= 2
        ? 'Flowing, joined letters'
        : (m.pieces <= 5 ? 'Some joined, some separate' : 'Many separate pieces');
    if (legibility == Legibility.unreadable) {
      f.add(SigFinding(const L('Readability', 'पढ़े जाने की स्थिति'), flow,
          const L('A scribble is traditionally read as a private person who is busy, quick or guards their identity.',
              'घसीट को परंपरा में निजी, व्यस्त, तेज़ या अपनी पहचान छिपाने वाले व्यक्ति का संकेत माना जाता है।'),
          const L('Make the first letter and the overall shape clearer on legal papers.', 'कानूनी कागज़ों पर पहला अक्षर और समग्र आकार साफ़ रखें।'), -1));
    } else if (legibility == Legibility.partly) {
      f.add(SigFinding(const L('Readability', 'पढ़े जाने की स्थिति'), flow,
          const L('A partly readable signature is read as a balance between being open and keeping some privacy.', 'कुछ हद तक पढ़ा जाने वाला हस्ताक्षर खुलेपन और थोड़ी निजता के संतुलन का संकेत माना जाता है।'),
          const L('A little more clarity helps others trust the name.', 'थोड़ी और स्पष्टता से लोग नाम पर ज़्यादा भरोसा करते हैं।'), 0));
    } else {
      f.add(SigFinding(const L('Readability', 'पढ़े जाने की स्थिति'), flow,
          const L('A clearly readable signature is read as openness, honesty and pride in your name.', 'साफ़ पढ़ा जाने वाला हस्ताक्षर खुलेपन, ईमानदारी और अपने नाम पर गर्व का संकेत माना जाता है।'),
          const L('Good; this builds trust.', 'अच्छा है; इससे भरोसा बनता है।'), 1));
    }
    if (m.pieces <= 2) {
      f.add(const SigFinding(L('Connected writing', 'जुड़ा हुआ लेखन'), 'Letters flow together',
          L('Joined letters are read as quick, logical thinking that links one idea to the next.', 'जुड़े अक्षर तेज़, तार्किक सोच का संकेत माने जाते हैं जो एक विचार को अगले से जोड़ती है।'),
          L('Take care of details when you rush.', 'जल्दबाज़ी में ब्योरों का ध्यान रखें।'), 1));
    } else if (m.pieces > 5) {
      f.add(const SigFinding(L('Connected writing', 'जुड़ा हुआ लेखन'), 'Letters stand apart',
          L('Separate letters are read as a careful, detail-minded and intuitive person who stops to think between steps.', 'अलग-अलग अक्षर सावधान, ब्योरे पर ध्यान देने वाले और सहज-बोध वाले व्यक्ति का संकेत माने जाते हैं जो कदमों के बीच रुककर सोचता है।'),
          L('Trust your first impression a little more.', 'अपनी पहली धारणा पर थोड़ा और भरोसा कीजिए।'), 0));
    }

    // first letter
    if (m.bigInitial) {
      f.add(const SigFinding(L('First letter', 'पहला अक्षर'), 'Much taller than the rest',
          L('A large first letter is read as pride in your identity, family name or position.', 'बड़ा पहला अक्षर अपनी पहचान, परिवार के नाम या पद पर गर्व का संकेत माना जाता है।'),
          L('Healthy pride; add humility with the people you lead.', 'स्वस्थ गर्व है; जिन्हें आप नेतृत्व देते हैं उनके साथ विनम्रता जोड़ें।'), 1));
    }

    // underline
    if (m.underline) {
      f.add(const SigFinding(L('Underline', 'रेखांकन'), 'A long line under the name',
          L('An underline is read as self-worth, a wish for recognition and sometimes a need to stress your value.', 'नीचे की रेखा आत्म-मूल्य, पहचान की चाह और कभी-कभी अपना महत्व जताने की ज़रूरत का संकेत मानी जाती है।'),
          L('One calm line is fine; avoid heavy double lines.', 'एक शांत रेखा ठीक है; भारी दोहरी रेखाओं से बचें।'), 0));
    }

    // end dot
    if (m.endDot) {
      f.add(const SigFinding(L('Dot at the end', 'अंत में बिंदु'), 'A dot after the name',
          L('A full stop after the signature is read as a careful person who likes to close matters properly.', 'हस्ताक्षर के बाद बिंदु सावधान व्यक्ति का संकेत माना जाता है जो मामलों को ठीक से बंद करना पसंद करता है।'),
          L('Keep it, and do not let caution turn into delay.', 'इसे रखिए, और सावधानी को देरी में न बदलने दीजिए।'), 1));
    }

    // ending
    if (m.endRise > 0.06) {
      f.add(const SigFinding(L('Ending', 'अंत'), 'The signature ends higher',
          L('An ending that lifts is read as hope and a forward look.', 'ऊपर उठता अंत आशा और आगे की ओर देखने का संकेत माना जाता है।'),
          L('Good sign; keep the lift.', 'अच्छा संकेत है; उठान बनाए रखें।'), 1));
    } else if (m.endRise < -0.06) {
      f.add(const SigFinding(L('Ending', 'अंत'), 'The signature ends lower',
          L('An ending that drops is read as holding back, tiredness or closing down towards the end of tasks.', 'नीचे गिरता अंत पीछे हटने, थकान या काम के अंत में सिमटने का संकेत माना जाता है।'),
          L('Finish tasks with a clear final step so energy does not fade.', 'काम को साफ़ अंतिम कदम के साथ खत्म करें ताकि ऊर्जा फीकी न पड़े।'), 0));
    }

    // shape
    if (m.aspect > 4.5) {
      f.add(const SigFinding(L('Shape', 'बनावट'), 'Long and wide',
          L('A long, spread-out signature is read as an outgoing person who needs space and moves fast.', 'लंबा, फैला हुआ हस्ताक्षर मिलनसार व्यक्ति का संकेत माना जाता है जिसे जगह चाहिए और जो तेज़ चलता है।'),
          L('Give yourself time to complete one thing before the next.', 'अगला शुरू करने से पहले एक काम पूरा करने का समय दें।'), 0));
    } else if (m.aspect < 2.0) {
      f.add(const SigFinding(L('Shape', 'बनावट'), 'Compact',
          L('A compact signature is read as concentrated, private and disciplined.', 'सघन हस्ताक्षर एकाग्र, निजी और अनुशासित व्यक्ति का संकेत माना जाता है।'),
          L('Make room to share your plans.', 'अपनी योजनाएँ बाँटने की जगह बनाइए।'), 0));
    }
    if (m.density > 0.35) {
      f.add(const SigFinding(L('Fullness', 'भराव'), 'Dense and crowded',
          L('A dense, crowded signature is read as a busy mind with many thoughts at once.', 'घना, भरा हस्ताक्षर कई विचारों वाले व्यस्त मन का संकेत माना जाता है।'),
          L('Simplify one thing in your day.', 'अपने दिन की एक चीज़ को सरल कीजिए।'), 0));
    } else if (m.density < 0.12) {
      f.add(const SigFinding(L('Fullness', 'भराव'), 'Light and simple',
          L('A simple, open signature is read as a straightforward and uncluttered mind.', 'सरल, खुला हस्ताक्षर सीधे और सुलझे मन का संकेत माना जाता है।'),
          L('Nothing to change.', 'कुछ बदलने की ज़रूरत नहीं।'), 1));
    }

    // number of the signed name
    SigNumber? number;
    final n = name.trim();
    if (n.isNotEmpty) {
      final r = NumerologyEngine.name(n);
      if (r.total > 0) {
        final root = r.root;
        number = SigNumber(
          r.total,
          root,
          mulank == null ? Relation.neutral : NumerologyTools.relation(root, mulank),
          bhagyank == null ? Relation.neutral : NumerologyTools.relation(root, bhagyank),
          HeavyNumbers.isHeavy(r.total),
        );
      }
    }
    return SignatureReading(f, number);
  }

  static L relationLine(SigNumber n) {
    final bad = n.withMulank == Relation.enemy || n.withBhagyank == Relation.enemy;
    final good = n.withMulank == Relation.friend || n.withBhagyank == Relation.friend;
    if (n.heavy) {
      return L('The total ${n.total} is on the heavy-number list. A nearby spelling with a lighter total may feel smoother; try Name Correction.',
          'कुल अंक ${n.total} भारी अंकों की सूची में है। हल्के कुल अंक वाली पास की स्पेलिंग ज़्यादा सहज लग सकती है; नाम सुधार आज़माइए।');
    }
    if (bad && !good) {
      return L('The name number ${n.root} is opposed to your own numbers. Try small spelling changes in Name Correction.',
          'नाम का अंक ${n.root} आपके अपने अंकों का विरोधी है। नाम सुधार में छोटे स्पेलिंग बदलाव आज़माइए।');
    }
    if (good && !bad) {
      return L('The name number ${n.root} is friendly with your Mulank or Bhagyank. A good match.',
          'नाम का अंक ${n.root} आपके मूलांक या भाग्यांक का मित्र है। अच्छा मेल।');
    }
    return L('The name number ${n.root} is neutral with your numbers. It neither helps nor opposes.',
        'नाम का अंक ${n.root} आपके अंकों के साथ सम है। न मदद करता है, न विरोध।');
  }
}
