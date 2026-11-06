import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/numerology_engine.dart';
import '../core/pythagorean.dart';
import '../core/root_profiles.dart' show L;
import '../core/user_profile.dart';
import 'ui_kit.dart';

/// Western (Pythagorean) chart next to the Indian reading.
class WesternScreen extends StatefulWidget {
  const WesternScreen({super.key});

  @override
  State<WesternScreen> createState() => _WesternScreenState();
}

class _WesternScreenState extends State<WesternScreen> {
  DateTime? _dob;
  final _name = ProfileController.name();

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  DateTime? get _date => _dob ?? UserProfile.instance.dob;

  Widget _card(AppSettings s, L label, L how, int n, L text, {int? raw}) {
    final isMaster = Pythagorean.masters.contains(n);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NumberBadge(n, size: 52),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.t(label),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Text(
                    raw != null && raw != n ? '${s.t(how)} ($raw/$n)' : s.t(how),
                    style: const TextStyle(fontSize: 12),
                  ),
                  if (isMaster)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Pill(s.t(WesternText.master)),
                    ),
                  const SizedBox(height: 6),
                  Text(s.t(text), style: const TextStyle(fontSize: 14, height: 1.45)),
                ],
              ),
            ),
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
      Note(s.t(WesternText.intro)),
      const SizedBox(height: 14),
      DateField(
        label: s.t(WesternText.dobLabel),
        value: _dob,
        onChanged: (v) => setState(() => _dob = v),
      ),
      const SizedBox(height: 12),
      TextField(
        controller: _name,
        textCapitalization: TextCapitalization.words,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: s.t(WesternText.nameLabel),
          prefixIcon: const Icon(Icons.badge_outlined),
        ),
      ),
    ];
    if (d != null) {
      final c = Pythagorean.chart(d, _name.text);
      final n = WesternText.core;
      kids.add(_card(s, WesternText.lifePath, WesternText.lifePathHow, c.lifePath,
          n[c.lifePath]!, raw: c.lifePathRaw));
      kids.add(_card(s, WesternText.birthday, WesternText.birthdayHow, c.birthday, n[c.birthday]!));
      if (c.expression != null) {
        kids.add(_card(s, WesternText.expression, WesternText.expressionHow, c.expression!,
            n[c.expression!]!, raw: c.expressionRaw));
        if (c.soulUrge != null) {
          kids.add(_card(s, WesternText.soul, WesternText.soulHow, c.soulUrge!,
              WesternText.inner[c.soulUrge!]!));
        }
        if (c.personality != null) {
          kids.add(_card(s, WesternText.personality, WesternText.personalityHow, c.personality!,
              WesternText.outer[c.personality!]!));
        }
        if (c.maturity != null) {
          kids.add(_card(s, WesternText.maturity, WesternText.maturityHow, c.maturity!,
              n[c.maturity!]!));
        }
      } else {
        kids.add(Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Note(s.t(WesternText.missingName)),
        ));
      }
      if (c.lifePath == 11 || c.lifePath == 22 || c.lifePath == 33 ||
          c.expression == 11 || c.expression == 22 || c.expression == 33) {
        kids.add(Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Note(s.t(WesternText.masterNote)),
        ));
      }
      kids.add(SectionLabel(s.t(WesternText.karmicTitle)));
      if (c.karmicDebts.isEmpty) {
        kids.add(Note(s.t(WesternText.karmicNone)));
      } else {
        for (final k in c.karmicDebts) {
          kids.add(InfoRow(Icons.balance, '$k', s.t(WesternText.karmicText[k]!)));
        }
      }
      kids.add(Note(s.t(WesternText.karmicNote)));

      final b = NumerologyEngine.birth(d);
      final py = Pythagorean.personalYear(d, DateTime.now().year);
      kids.addAll([
        SectionLabel(s.t(WesternText.eastWest)),
        Note(s.t(WesternText.eastWestBody)),
        InfoRow(Icons.wb_sunny_outlined, s.t(WesternText.mulank), '${b.psychic.root}'),
        InfoRow(Icons.auto_awesome, s.t(WesternText.bhagyank), '${b.destiny.root}'),
        InfoRow(Icons.public, s.t(WesternText.lifePath), '${c.lifePath}'),
        InfoRow(Icons.calendar_today_outlined,
            '${s.t(WesternText.py)} ${DateTime.now().year}: $py', s.t(WesternText.yearTheme[py]!)),
      ]);
    }
    kids.add(const SizedBox(height: 12));
    kids.add(Note(s.t(WesternText.note)));
    return PageShell(title: s.t(WesternText.title), children: kids);
  }
}
