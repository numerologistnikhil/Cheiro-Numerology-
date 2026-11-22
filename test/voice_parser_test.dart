import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/voice_parser.dart';

void main() {
  test('english sentence', () {
    final r = VoiceParser.parse(
        'My name is Rahul Sharma, born on 15 August 1990, mobile 98765 43210');
    expect(r.name, 'Rahul Sharma');
    expect(r.dob, DateTime(1990, 8, 15));
    expect(r.mobile, '9876543210');
  });

  test('numeric date, day first', () {
    final r = VoiceParser.parse('my name is priya verma dob 05/11/1985');
    expect(r.name, 'Priya Verma');
    expect(r.dob, DateTime(1985, 11, 5));
    expect(r.mobile, '');
  });

  test('hinglish', () {
    final r = VoiceParser.parse(
        'mera naam Amit Kumar hai meri janm tithi 3 march 1992 hai');
    expect(r.name, 'Amit Kumar');
    expect(r.dob, DateTime(1992, 3, 3));
  });

  test('hindi script and digits', () {
    final r = VoiceParser.parse('मेरा नाम राहुल शर्मा है जन्म १५ अगस्त १९९० मोबाइल ९८७६५४३२१०');
    expect(r.dob, DateTime(1990, 8, 15));
    expect(r.mobile, '9876543210');
    expect(r.name, 'Rahul Sharma');
  });

  test('a date is not taken as mobile', () {
    final r = VoiceParser.parse('name is Sita 8 8 1990');
    expect(r.mobile, '');
    expect(r.dob, DateTime(1990, 8, 8));
  });

  test('future and impossible dates are rejected', () {
    expect(VoiceParser.parse('born 31 february 1990').dob, isNull);
    expect(VoiceParser.parse('born 1 january 2999').dob, isNull);
  });

  test('empty and nonsense', () {
    expect(VoiceParser.parse('').isEmpty, true);
    expect(VoiceParser.parse('hello how are you').dob, isNull);
  });

  test('plus 91 prefix', () {
    expect(VoiceParser.parse('mobile +91 98765 43210').mobile, '9876543210');
  });
}
