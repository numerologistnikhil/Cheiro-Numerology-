import 'package:flutter_test/flutter_test.dart';
import '../lib/core/angel_numbers.dart';

void main() {
  final dob = DateTime(1988, 4, 6);

  test('birth numbers for 06-04-1988', () {
    expect(AngelNumbers.mulank(dob), 6);
    expect(AngelNumbers.bhagyank(dob), 9);
    expect(AngelNumbers.personalYear(dob, 2026), 2);
  });

  test('digit count in DOB', () {
    expect(AngelNumbers.digitCountInDob(dob, 8), 2);
    expect(AngelNumbers.digitCountInDob(dob, 0), 2);
    expect(AngelNumbers.digitCountInDob(dob, 5), 0);
  });

  test('all angel numbers have full text in both languages', () {
    expect(AngelNumbers.all.length, 12);
    for (final a in AngelNumbers.all) {
      for (final hi in [false, true]) {
        expect(a.title(hi).isNotEmpty, true);
        expect(a.meaning(hi).length > 40, true);
        expect(a.message(hi).length > 40, true);
        expect(a.love(hi).length > 40, true);
        expect(a.career(hi).length > 40, true);
        expect(a.action(hi).length > 20, true);
      }
    }
  });

  test('DOB links: 666 and 999 are strong for this DOB', () {
    final links = AngelNumbers.linksForDob(dob, 2026);
    final l666 = links.firstWhere((l) => l.angel.number == '666');
    final l999 = links.firstWhere((l) => l.angel.number == '999');
    final l1111 = links.firstWhere((l) => l.angel.number == '1111');
    expect(l666.strength, 2);
    expect(l999.strength, 2);
    expect(l1111.strength, 0);
  });

  test('paragraph builds in both languages', () {
    expect(AngelNumbers.dobParagraph(dob, 2026, false).contains('Mulank 6'), true);
    expect(AngelNumbers.dobParagraph(dob, 2026, true).contains('मूलांक 6'), true);
  });
}
