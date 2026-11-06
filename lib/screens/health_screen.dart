import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/health_guide.dart';
import '../core/numerology_engine.dart';
import '../core/user_profile.dart';
import 'ui_kit.dart';

/// Health tendencies by number, plus general precautions for the Jatak.
class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  DateTime? get _date => _dob ?? UserProfile.instance.dob;

  List<Widget> _rows(AppSettings s, HealthInfo h) => [
        InfoRow(Icons.public, s.t(HealthGuide.planetLabel), s.t(h.planet)),
        InfoRow(Icons.accessibility_new, s.t(HealthGuide.areasLabel), s.t(h.areas)),
        InfoRow(Icons.visibility_outlined, s.t(HealthGuide.watchLabel), s.t(h.watch)),
        InfoRow(Icons.favorite_border, s.t(HealthGuide.habitsLabel), s.t(h.habits)),
        InfoRow(Icons.fact_check_outlined, s.t(HealthGuide.checkLabel), s.t(h.checkup)),
      ];

  Widget _card(AppSettings s, String head, HealthInfo h) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: GoldCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                NumberBadge(h.root, size: 44),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(head,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                ),
              ]),
              ..._rows(s, h),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final d = _date;
    final kids = <Widget>[
      Note(s.t(HealthGuide.intro)),
      const SizedBox(height: 14),
      DateField(
        label: s.hindi ? 'आपकी जन्म तिथि' : 'Your date of birth',
        value: _dob,
        onChanged: (v) => setState(() => _dob = v),
      ),
    ];
    if (d != null) {
      final b = NumerologyEngine.birth(d);
      final m = HealthGuide.byRoot[b.psychic.root];
      final bh = HealthGuide.byRoot[b.destiny.root];
      if (m != null) kids.add(_card(s, '${s.t(HealthGuide.mulankHead)}: ${m.root}', m));
      if (bh != null && m != null && bh.root != m.root) {
        kids.add(_card(s, '${s.t(HealthGuide.bhagyankHead)}: ${bh.root}', bh));
      }
    }
    kids.addAll([
      InfoRow(Icons.local_hospital_outlined, s.t(HealthGuide.doctorTitle),
          s.t(HealthGuide.doctorBody)),
      SectionLabel(s.t(HealthGuide.precTitle)),
      Note(s.t(HealthGuide.precIntro)),
      for (final p in HealthGuide.precautions)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('•  ${s.t(p)}', style: const TextStyle(fontSize: 14, height: 1.45)),
        ),
      SectionLabel(s.t(HealthGuide.allTitle)),
      for (final h in HealthGuide.byRoot.values)
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          leading: NumberBadge(h.root, size: 38),
          title: Text('${s.hindi ? 'अंक' : 'Number'} ${h.root}  -  ${s.t(h.planet)}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          children: _rows(s, h),
        ),
    ]);
    return PageShell(title: s.t(HealthGuide.title), children: kids);
  }
}
