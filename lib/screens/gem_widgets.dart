import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/gemstone_guide.dart';

Color _shade(Color c, double delta) {
  final h = HSLColor.fromColor(c);
  return h.withLightness((h.lightness + delta).clamp(0.0, 1.0).toDouble()).toColor();
}

/// Draws a 3D-style picture of a stone (not a photograph): a cut stone seen
/// from the side with light and dark facets, a pearl or a polished cabochon,
/// each with a soft shadow, glints and a bright edge.
class GemPainter extends CustomPainter {
  final Color color;
  final GemShape shape;
  const GemPainter(this.color, this.shape);

  static Color _mix(Color a, Color b, double t) => Color.lerp(a, b, t)!;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.shortestSide;
    canvas.save();
    // Work in a 0..1 square with a small margin.
    final m = w * 0.06;
    canvas.translate((size.width - w) / 2 + m, (size.height - w) / 2 + m);
    canvas.scale((w - 2 * m));
    switch (shape) {
      case GemShape.faceted:
        _faceted(canvas, w - 2 * m);
        break;
      case GemShape.round:
        _pearl(canvas, w - 2 * m);
        break;
      case GemShape.oval:
        _cabochon(canvas, w - 2 * m, eye: false);
        break;
      case GemShape.catsEye:
        _cabochon(canvas, w - 2 * m, eye: true);
        break;
    }
    canvas.restore();
  }

  void _shadow(Canvas canvas, double px, double cx, double cy, double rx, double ry) {
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2),
      Paint()
        ..color = const Color(0x55000000)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.03),
    );
  }

  void _faceted(Canvas canvas, double px) {
    _shadow(canvas, px, 0.5, 0.95, 0.30, 0.035);
    const g0 = Offset(0.06, 0.36), g1 = Offset(0.30, 0.36), g2 = Offset(0.50, 0.36);
    const g3 = Offset(0.70, 0.36), g4 = Offset(0.94, 0.36);
    const t0 = Offset(0.27, 0.14), tm = Offset(0.50, 0.14), t2 = Offset(0.73, 0.14);
    const tip = Offset(0.50, 0.92);

    final light = _mix(color, Colors.white, 0.55);
    final deep = _mix(color, Colors.black, 0.45);
    final facets = <List<Offset>>[
      [g0, t0, g1],
      [t0, tm, g2, g1],
      [tm, t2, g3, g2],
      [t2, g4, g3],
      [g0, g1, tip],
      [g1, g2, tip],
      [g2, g3, tip],
      [g3, g4, tip],
    ];
    // How light each facet is: 0 = deep colour, 1 = bright.
    const tone = [0.55, 0.95, 0.40, 0.18, 0.10, 0.62, 0.30, 0.02];
    for (var i = 0; i < facets.length; i++) {
      final path = Path()..addPolygon(facets[i], true);
      final t = tone[i];
      final base = t < 0.5 ? _mix(deep, color, t * 2) : _mix(color, light, (t - 0.5) * 2);
      canvas.drawPath(path, Paint()..color = base);
    }
    // Table (flat top).
    final table = Path()..addPolygon(const [Offset(0.27, 0.14), Offset(0.73, 0.14), Offset(0.66, 0.07), Offset(0.34, 0.07)], true);
    canvas.drawPath(
      table,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_mix(color, Colors.white, 0.85), _mix(color, Colors.white, 0.5)],
        ).createShader(const Rect.fromLTWH(0.27, 0.07, 0.46, 0.07)),
    );
    // Soft glass sheen across the whole stone.
    final outline = Path()
      ..addPolygon(const [Offset(0.34, 0.07), Offset(0.66, 0.07), Offset(0.73, 0.14), Offset(0.94, 0.36), Offset(0.50, 0.92), Offset(0.06, 0.36), Offset(0.27, 0.14)], true);
    canvas.save();
    canvas.clipPath(outline);
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, 1, 1),
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0x55FFFFFF), Color(0x00FFFFFF), Color(0x33000000)],
          stops: [0.0, 0.5, 1.0],
        ).createShader(const Rect.fromLTWH(0, 0, 1, 1)),
    );
    canvas.restore();
    // Bright facet edges.
    final edge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.006
      ..strokeJoin = StrokeJoin.round
      ..color = const Color(0xAAFFFFFF);
    for (final f in facets) {
      canvas.drawPath(Path()..addPolygon(f, true), edge);
    }
    canvas.drawPath(
      outline,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.012
        ..strokeJoin = StrokeJoin.round
        ..color = _mix(color, Colors.black, 0.5),
    );
    _glint(canvas, const Offset(0.38, 0.22), 0.07);
    _glint(canvas, const Offset(0.66, 0.50), 0.035);
  }

  void _glint(Canvas canvas, Offset at, double r) {
    final p = Paint()..color = const Color(0xE6FFFFFF);
    final star = Path()
      ..moveTo(at.dx, at.dy - r)
      ..quadraticBezierTo(at.dx, at.dy, at.dx + r, at.dy)
      ..quadraticBezierTo(at.dx, at.dy, at.dx, at.dy + r)
      ..quadraticBezierTo(at.dx, at.dy, at.dx - r, at.dy)
      ..quadraticBezierTo(at.dx, at.dy, at.dx, at.dy - r)
      ..close();
    canvas.drawPath(star, p);
  }

  void _pearl(Canvas canvas, double px) {
    _shadow(canvas, px, 0.5, 0.92, 0.30, 0.04);
    const c = Offset(0.5, 0.48);
    const r = 0.40;
    final rect = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.35, -0.4),
          radius: 1.05,
          colors: [
            const Color(0xFFFFFFFF),
            _mix(color, Colors.white, 0.6),
            _mix(color, const Color(0xFFE9D3D9), 0.35),
            _mix(color, const Color(0xFF8E8A90), 0.55),
          ],
          stops: const [0.0, 0.35, 0.75, 1.0],
        ).createShader(rect),
    );
    // Rainbow-like sheen of a real pearl.
    canvas.save();
    canvas.clipPath(Path()..addOval(rect));
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0x00FFFFFF), Color(0x33FFC9E0), Color(0x33C9E6FF), Color(0x00FFFFFF)],
          stops: [0.2, 0.45, 0.65, 0.9],
        ).createShader(rect),
    );
    canvas.restore();
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(0.38, 0.30), width: 0.20, height: 0.11),
      Paint()
        ..color = const Color(0xD0FFFFFF)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.012),
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.008
        ..color = const Color(0x33000000),
    );
  }

  void _cabochon(Canvas canvas, double px, {required bool eye}) {
    _shadow(canvas, px, 0.5, 0.80, 0.36, 0.04);
    final body = Rect.fromCenter(center: const Offset(0.5, 0.48), width: 0.84, height: 0.62);
    final dark = _mix(color, Colors.black, 0.55);
    canvas.drawOval(
      body,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.45),
          radius: 1.0,
          colors: [_mix(color, Colors.white, 0.45), color, dark],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(body),
    );
    // Darker rim at the bottom edge gives the rounded look.
    canvas.save();
    canvas.clipPath(Path()..addOval(body));
    canvas.drawOval(
      body.shift(const Offset(0, -0.05)).deflate(0.01),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.07
        ..color = const Color(0x22FFFFFF),
    );
    canvas.restore();
    if (eye) {
      // The thin bright line of a cat's eye, with a soft glow around it.
      final line = Path()
        ..moveTo(0.5, 0.20)
        ..quadraticBezierTo(0.515, 0.48, 0.5, 0.76);
      canvas.drawPath(
        line,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.06
          ..color = const Color(0x55FFF3B0)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.02),
      );
      canvas.drawPath(
        line,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.014
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xF0FFFFFF),
      );
    }
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(0.34, 0.33), width: 0.26, height: 0.10),
      Paint()
        ..color = const Color(0xC0FFFFFF)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.012),
    );
    canvas.drawOval(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.008
        ..color = _mix(color, Colors.black, 0.5),
    );
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
