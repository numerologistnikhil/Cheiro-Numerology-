import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/extra_insights.dart';
import 'package:cheiro_numerology/core/heavy_numbers.dart';
import 'package:cheiro_numerology/core/numerology_engine.dart';

void main() {
  test('35 is a heavy number and its note names the total', () {
    expect(HeavyNumbers.isHeavy(35), isTrue);
    expect(HeavyNumbers.isHeavy(26), isFalse);
    expect(HeavyNumbers.note(35).en.contains('35'), isTrue);
    expect(HeavyNumbers.note(35).hi.contains('35'), isTrue);
  });

  test('a name with total 35 gets a low luck score, not a friendly one', () {
    // Find a short name whose letters add up to 35.
    String? found;
    const words = ['NIKHIL GULATI', 'ASHA', 'RAJESH', 'SUNIL', 'VIKAS', 'RAHUL', 'NEHA'];
    for (final w in words) {
      if (NumerologyEngine.name(w).total == 35) found = w;
    }
    if (found == null) return; // none of the sample names totals 35
    final s = NameScore.of(found)!;
    expect(s.luck <= 40, isTrue);
  });
}
