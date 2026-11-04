import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/gemstone_guide.dart';
import '../core/numerology_engine.dart';
import '../core/user_profile.dart';
import 'gem_widgets.dart';
import 'ui_kit.dart';

/// Gemstone Guide: stone, finger, weight, day, mantra and how to wear it.
class GemstoneScreen extends StatefulWidget {
  const GemstoneScreen({super.key});

  @override
  State<GemstoneScreen> createState() => _GemstoneScreenState();
}

class _GemstoneScreenState extends State<GemstoneScreen> {
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  DateTime? get _date => _dob ?? UserProfile.instance.dob;

  List<Widget> _details(AppSettings s, GemInfo g) => [
        InfoRow(Icons.swap_horiz, s.t(GemstoneGuide.substitute), s.t(g.alt)),
        InfoRow(Icons.public, s.t(GemstoneGuide.planetLabel), s.t(g.planet)),
        InfoRow(Icons.back_hand_outlined, s.t(GemstoneGuide.fingerLabel),
            s.t(GemstoneGuide.fingerNames[g.finger])),
        InfoRow(Icons.circle_outlined, s.t(GemstoneGuide.metalLabel), s.t(g.metal)),
        InfoRow(Icons.wb_sunny_outlined, s.t(GemstoneGuide.dayLabel), s.t(g.day)),
        InfoRow(Icons.scale_outlined, s.t(GemstoneGuide.weightLabel), s.t(g.weight)),
        InfoRow(Icons.self_improvement, s.t(GemstoneGuide.mantraLabel), s.t(g.mantra)),
        InfoRow(Icons.info_outline, s.t(GemstoneGuide.cautionLabel), s.t(g.caution)),
      ];

  Widget _stoneCard(AppSettings s, GemInfo g, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GemIcon(g, size: 72),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(s.t(g.gem),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                      Text('${s.t(GemstoneGuide.planetLabel)}: ${s.t(g.planet)}',
                          style: const TextStyle(fontSize: 12.5)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FingerRow(g.finger),
            ..._details(s, g),
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
      Note(s.t(GemstoneGuide.intro)),
      const SizedBox(height: 14),
      DateField(
        label: s.hindi ? 'आपकी जन्म तिथि' : 'Your date of birth',
        value: _dob,
        onChanged: (v) => setState(() => _dob = v),
      ),
    ];
    if (d != null) {
      final b = NumerologyEngine.birth(d);
      final m = GemstoneGuide.gems[b.psychic.root];
      final bh = GemstoneGuide.gems[b.destiny.root];
      if (m != null) kids.add(_stoneCard(s, m, s.t(GemstoneGuide.mainStone)));
      if (bh != null && m != null && bh.root != m.root) {
        kids.add(_stoneCard(s, bh, s.t(GemstoneGuide.secondStone)));
      }
    }
    kids.addAll([
      SectionLabel(s.t(GemstoneGuide.handTitle)),
      Note(s.t(GemstoneGuide.handBody)),
      SectionLabel(s.t(GemstoneGuide.weightTitle)),
      Note(s.t(GemstoneGuide.weightIntro)),
      for (final row in GemstoneGuide.ageTable)
        InfoRow(Icons.cake_outlined, s.t(row[0]), s.t(row[1])),
      SectionLabel(s.t(GemstoneGuide.stepsTitle)),
      for (final st in GemstoneGuide.steps)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(s.t(st), style: const TextStyle(fontSize: 14, height: 1.45)),
        ),
      InfoRow(Icons.verified_outlined, s.t(GemstoneGuide.buyTitle),
          s.t(GemstoneGuide.buyBody)),
      SectionLabel(s.t(GemstoneGuide.allStones)),
      for (final g in GemstoneGuide.gems.values)
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          leading: GemIcon(g, size: 40),
          title: Text(s.t(g.gem),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          subtitle: Text(
              '${s.hindi ? 'अंक' : 'Number'} ${g.root}  -  ${s.t(g.planet)}',
              style: const TextStyle(fontSize: 12)),
          children: [
            FingerRow(g.finger),
            ..._details(s, g),
            const SizedBox(height: 8),
          ],
        ),
      const SizedBox(height: 14),
      Note(s.t(GemstoneGuide.safetyBody)),
    ]);
    return PageShell(title: s.t(GemstoneGuide.title), children: kids);
  }
}
