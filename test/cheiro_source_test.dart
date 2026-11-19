import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/cheiro_source.dart';

void main() {
  test('every compound number 10 to 52 except 51 has a Cheiro verdict', () {
    for (var n = 10; n <= 52; n++) {
      if (n == 51) continue;
      expect(CheiroSource.verdict(n), isNotNull, reason: '$n');
      expect(CheiroSource.note(n), isNotNull, reason: '$n');
    }
  });

  test('numbers above 31 follow the lower number Cheiro names', () {
    expect(CheiroSource.verdict(35), CheiroSource.verdict(26));
    expect(CheiroSource.verdict(44), CheiroVerdict.unfortunate);
    expect(CheiroSource.verdict(33), CheiroVerdict.fortunate);
    expect(CheiroSource.note(35)!.en.contains('26'), isTrue);
  });
}
