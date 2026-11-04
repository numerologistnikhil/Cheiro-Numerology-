import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/app_theme.dart';
import '../core/numerology_engine.dart';
import '../core/rudraksha_guide.dart';
import '../core/user_profile.dart';
import 'ui_kit.dart';

/// Draws a simple picture of a rudraksha bead with its natural lines.
class RudrakshaPainter extends CustomPainter {
  final int mukhi;
  const RudrakshaPainter(this.mukhi);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2 * 0.9;
    final rect = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.3, -0.35),
          colors: [Color(0xFFB07A4A), Color(0xFF7A4A24), Color(0xFF4A2A12)],
          stops: [0.0, 0.6, 1.0],
        ).createShader(rect),
    );
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = const Color(0xCC2E1A0A);
    final n = mukhi < 1 ? 1 : (mukhi > 14 ? 14 : mukhi);
    // Lines run from the top to the bottom of the bead.
    for (var k = 0; k < n; k++) {
      final t = (k + 0.5) / n; // 0..1 across the bead
      final x = (t * 2 - 1) * r * 0.78;
      final bulge = x.abs() * 0.0 + r * 0.0;
      final path = Path()
        ..moveTo(c.dx + x * 0.25, c.dy - r * 0.95)
        ..quadraticBezierTo(c.dx + x * 1.45 + bulge, c.dy, c.dx + x * 0.25,
            c.dy + r * 0.95);
      canvas.drawPath(path, line);
    }
    canvas.drawCircle(Offset(c.dx, c.dy - r * 0.92), r * 0.06,
        Paint()..color = const Color(0xFF2E1A0A));
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(c.dx - r * 0.35, c.dy - r * 0.4),
          width: r * 0.4,
          height: r * 0.22),
      Paint()..color = const Color(0x55FFFFFF),
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
