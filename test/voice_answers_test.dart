import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/voice_answers.dart';

void main() {
  final dob = DateTime(1990, 8, 15);
  final now = DateTime(2026, 11, 22);

  test('topics are found in English, Hinglish and Hindi', () {
    expect(VoiceAnswers.topicOf('what is my lucky number'), VoiceTopic.luckyNumber);
    expect(VoiceAnswers.topicOf('mera shubh ank batao'), VoiceTopic.luckyNumber);
    expect(VoiceAnswers.topicOf('इस साल क्या होगा'), VoiceTopic.thisYear);
    expect(VoiceAnswers.topicOf('is mahine kaisa rahega'), VoiceTopic.thisMonth);
    expect(VoiceAnswers.topicOf('kya savdhani rakhni chahiye'), VoiceTopic.precaution);
    expect(VoiceAnswers.topicOf('my lucky colour'), VoiceTopic.colour);
    expect(VoiceAnswers.topicOf('hello'), VoiceTopic.overview);
  });

  test('mulank and bhagyank', () {
    expect(VoiceAnswers.mulank(dob), 6);
    expect(VoiceAnswers.bhagyank(dob), 6); // 1+5+8+1+9+9+0 = 33 -> 6
  });

  test('every topic gives a non-empty answer in both languages', () {
    for (final topic in VoiceTopic.values) {
      for (final q in const [
        'lucky number', 'is saal', 'is mahine', 'savdhani', 'colour', 'din',
        'ratna', 'career', 'paisa', 'pyar', 'sehat', 'mulank', 'xyz',
      ]) {
        for (final hi in [false, true]) {
          final a = VoiceAnswers.answer(q, dob, now, hindi: hi);
          expect(a.spoken.trim().isNotEmpty, true, reason: '$q $hi $topic');
        }
      }
    }
  });

  test('first sentences', () {
    expect(VoiceAnswers.firstSentences('One. Two. Three.', 2), 'One. Two.');
    expect(VoiceAnswers.firstSentences('एक। दो। तीन।', 1), 'एक।');
  });
}
