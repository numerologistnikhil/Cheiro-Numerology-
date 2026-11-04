import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/gemstone_guide.dart';

Color _shade(Color c, double delta) {
  final h = HSLColor.fromColor(c);
  return h.withLightness((h.lightness + delta).clamp(0.0, 1.0).toDouble()).toColor();
}

/// Draws a simple picture of a stone (not a photograph).
class GemPainter extends CustomPainter {
  final Color color;
  final GemShape shape;
  const GemPainter(this.color, this.shape);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2 * 0.92;
    final rect = Rect.fromCircle(center: c, radius: r);
    final fill = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.35),
        colors: [_shade(color, 0.28), color, _shade(color, -0.22)],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(rect);
    final edge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = _shade(color, -0.3);
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0x66FFFFFF);
    const shine = Color(0xAAFFFFFF);

    switch (shape) {
      case GemShape.faceted:
        final outer = <Offset>[];
        final inner = <Offset>[];
        for (var k = 0; k < 8; k++) {
          final a = (22.5 + 45 * k) * 3.1415926535 / 180;
          outer.add(Offset(c.dx + r * _cos(a), c.dy + r * _sin(a)));
          inner.add(Offset(c.dx + r * 0.5 * _cos(a), c.dy + r * 0.5 * _sin(a)));
        }
        final path = Path()..addPolygon(outer, true);
        canvas.drawPath(path, fill);
        canvas.drawPath(
          Path()..addPolygon(inner, true),
          Paint()..color = _shade(color, 0.12),
        );
        for (var k = 0; k < 8; k++) {
          canvas.drawLine(outer[k], inner[k], line);
          canvas.drawLine(inner[k], inner[(k + 1) % 8], line);
        }
        canvas.drawPath(Path()..addPolygon(inner, true), line);
        canvas.drawPath(path, edge);
        canvas.drawCircle(Offset(c.dx - r * 0.25, c.dy - r * 0.3), r * 0.09,
            Paint()..color = shine);
        break;
      case GemShape.round:
        canvas.drawCircle(c, r, fill);
        canvas.drawCircle(c, r, edge);
        canvas.drawOval(
          Rect.fromCenter(
              center: Offset(c.dx - r * 0.3, c.dy - r * 0.35),
              width: r * 0.5,
              height: r * 0.3),
          Paint()..color = shine,
        );
        break;
      case GemShape.oval:
        final o = Rect.fromCenter(center: c, width: r * 2, height: r * 1.45);
        canvas.drawOval(o, fill);
        canvas.drawOval(o, edge);
        canvas.drawOval(
          Rect.fromCenter(
              center: Offset(c.dx - r * 0.35, c.dy - r * 0.3),
              width: r * 0.55,
              height: r * 0.28),
          Paint()..color = shine,
        );
        break;
      case GemShape.catsEye:
        final o = Rect.fromCenter(center: c, width: r * 2, height: r * 1.45);
        canvas.drawOval(o, fill);
        canvas.drawOval(o, edge);
        canvas.drawLine(
          Offset(c.dx, c.dy - r * 0.62),
          Offset(c.dx, c.dy + r * 0.62),
          Paint()
            ..color = const Color(0xDDFFFFFF)
            ..strokeWidth = 2.6
            ..strokeCap = StrokeCap.round,
        );
        break;
    }
  }

  static double _cos(double a) => _taylor(a + 1.5707963268);
  static double _sin(double a) => _taylor(a);

  // Small sine helper so this file needs no extra import.
  static double _taylor(double x) {
    var a = x % (2 * 3.1415926535);
    if (a > 3.1415926535) a -= 2 * 3.1415926535;
    final a2 = a * a;
    return a * (1 - a2 / 6 * (1 - a2 / 20 * (1 - a2 / 42 * (1 - a2 / 72 * (1 - a2 / 110)))));
  }

  @override
  bool shouldRepaint(covariant GemPainter old) =>
      old.color != color || old.shape != shape;
}

/// A stone picture. If a photo named assets/images/gem_<id>.jpg exists it is
/// shown, otherwise the drawn picture is used. Always in its true colours.
class GemIcon extends StatelessWidget {
  final GemInfo gem;
  final double size;
  const GemIcon(this.gem, {super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return ThemeGuard(
      child: SizedBox(
        width: size,
        height: size,
        child: ClipOval(
          child: Image.asset(
            'assets/images/gem_${gem.id}.jpg',
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => CustomPaint(
              size: Size(size, size),
              painter: GemPainter(gem.color, gem.shape),
            ),
          ),
        ),
      ),
    );
  }
}

/// Five small chips (thumb to little finger) with the chosen finger marked.
class FingerRow extends StatelessWidget {
  final int finger;
  const FingerRow(this.finger, {super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: i == finger ? const Color(0xFFB8860B) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0x55B8860B)),
              ),
              child: Column(
                children: [
                  Icon(Icons.back_hand_outlined,
                      size: 18,
                      color: i == finger ? Colors.white : const Color(0xFF8A7A58)),
                  const SizedBox(height: 2),
                  Text(
                    s.t(GemstoneGuide.fingerNames[i]).split(' (').first,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 9.5,
                      height: 1.1,
                      fontWeight: i == finger ? FontWeight.w800 : FontWeight.w500,
                      color: i == finger ? Colors.white : const Color(0xFF2B2418),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
