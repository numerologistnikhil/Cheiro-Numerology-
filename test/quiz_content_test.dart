import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/quiz_content.dart';

void main() {
  test('quiz questions are bilingual with a valid answer index', () {
    expect(QuizContent.questions.length >= 20, isTrue);
    for (final q in QuizContent.questions) {
      expect(q.options.length >= 2, isTrue);
      expect(q.answer >= 0 && q.answer < q.options.length, isTrue);
      expect(q.question.en.isNotEmpty && q.question.hi.isNotEmpty, isTrue);
      expect(q.explanation.en.isNotEmpty && q.explanation.hi.isNotEmpty, isTrue);
      for (final o in q.options) {
        expect(o.en.isNotEmpty && o.hi.isNotEmpty, isTrue);
      }
    }
  });
}
