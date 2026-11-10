import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/numerology_engine.dart';
import '../core/rudraksha_guide.dart';
import '../core/user_profile.dart';
import 'ui_kit.dart';

/// Draws a 3D-style rudraksha bead: rough brown surface with small pits,
/// deep natural grooves (mukhi lines) from pole to pole, a dark hole at the
/// top, soft light from the upper left and a shadow below.
class RudrakshaPainter extends CustomPainter {
  final int mukhi;
  const RudrakshaPainter(this.mukhi);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.shortestSide;
    canvas.save();
    canvas.translate((size.width - w) / 2, (size.height - w) / 2);
    canvas.scale(w);
    _draw(canvas);
    canvas.restore();
  }

  void _draw(Canvas canvas) {
    const c = Offset(0.5, 0.47);
    const rx = 0.37; // slightly narrower than tall, like a real bead
    const ry = 0.40;
    final body = Rect.fromCenter(center: c, width: rx * 2, height: ry * 2);

    // Shadow on the table.
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(0.5, 0.93), width: 0.58, height: 0.07),
      Paint()
        ..color = const Color(0x66000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.03),
    );

    // Round body with light from the upper left.
    canvas.drawOval(
      body,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.38, -0.45),
          radius: 1.0,
          colors: [Color(0xFFD99B62), Color(0xFFA0602F), Color(0xFF5E3112), Color(0xFF2E1608)],
          stops: [0.0, 0.38, 0.78, 1.0],
        ).createShader(body),
    );

    canvas.save();
    canvas.clipPath(Path()..addOval(body));

    // Rough skin: many small pits and bumps, always the same for one bead.
    final rnd = math.Random(11 + mukhi * 7);
    for (var i = 0; i < 260; i++) {
      final a = rnd.nextDouble() * 2 * math.pi;
      final d = math.sqrt(rnd.nextDouble());
      final x = c.dx + math.cos(a) * d * rx;
      final y = c.dy + math.sin(a) * d * ry;
      final s = 0.006 + rnd.nextDouble() * 0.011;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x, y), width: s * 1.5, height: s),
        Paint()..color = Color.fromARGB(70 + rnd.nextInt(60), 40, 18, 6),
      );
      // A tiny light edge under each pit makes it look pressed in.
      canvas.drawOval(
        Rect.fromCenter(center: Offset(x + s * 0.35, y + s * 0.55), width: s * 1.2, height: s * 0.5),
        Paint()..color = Color.fromARGB(40 + rnd.nextInt(30), 240, 190, 130),
      );
    }

    // Grooves: lines that run from the top hole to the bottom, curved like the
    // sides of a ball. Only the ones facing us are seen.
    final n = mukhi < 1 ? 1 : (mukhi > 14 ? 14 : mukhi);
    final turn = n == 1 ? 0.0 : math.pi / n * 0.5;
    for (var k = 0; k < n; k++) {
      final phi = (2 * math.pi * k / n) + turn;
      final facing = math.cos(phi);
      if (facing <= 0.08) continue;
      final path = Path();
      const steps = 26;
      for (var j = 0; j <= steps; j++) {
        final th = 0.10 + (math.pi - 0.20) * j / steps;
        final x = c.dx + rx * math.sin(th) * math.sin(phi);
        final y = c.dy - ry * math.cos(th);
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      final width = 0.022 * facing + 0.004;
      // Deep dark groove, with a lit lip on one side.
      canvas.drawPath(
        path.shift(const Offset(0.006, 0.002)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = width * 0.8
          ..strokeCap = StrokeCap.round
          ..color = const Color(0x66F0B880),
      );
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = width
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xE61E0E04),
      );
    }

    // Round the edges: dark rim and soft bright patch.
    canvas.drawOval(
      body,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.1, -0.1),
          radius: 1.0,
          colors: [Color(0x00000000), Color(0x00000000), Color(0x66000000)],
          stops: [0.0, 0.7, 1.0],
        ).createShader(body),
    );
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(0.36, 0.30), width: 0.22, height: 0.12),
      Paint()
        ..color = const Color(0x55FFE2BE)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.025),
    );
    canvas.restore();

    // The hole at the top where the thread goes.
    canvas.drawOval(
      Rect.fromCenter(center: Offset(c.dx, c.dy - ry + 0.025), width: 0.07, height: 0.035),
      Paint()..color = const Color(0xFF1A0B03),
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(c.dx, c.dy - ry + 0.025), width: 0.09, height: 0.05),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.008
        ..color = const Color(0x88E2A870),
    );
    canvas.drawOval(
      body,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.008
        ..color = const Color(0x55000000),
    );
  }

  @override
  bool shouldRepaint(covariant RudrakshaPainter old) => old.mukhi != mukhi;
}

class RudrakshaBead extends StatelessWidget {
  final int mukhi;
  final double size;
  const RudrakshaBead(this.mukhi, {super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return ThemeGuard(
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: RudrakshaPainter(mukhi)),
      ),
    );
  }
}

/// Rudraksha Guide screen.
class RudrakshaScreen extends StatefulWidget {
  const RudrakshaScreen({super.key});

  @override
  State<RudrakshaScreen> createState() => _RudrakshaScreenState();
}

class _RudrakshaScreenState extends State<RudrakshaScreen> {
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  DateTime? get _date => _dob ?? UserProfile.instance.dob;

  List<Widget> _details(AppSettings s, RudrakshaInfo r) => [
        InfoRow(Icons.person_outline, s.t(RudrakshaGuide.deityLabel), s.t(r.deity)),
        InfoRow(Icons.public, s.t(RudrakshaGuide.planetLabel), s.t(r.planet)),
        InfoRow(Icons.self_improvement, s.t(RudrakshaGuide.mantraLabel), s.t(r.mantra)),
        InfoRow(Icons.favorite_border, s.t(RudrakshaGuide.focusLabel), s.t(r.focus)),
        InfoRow(Icons.info_outline, s.t(RudrakshaGuide.noteLabel), s.t(r.note)),
      ];

  Widget _card(AppSettings s, RudrakshaInfo r, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RudrakshaBead(r.mukhi, size: 68),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text('${r.mukhi} ${s.t(RudrakshaGuide.mukhiLabel)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ],
            ),
            ..._details(s, r),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final d = _date;
    final kids = <Widget>[
      Note(s.t(RudrakshaGuide.intro)),
      const SizedBox(height: 14),
      DateField(
        label: s.hindi ? 'आपकी जन्म तिथि' : 'Your date of birth',
        value: _dob,
        onChanged: (v) => setState(() => _dob = v),
      ),
    ];
    if (d != null) {
      final b = NumerologyEngine.birth(d);
      final shown = <int>{};
      void add(int root, String label) {
        for (final m in RudrakshaGuide.forRoot[root] ?? const <int>[]) {
          final info = RudrakshaGuide.mukhis[m];
          if (info != null && shown.add(m)) kids.add(_card(s, info, label));
        }
      }

      add(b.psychic.root, s.t(RudrakshaGuide.forYou));
      add(b.destiny.root, s.t(RudrakshaGuide.forYou2));
      kids.add(Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(s.t(RudrakshaGuide.linkNote),
            style: const TextStyle(fontSize: 12.5, fontStyle: FontStyle.italic)),
      ));
      final five = RudrakshaGuide.mukhis[5];
      if (five != null && shown.add(5)) {
        kids.add(_card(s, five, s.t(RudrakshaGuide.universal)));
        kids.add(Note(s.t(RudrakshaGuide.universalBody)));
      }
    }
    kids.addAll([
      SectionLabel(s.t(RudrakshaGuide.energiseTitle)),
      for (final st in RudrakshaGuide.energise)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(s.t(st), style: const TextStyle(fontSize: 14, height: 1.45)),
        ),
      InfoRow(Icons.rule, s.t(RudrakshaGuide.rulesTitle), s.t(RudrakshaGuide.rulesBody)),
      InfoRow(Icons.cleaning_services_outlined, s.t(RudrakshaGuide.careTitle),
          s.t(RudrakshaGuide.careBody)),
      SectionLabel(s.t(RudrakshaGuide.fakeTitle)),
      for (final f in RudrakshaGuide.fake)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('•  ${s.t(f)}', style: const TextStyle(fontSize: 14, height: 1.45)),
        ),
      InfoRow(Icons.compare_arrows, s.t(RudrakshaGuide.chooseTitle),
          s.t(RudrakshaGuide.chooseBody)),
      SectionLabel(s.t(RudrakshaGuide.allTitle)),
      for (final r in RudrakshaGuide.mukhis.values)
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          leading: RudrakshaBead(r.mukhi, size: 40),
          title: Text('${r.mukhi} ${s.t(RudrakshaGuide.mukhiLabel)}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          subtitle: Text('${s.t(r.deity)}  -  ${s.t(r.planet)}',
              style: const TextStyle(fontSize: 12)),
          children: [
            ..._details(s, r),
            const SizedBox(height: 8),
          ],
        ),
      const SizedBox(height: 14),
      Note(s.t(RudrakshaGuide.safetyBody)),
    ]);
    return PageShell(title: s.t(RudrakshaGuide.title), children: kids);
  }
}
