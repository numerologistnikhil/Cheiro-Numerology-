import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../screens/gem_widgets.dart' show GemPainter;
import '../screens/rudraksha_screen.dart' show RudrakshaPainter;
import 'gemstone_guide.dart';

/// A gold medallion with a number in the middle, used as the picture for
/// career and health pages in the PDF.
class MedallionPainter extends CustomPainter {
  final int number;
  final Color color;
  const MedallionPainter(this.number, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2 * 0.92;
    final rect = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.35),
          colors: [
            const Color(0xFFFFF6D9),
            Color.lerp(const Color(0xFFF3DFA2), color, 0.25)!,
            Color.lerp(const Color(0xFFC9A24A), color, 0.35)!,
          ],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(rect),
    );
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF8A6A1F);
    canvas.drawCircle(c, r, ring..strokeWidth = size.shortestSide * 0.025);
    canvas.drawCircle(c, r * 0.8, ring..strokeWidth = size.shortestSide * 0.01);
    final tp = TextPainter(
      text: TextSpan(
        text: '$number',
        style: TextStyle(
          fontSize: size.shortestSide * 0.5,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF5A430F),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, c - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// Draws painters into PNG pictures for the PDF.
class PdfPictures {
  static Future<Uint8List> _png(CustomPainter p, double size) async {
    const scale = 3.0;
    final px = (size * scale).round();
    final rec = ui.PictureRecorder();
    final canvas = Canvas(rec);
    p.paint(canvas, Size(px.toDouble(), px.toDouble()));
    final img = await rec.endRecording().toImage(px, px);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  static final Map<String, Uint8List> _cache = <String, Uint8List>{};

  static Future<Uint8List> gem(GemInfo g, {double size = 100}) async =>
      _cache['g${g.id}$size'] ??= await _png(GemPainter(g.color, g.shape), size);

  static Future<Uint8List> rudraksha(int mukhi, {double size = 100}) async =>
      _cache['r$mukhi$size'] ??= await _png(RudrakshaPainter(mukhi), size);

  static Future<Uint8List> medallion(int n, Color c, {double size = 100}) async =>
      _cache['m$n${c.hashCode}$size'] ??= await _png(MedallionPainter(n, c), size);
}
