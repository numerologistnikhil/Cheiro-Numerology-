import 'root_profiles.dart' show L;

class FeedbackTexts {
  static const L title = L('Suggestions and feedback', 'सुझाव और प्रतिक्रिया');
  static const L subtitle = L('Tell us what to improve', 'बताइए क्या बेहतर करें');
  static const L intro = L(
    'Your idea, a problem you found, or a word of thanks: all of it is read, and it helps us improve the app and the report. Please do not write passwords or private details.',
    'आपका कोई विचार, कोई समस्या, या धन्यवाद के दो शब्द: सब पढ़ा जाता है और इससे ऐप और रिपोर्ट बेहतर बनती है। कृपया पासवर्ड या निजी जानकारी मत लिखिए।',
  );
  static const L typeLabel = L('What is this about?', 'यह किस बारे में है?');
  static const List<L> types = [
    L('A new idea', 'नया सुझाव'),
    L('A problem', 'कोई समस्या'),
    L('Report content', 'रिपोर्ट की बातें'),
    L('Thanks', 'धन्यवाद'),
  ];
  static const List<String> typeValues = ['Idea', 'Problem', 'Report', 'Thanks'];
  static const L messageLabel = L('Your message', 'आपका संदेश');
  static const L ratingLabel = L('How do you feel about the app? (optional)', 'ऐप आपको कैसा लगा? (ज़रूरी नहीं)');
  static const L contactLabel = L('Your email or phone, only if you want a reply (optional)', 'आपका ईमेल या फ़ोन, सिर्फ़ अगर जवाब चाहिए (ज़रूरी नहीं)');
  static const L send = L('Send', 'भेजिए');
  static const L sending = L('Sending...', 'भेज रहे हैं...');
  static const L thanks = L('Thank you! Your message has been sent.', 'धन्यवाद! आपका संदेश भेज दिया गया है।');
  static const L tooShort = L('Please write a few words first.', 'कृपया पहले कुछ शब्द लिखिए।');
  static const L failed = L('Could not send. Please check your internet and try again.', 'भेज नहीं सके। कृपया इंटरनेट देखिए और फिर कोशिश कीजिए।');
  static const L notConnected = L(
    'Feedback is not connected in this test version yet.',
    'इस टेस्ट वर्ज़न में फ़ीडबैक अभी जुड़ा नहीं है।',
  );
}
