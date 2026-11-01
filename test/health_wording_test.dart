import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/month_details.dart';
import 'package:cheiro_numerology/core/root_profiles.dart';
import 'package:cheiro_numerology/core/year_details.dart';

const _banned = [
  'blood pressure', 'blood sugar', 'throat', 'joint', 'kidney', 'liver',
  'heart', 'spine', 'lung', 'skin', 'stomach', 'headache', 'diabet',
  'nerves', 'bones', 'knees', 'teeth', 'eyes', 'reproductive',
];

void _check(String where, String text) {
  final low = text.toLowerCase();
  for (final w in _banned) {
    expect(low.contains(w), isFalse, reason: '$where mentions "$w"');
  }
}

void main() {
  test('health lines use general wellbeing words, never body parts or diseases', () {
    for (final e in RootProfiles.profiles.entries) {
      _check('root ${e.key}', e.value.health.en);
      expect(e.value.health.en.contains('see a doctor'), isTrue);
    }
    for (final e in MonthDetails.all.entries) {
      _check('month ${e.key}', e.value.health.t(false));
    }
    for (final e in YearDetails.extra.entries) {
      _check('year ${e.key}', e.value.health.t(false));
    }
  });
}
