import 'package:flutter_test/flutter_test.dart';
import 'package:cheiro_numerology/core/signature_analysis.dart';

/// A tiny canvas to draw test signatures on.
class Canvas2 {
  final int w, h;
  final List<int> px;
  Canvas2(this.w, this.h) : px = List<int>.filled(w * h, 0);

  void dot(int x, int y, int r) {
    for (var dy = -r; dy <= r; dy++) {
      for (var dx = -r; dx <= r; dx++) {
        final xx = x + dx, yy = y + dy;
        if (xx >= 0 && xx < w && yy >= 0 && yy < h) px[yy * w + xx] = 1;
      }
    }
  }

  void line(int x0, int y0, int x1, int y1, {int r = 1}) {
    final n = (x1 - x0).abs() > (y1 - y0).abs() ? (x1 - x0).abs() : (y1 - y0).abs();
    for (var i = 0; i <= n; i++) {
      final t = n == 0 ? 0.0 : i / n;
      dot((x0 + (x1 - x0) * t).round(), (y0 + (y1 - y0) * t).round(), r);
    }
  }
}

void main() {
  test('blank page gives no result', () {
    expect(SignatureAnalyzer.analyze(List<int>.filled(100 * 50, 0), 100, 50), isNull);
  });

  test('right-leaning strokes give a positive slant, left-leaning negative', () {
    final r = Canvas2(300, 120);
    for (var i = 0; i < 6; i++) {
      r.line(40 + i * 35, 100, 70 + i * 35, 20); // leans right
    }
    final a = SignatureAnalyzer.analyze(r.px, r.w, r.h)!;
    expect(a.slantDeg > 12, isTrue, reason: 'slant ${a.slantDeg}');

    final l = Canvas2(300, 120);
    for (var i = 0; i < 6; i++) {
      l.line(70 + i * 35, 100, 40 + i * 35, 20); // leans left
    }
    final b = SignatureAnalyzer.analyze(l.px, l.w, l.h)!;
    expect(b.slantDeg < -12, isTrue, reason: 'slant ${b.slantDeg}');
  });

  test('upright strokes give a slant close to zero', () {
    final c = Canvas2(300, 120);
    for (var i = 0; i < 6; i++) {
      c.line(40 + i * 35, 100, 40 + i * 35, 20);
    }
    final a = SignatureAnalyzer.analyze(c.px, c.w, c.h)!;
    expect(a.slantDeg.abs() < 6, isTrue, reason: 'slant ${a.slantDeg}');
  });

  test('rising and falling lines', () {
    final up = Canvas2(300, 150);
    up.line(20, 120, 280, 40);
    expect(SignatureAnalyzer.analyze(up.px, up.w, up.h)!.baselineDeg > 8, isTrue);
    final down = Canvas2(300, 150);
    down.line(20, 40, 280, 120);
    expect(SignatureAnalyzer.analyze(down.px, down.w, down.h)!.baselineDeg < -8, isTrue);
    final flat = Canvas2(300, 150);
    flat.line(20, 80, 280, 80, r: 3);
    expect(SignatureAnalyzer.analyze(flat.px, flat.w, flat.h)!.baselineDeg.abs() < 3, isTrue);
  });

  test('underline is found under a short word', () {
    final c = Canvas2(300, 120);
    for (var i = 0; i < 4; i++) {
      c.line(60 + i * 20, 70, 60 + i * 20, 30);
    }
    c.line(40, 100, 270, 100); // long underline
    expect(SignatureAnalyzer.analyze(c.px, c.w, c.h)!.underline, isTrue);

    final n = Canvas2(300, 120);
    for (var i = 0; i < 4; i++) {
      n.line(60 + i * 20, 90, 60 + i * 20, 30);
    }
    expect(SignatureAnalyzer.analyze(n.px, n.w, n.h)!.underline, isFalse);
  });

  test('pieces and end dot', () {
    final c = Canvas2(400, 120);
    c.line(30, 100, 30, 20, r: 2); // tall first letter
    c.line(80, 90, 80, 50, r: 2);
    c.line(130, 90, 130, 50, r: 2);
    c.line(180, 90, 180, 50, r: 2);
    c.dot(370, 90, 2); // dot at the end
    final a = SignatureAnalyzer.analyze(c.px, c.w, c.h)!;
    expect(a.pieces, 4);
    expect(a.endDot, isTrue);
    expect(a.bigInitial, isTrue);
  });

  test('thick strokes measure thicker than thin ones', () {
    final thin = Canvas2(300, 120);
    thin.line(30, 60, 270, 60, r: 0);
    thin.line(60, 20, 60, 100, r: 0);
    final thick = Canvas2(300, 120);
    thick.line(30, 60, 270, 60, r: 4);
    thick.line(60, 20, 60, 100, r: 4);
    final a = SignatureAnalyzer.analyze(thin.px, thin.w, thin.h)!;
    final b = SignatureAnalyzer.analyze(thick.px, thick.w, thick.h)!;
    expect(b.thickness > a.thickness * 2, isTrue);
  });
}
