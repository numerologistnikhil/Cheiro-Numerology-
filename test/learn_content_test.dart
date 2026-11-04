import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/learn_content.dart';

void main() {
  test('lessons are complete, bilingual and have unique ids', () {
    final ids = <String>{};
    for (final l in LearnContent.lessons) {
      expect(ids.add(l.id), isTrue, reason: l.id);
      expect([1, 2, 3].contains(l.level), isTrue);
      for (final t in [l.title, l.gist, l.body, l.tryIt]) {
        expect(t.en.trim().isNotEmpty, isTrue, reason: l.id);
        expect(t.hi.trim().isNotEmpty, isTrue, reason: l.id);
      }
    }
    expect(LearnContent.lessons.length >= 20, isTrue);
  });

  test('each level has lessons', () {
    for (var lv = 1; lv <= 3; lv++) {
      expect(LearnContent.lessons.any((l) => l.level == lv), isTrue);
    }
  });
}
