import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/numerology_engine.dart';
import '../core/profession_guide.dart';
import '../core/user_profile.dart';
import 'ui_kit.dart';

/// Career and business guide: fields with real examples for each number.
class ProfessionScreen extends StatefulWidget {
  const ProfessionScreen({super.key});

  @override
  State<ProfessionScreen> createState() => _ProfessionScreenState();
}

class _ProfessionScreenState extends State<ProfessionScreen> {
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  DateTime? get _date => _dob ?? UserProfile.instance.dob;

  Widget _card(AppSettings s, String head, WorkInfo w) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              NumberBadge(w.root, size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Text('$head  -  ${s.t(w.planet)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ]),
            const SizedBox(height: 10),
            Text(s.t(w.strength),
                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, height: 1.45)),
            const SizedBox(height: 6),
            for (final f in w.fields)
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(bottom: 8),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                leading: const Icon(Icons.work_outline, size: 20),
                title: Text(s.t(f.name),
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${s.t(ProfessionGuide.examplesLabel)}: ${s.t(f.examples)}',
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),
                ],
              ),
            InfoRow(Icons.badge_outlined, s.t(ProfessionGuide.styleLabel), s.t(w.style)),
            InfoRow(Icons.block, s.t(ProfessionGuide.avoidLabel), s.t(w.avoid)),
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
      Note(s.t(ProfessionGuide.intro)),
      const SizedBox(height: 14),
      DateField(
        label: s.hindi ? 'आपकी जन्म तिथि' : 'Your date of birth',
        value: _dob,
        onChanged: (v) => setState(() => _dob = v),
      ),
    ];
    if (d != null) {
      final b = NumerologyEngine.birth(d);
      final m = ProfessionGuide.byRoot[b.psychic.root];
      final bh = ProfessionGuide.byRoot[b.destiny.root];
      if (m != null) {
        kids.add(_card(s, '${s.t(ProfessionGuide.forMulank)}: ${m.root}', m));
      }
      if (bh != null && m != null && bh.root != m.root) {
        kids.add(_card(s, '${s.t(ProfessionGuide.forBhagyank)}: ${bh.root}', bh));
      }
      kids.add(const SizedBox(height: 12));
      kids.add(Note(s.t(ProfessionGuide.note)));
    } else {
      kids.add(const SizedBox(height: 12));
      kids.add(Note(s.hindi
          ? 'अपनी जन्म तिथि चुनिए, फिर आपके अंकों के हिसाब से काम और व्यापार के क्षेत्र दिखेंगे।'
          : 'Choose your date of birth to see the fields of work and business that suit your numbers.'));
    }
    return PageShell(title: s.t(ProfessionGuide.title), children: kids);
  }
}
