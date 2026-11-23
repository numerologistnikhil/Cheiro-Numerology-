import 'cheiro_timing.dart';
import 'lucky_kit.dart';
import 'root_profiles.dart';

/// What a spoken question is about.
enum VoiceTopic {
  luckyNumber,
  thisYear,
  thisMonth,
  precaution,
  colour,
  luckyDay,
  gemstone,
  career,
  money,
  love,
  health,
  myNumbers,
  overview,
}

class VoiceAnswer {
  final VoiceTopic topic;
  final String title;

  /// Short text, good to read aloud.
  final String spoken;
  const VoiceAnswer(this.topic, this.title, this.spoken);
}

/// Answers spoken questions from the app's own tables. No internet, no AI:
/// it looks for key words and reads out the matching part of the person's
/// own numbers. It is guidance on mood and planning, not a prediction.
class VoiceAnswers {
  VoiceAnswers._();

  static const Map<VoiceTopic, List<String>> _keys = {
    VoiceTopic.luckyNumber: [
      'lucky number', 'lucky no', 'lucky ank', 'shubh ank', 'shubh number',
      'luckynumber', 'लकी नंबर', 'लकी नम्बर', 'शुभ अंक', 'शुभ नंबर', 'भाग्यशाली',
    ],
    VoiceTopic.precaution: [
      'precaution', 'savdhani', 'sawdhani', 'careful', 'avoid', 'bachna',
      'bachne', 'dhyan', 'takleef', 'problem', 'सावधानी', 'ध्यान', 'बचना',
      'परहेज़', 'परहेज',
    ],
    VoiceTopic.thisMonth: [
      'this month', 'is month', 'is mahine', 'mahina', 'mahine', 'इस महीने',
      'महीना', 'महीने',
    ],
    VoiceTopic.thisYear: [
      'this year', 'is saal', 'is sal', 'saal', 'varsh', 'year', 'future',
      'kya hoga', 'भविष्य', 'इस साल', 'साल', 'वर्ष', 'क्या होगा',
    ],
    VoiceTopic.colour: ['colour', 'color', 'rang', 'रंग'],
    VoiceTopic.luckyDay: [
      'lucky day', 'which day', 'konsa din', 'kaun sa din', 'shubh din', 'din',
      'वार', 'दिन',
    ],
    VoiceTopic.gemstone: [
      'gem', 'stone', 'ratna', 'ratn', 'pukhraj', 'moonga', 'neelam', 'रत्न',
      'पुखराज', 'नीलम', 'मोती',
    ],
    VoiceTopic.career: [
      'career', 'job', 'business', 'naukri', 'vyapar', 'profession', 'kaam',
      'करियर', 'नौकरी', 'व्यापार', 'बिज़नेस', 'काम',
    ],
    VoiceTopic.money: [
      'money', 'paisa', 'paise', 'dhan', 'income', 'kamai', 'पैसा', 'पैसे',
      'धन', 'कमाई',
    ],
    VoiceTopic.love: [
      'love', 'pyar', 'shaadi', 'shadi', 'marriage', 'relationship', 'rishta',
      'प्यार', 'प्रेम', 'शादी', 'रिश्ता', 'विवाह',
    ],
    VoiceTopic.health: [
      'health', 'sehat', 'swasthya', 'bimari', 'सेहत', 'स्वास्थ्य', 'बीमारी',
    ],
    VoiceTopic.myNumbers: [
      'mulank', 'bhagyank', 'my number', 'mera number', 'मूलांक', 'भाग्यांक',
      'मेरा अंक', 'मेरा नंबर',
    ],
  };

  /// Finds the topic. Earlier entries in [_keys] win, so "lucky number" is
  /// not mistaken for "number" or "day".
  static VoiceTopic topicOf(String question) {
    final q = question.toLowerCase();
    for (final e in _keys.entries) {
      for (final k in e.value) {
        if (q.contains(k)) return e.key;
      }
    }
    return VoiceTopic.overview;
  }

  /// The first [n] sentences, so that the voice does not read a whole page.
  static String firstSentences(String text, [int n = 2]) {
    final parts = RegExp(r'[^.।!?]+[.।!?]?')
        .allMatches(text.trim())
        .map((m) => m.group(0)!.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    return parts.take(n).join(' ');
  }

  static int mulank(DateTime dob) => CheiroTiming.root(dob.day);

  static int bhagyank(DateTime dob) => CheiroTiming.root(
      CheiroTiming.digitSum(dob.day) +
          CheiroTiming.digitSum(dob.month) +
          CheiroTiming.digitSum(dob.year));

  static VoiceAnswer answer(String question, DateTime dob, DateTime now,
      {required bool hindi}) {
    final topic = topicOf(question);
    final m = mulank(dob);
    final b = bhagyank(dob);
    final p = RootProfiles.of(m);
    String t(L l) => l.t(hindi);
    String join(List<String> parts) =>
        parts.where((s) => s.isNotEmpty).join(' ');

    switch (topic) {
      case VoiceTopic.luckyNumber: {
        final picks = LuckyKit.luckyNumbers(m, b, count: 4)
            .map((x) => '${x.number}')
            .join(', ');
        final avoid = LuckyKit.avoidRoots(m, b).join(', ');
        return VoiceAnswer(
          topic,
          hindi ? 'आपके शुभ अंक' : 'Your lucky numbers',
          hindi
              ? 'आपका मूलांक $m और भाग्यांक $b है। आपके शुभ अंक हैं: $picks।'
                  '${avoid.isEmpty ? '' : ' इन मूल अंकों वाली संख्याओं से थोड़ा सावधान रहें: $avoid।'}'
              : 'Your Mulank is $m and your Bhagyank is $b. Your lucky numbers are: $picks.'
                  '${avoid.isEmpty ? '' : ' Be a little careful with numbers that reduce to: $avoid.'}',
        );
      }
      case VoiceTopic.thisYear: {
        final y = CheiroTiming.year(dob, now.year, m, b);
        return VoiceAnswer(
          topic,
          hindi ? 'आपका ${now.year}' : 'Your ${now.year}',
          join([
            hindi
                ? '${now.year} में आपका वर्ष अंक ${y.root} है।'
                : 'Your year number for ${now.year} is ${y.root}.',
            t(CheiroTiming.rootTone[y.root]!),
            t(CheiroTiming.moodLine[y.mood]!),
            t(CheiroTiming.closing),
          ]),
        );
      }
      case VoiceTopic.thisMonth: {
        final x = CheiroTiming.month(dob, now.year, now.month, m, b);
        return VoiceAnswer(
          topic,
          hindi ? 'यह महीना' : 'This month',
          join([
            hindi
                ? 'इस महीने का अंक ${x.root} है।'
                : 'The number for this month is ${x.root}.',
            t(CheiroTiming.rootTone[x.root]!),
            t(CheiroTiming.moodLine[x.mood]!),
          ]),
        );
      }
      case VoiceTopic.precaution: {
        final y = CheiroTiming.year(dob, now.year, m, b);
        final avoid = LuckyKit.avoidRoots(m, b).join(', ');
        return VoiceAnswer(
          topic,
          hindi ? 'सावधानियाँ' : 'Precautions',
          join([
            t(CheiroTiming.moodLine[y.mood]!),
            if (y.heavy) t(CheiroTiming.heavyNote),
            if (p != null) firstSentences(t(p.health), 2),
            if (avoid.isNotEmpty)
              hindi
                  ? 'बड़े फ़ैसलों में इन अंकों वाली तारीख़ें और नंबर टालें: $avoid।'
                  : 'For big decisions, avoid dates and numbers that reduce to: $avoid.',
          ]),
        );
      }
      case VoiceTopic.colour:
        return VoiceAnswer(topic, hindi ? 'शुभ रंग' : 'Lucky colours',
            p == null ? '' : '${t(p.colours)}.');
      case VoiceTopic.luckyDay:
        return VoiceAnswer(topic, hindi ? 'शुभ दिन' : 'Lucky days',
            p == null ? '' : '${t(p.luckyDays)}.');
      case VoiceTopic.gemstone:
        return VoiceAnswer(
            topic,
            hindi ? 'रत्न' : 'Gemstone',
            p == null
                ? ''
                : hindi
                    ? 'परंपरा के अनुसार: ${t(p.gemstone)}। रत्न पहनने से पहले किसी जानकार से सलाह लें।'
                    : 'Traditionally: ${t(p.gemstone)}. Take advice from a knowledgeable person before wearing a stone.');
      case VoiceTopic.career:
        return VoiceAnswer(topic, hindi ? 'करियर' : 'Career',
            p == null ? '' : firstSentences(t(p.career), 3));
      case VoiceTopic.money:
        return VoiceAnswer(topic, hindi ? 'पैसा' : 'Money',
            p == null ? '' : firstSentences(t(p.money), 3));
      case VoiceTopic.love:
        return VoiceAnswer(topic, hindi ? 'प्रेम और रिश्ते' : 'Love and relationships',
            p == null ? '' : firstSentences(t(p.love), 3));
      case VoiceTopic.health:
        return VoiceAnswer(topic, hindi ? 'सेहत' : 'Health',
            p == null ? '' : firstSentences(t(p.health), 3));
      case VoiceTopic.myNumbers:
      case VoiceTopic.overview:
        return VoiceAnswer(
          VoiceTopic.overview,
          hindi ? 'आपके अंक' : 'Your numbers',
          join([
            hindi
                ? 'आपका मूलांक $m और भाग्यांक $b है।'
                : 'Your Mulank is $m and your Bhagyank is $b.',
            if (p != null) firstSentences(t(p.overview), 2),
            hindi
                ? 'आप पूछ सकते हैं: शुभ अंक, इस साल, सावधानी, रंग, रत्न, करियर, पैसा, प्रेम या सेहत।'
                : 'You can ask: lucky number, this year, precautions, colour, gemstone, career, money, love or health.',
          ]),
        );
    }
  }
}
