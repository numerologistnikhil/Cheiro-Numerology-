import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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

  /// A real photo from assets/images (if the owner added one), cut to a
  /// round picture. Returns null when there is no such photo.
  static Future<Uint8List?> _photo(String name, double size) async {
    try {
      final data = await rootBundle.load('assets/images/$name');
      final px = (size * 3).round();
      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: px * 2,
      );
      final img = (await codec.getNextFrame()).image;
      final side = math.min(img.width, img.height).toDouble();
      final src = Rect.fromLTWH(
          (img.width - side) / 2, (img.height - side) / 2, side, side);
      final dst = Rect.fromLTWH(0, 0, px.toDouble(), px.toDouble());
      final rec = ui.PictureRecorder();
      final canvas = Canvas(rec);
      canvas.save();
      canvas.clipPath(Path()..addOval(dst));
      canvas.drawImageRect(img, src, dst, Paint()..filterQuality = FilterQuality.high);
      canvas.restore();
      canvas.drawOval(
        dst.deflate(px * 0.01),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = px * 0.02
          ..color = const Color(0xFFC9A24A),
      );
      final out = await rec.endRecording().toImage(px, px);
      final bytes = await out.toByteData(format: ui.ImageByteFormat.png);
      return bytes!.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  static Future<Uint8List> gem(GemInfo g, {double size = 100}) async {
    final key = 'g${g.id}$size';
    final hit = _cache[key];
    if (hit != null) return hit;
    final photo = await _photo('gem_${g.id}.jpg', size);
    return _cache[key] = photo ?? await _png(GemPainter(g.color, g.shape), size);
  }

  static Future<Uint8List> rudraksha(int mukhi, {double size = 100}) async {
    final key = 'r$mukhi$size';
    final hit = _cache[key];
    if (hit != null) return hit;
    final photo = await _photo('rudraksha_$mukhi.jpg', size);
    return _cache[key] = photo ?? await _png(RudrakshaPainter(mukhi), size);
  }

  static Future<Uint8List> medallion(int n, Color c, {double size = 100}) async =>
      _cache['m$n${c.hashCode}$size'] ??= await _png(MedallionPainter(n, c), size);
}
