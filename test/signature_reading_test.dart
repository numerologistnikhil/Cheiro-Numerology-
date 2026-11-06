import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/signature_analysis.dart';
import 'package:cheiro_numerology/core/signature_reading.dart';

SignatureMetrics m({double slant = 0, double base = 0, double thick = 0.05, int pieces = 3}) =>
    SignatureMetrics(
      slantDeg: slant,
      baselineDeg: base,
      aspect: 3,
      density: 0.2,
      thickness: thick,
      pieces: pieces,
      underline: false,
      endDot: false,
      bigInitial: false,
      endRise: 0,
    );

void main() {
  test('every finding is bilingual', () {
    final variants = [
      m(slant: 30, base: 10, thick: 0.1, pieces: 1),
      m(slant: 12, base: 0, thick: 0.05, pieces: 4),
      m(slant: 0, base: -10, thick: 0.01, pieces: 8),
      m(slant: -20),
    ];
    for (final v in variants) {
      for (final s in SizeVsHand.values) {
        for (final l in Legibility.values) {
          final r = SignatureReading.build(m: v, size: s, legibility: l, name: 'Annu', mulank: 6, bhagyank: 9);
          expect(r.findings.length >= 5, isTrue);
          for (final f in r.findings) {
            expect(f.title.en.isNotEmpty && f.title.hi.isNotEmpty, isTrue);
            expect(f.reading.en.isNotEmpty && f.reading.hi.isNotEmpty, isTrue);
            expect(f.tip.en.isNotEmpty && f.tip.hi.isNotEmpty, isTrue);
            expect(f.measured.isNotEmpty, isTrue);
          }
        }
      }
    }
  });

  test('slant wording follows the angle', () {
    String slantOf(double a) => SignatureReading.build(
            m: m(slant: a), size: SizeVsHand.same, legibility: Legibility.clear)
        .findings
        .first
        .reading
        .en;
    expect(slantOf(40).contains('strong right'), isTrue);
    expect(slantOf(15).contains('gentle right'), isTrue);
    expect(slantOf(0).contains('upright'), isTrue);
    expect(slantOf(-20).contains('left lean'), isTrue);
  });

  test('signed name number is worked out', () {
    final r = SignatureReading.build(
        m: m(), size: SizeVsHand.same, legibility: Legibility.clear, name: 'Annu', mulank: 6, bhagyank: 9);
    expect(r.number, isNotNull);
    expect(r.number!.total > 0, isTrue);
    expect(SignatureReading.relationLine(r.number!).hi.isNotEmpty, isTrue);
    final none = SignatureReading.build(m: m(), size: SizeVsHand.same, legibility: Legibility.clear);
    expect(none.number, isNull);
  });

  test('improvement tips are bilingual', () {
    for (final t in SignatureReading.improve) {
      expect(t.en.isNotEmpty && t.hi.isNotEmpty, isTrue);
    }
  });
}
