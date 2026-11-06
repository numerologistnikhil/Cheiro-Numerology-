import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/app_style.dart';

void main() {
  test('Western tile is hidden only for Chaldean style', () {
    final s = AppStyle.instance;
    expect(s.showsTile('western'), isTrue); // default: both
    expect(s.showsTile('gems'), isTrue);
  });

  test('every style has a name and a note', () {
    for (final v in NumerologyStyle.values) {
      expect(StyleTexts.names[v]!.hi.isNotEmpty, isTrue);
      expect(StyleTexts.notes[v]!.en.isNotEmpty, isTrue);
    }
  });
}
