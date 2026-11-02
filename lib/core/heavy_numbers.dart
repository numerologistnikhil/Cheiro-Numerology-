import 'root_profiles.dart' show L;

/// Totals that many numerologists treat as "heavy": they are said to bring
/// delays and obstacles even when the root number looks friendly. This is an
/// owner-approved caution list (editorial, not a verified Cheiro text). Add a
/// number here to make the whole app treat it with the same care.
class HeavyNumbers {
  static const Set<int> totals = {35};

  static bool isHeavy(int total) => totals.contains(total);

  static L note(int total) => L(
        'Please note: the total $total is considered a heavy number by many numerologists. Even when the root number sits well with your birth number, a heavy total is traditionally said to bring delays, extra effort or obstacles before results come. A spelling with a lighter total may feel smoother. This is a traditional belief, not a certainty.',
        'ध्यान दीजिए: कई अंक-ज्योतिषी कुल अंक $total को भारी अंक मानते हैं। मूलांक आपके जन्म के अंक से मेल खाता हो, तब भी भारी कुल अंक के बारे में परंपरा कहती है कि नतीजे आने से पहले देरी, ज़्यादा मेहनत या रुकावटें आ सकती हैं। हल्के कुल अंक वाली वर्तनी ज़्यादा सहज लग सकती है। यह एक पारंपरिक मान्यता है, पक्की बात नहीं।',
      );
}
