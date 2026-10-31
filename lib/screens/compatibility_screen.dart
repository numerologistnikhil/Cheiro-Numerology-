import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/compat_text.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import '../core/root_profiles.dart' show L;
import '../core/user_profile.dart';
import 'profile_screen.dart';
import 'ui_kit.dart';

/// One compared pair, for example Mulank with Mulank.
class _Pair {
  final L area;
  final String key; // nature, path, cross, name
  final int a;
  final int b;
  final Relation rel;
  _Pair(this.area, this.key, this.a, this.b)
      : rel = NumerologyTools.relation(a, b);
}

class CompatibilityScreen extends StatefulWidget {
  const CompatibilityScreen({super.key});

  @override
  State<CompatibilityScreen> createState() => _CompatibilityScreenState();
}

class _CompatibilityScreenState extends State<CompatibilityScreen> {
  final TextEditingController _nameA = ProfileController.name();
  final TextEditingController _nameB = TextEditingController();
  DateTime? _a;
  DateTime? _b;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _nameA.dispose();
    _nameB.dispose();
    super.dispose();
  }

  DateTime? get _dobA => _a ?? UserProfile.instance.dob;

  void _check() {
    FocusScope.of(context).unfocus();
    setState(() => _checked = true);
  }

  int? _nameRoot(String text) {
    final t = text.trim();
    if (t.isEmpty) return null;
    final r = NumerologyEngine.name(t);
    return r.total == 0 ? null : r.root;
  }

  Widget _numberBox(AppSettings s, L who, String name, DateTime d, int? nameRoot) {
    final n = NumerologyEngine.birth(d);
    return Expanded(
      child: GoldCard(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(name.trim().isEmpty ? s.t(who) : name.trim(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  NumberBadge(n.psychic.root, size: 40),
                  const SizedBox(height: 4),
                  Text(s.t(CompatText.psychic), style: const TextStyle(fontSize: 11.5)),
                ]),
                Column(children: [
                  NumberBadge(n.destiny.root, size: 40),
                  const SizedBox(height: 4),
                  Text(s.t(CompatText.destiny), style: const TextStyle(fontSize: 11.5)),
                ]),
                if (nameRoot != null)
                  Column(children: [
                    NumberBadge(nameRoot, size: 40),
                    const SizedBox(height: 4),
                    Text(s.t(CompatText.nameNum), style: const TextStyle(fontSize: 11.5)),
                  ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _relWord(AppSettings s, Relation r) {
    switch (r) {
      case Relation.friend:
        return s.hindi ? 'अनुकूल' : 'Friendly';
      case Relation.neutral:
        return s.hindi ? 'सामान्य' : 'Neutral';
      case Relation.enemy:
        return s.hindi ? 'चुनौतीपूर्ण' : 'Challenging';
    }
  }

  L _relText(Relation r, String key) {
    switch (r) {
      case Relation.friend:
        return CompatText.friendly[key]!;
      case Relation.neutral:
        return CompatText.neutral[key]!;
      case Relation.enemy:
        return CompatText.challenging[key]!;
    }
  }

  IconData _relIcon(Relation r) {
    switch (r) {
      case Relation.friend:
        return Icons.favorite;
      case Relation.neutral:
        return Icons.balance;
      case Relation.enemy:
        return Icons.warning_amber_rounded;
    }
  }

  List<Widget> _result(AppSettings s) {
    final da = _dobA;
    final db = _b;
    if (da == null || db == null) return const [];
    final na = NumerologyEngine.birth(da);
    final nb = NumerologyEngine.birth(db);
    final ra = _nameRoot(_nameA.text);
    final rb = _nameRoot(_nameB.text);

    final pairs = <_Pair>[
      _Pair(CompatText.areaNature, 'nature', na.psychic.root, nb.psychic.root),
      _Pair(CompatText.areaPath, 'path', na.destiny.root, nb.destiny.root),
      _Pair(CompatText.areaCross1, 'cross', na.psychic.root, nb.destiny.root),
      _Pair(CompatText.areaCross2, 'cross', nb.psychic.root, na.destiny.root),
      if (ra != null && rb != null)
        _Pair(CompatText.areaName, 'name', ra, rb),
    ];
    var score = 0;
    for (final p in pairs) {
      score += NumerologyTools.points(p.rel);
    }
    final max = pairs.length * 2;
    final ratio = score / max;
    final level = ratio >= 0.75 ? 2 : (ratio >= 0.5 ? 1 : 0);

    return [
      const SizedBox(height: 16),
      Row(
        children: [
          _numberBox(s, CompatText.first, _nameA.text, da, ra),
          const SizedBox(width: 12),
          _numberBox(s, CompatText.second, _nameB.text, db, rb),
        ],
      ),
      SectionLabel(s.t(CompatText.result)),
      GoldCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.t(CompatText.levelName[level]),
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 12,
                backgroundColor: const Color(0xFFEFE6C8),
                color: AnkdharaColors.gold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${s.t(CompatText.points)}: $score ${s.t(CompatText.outOf)} $max',
              style: const TextStyle(fontSize: 12.5),
            ),
            const SizedBox(height: 12),
            Text(s.t(CompatText.levelPlain[level]),
                style: const TextStyle(fontSize: 14.5, height: 1.55)),
          ],
        ),
      ),
      SectionLabel(s.t(CompatText.areasTitle)),
      for (final p in pairs)
        InfoRow(
          _relIcon(p.rel),
          '${s.t(p.area)}: ${p.a} & ${p.b} - ${_relWord(s, p.rel)}',
          s.t(_relText(p.rel, p.key)),
        ),
      SectionLabel(s.t(CompatText.helpsTitle)),
      Note(s.t(CompatText.helps[level])),
      SectionLabel(s.t(CompatText.avoidTitle)),
      Note(s.t(CompatText.avoid[level])),
      SectionLabel(s.t(CompatText.bestUseTitle)),
      InfoRow(Icons.people_outline, s.t(CompatText.plainFriends).trim(),
          s.t(CompatText.usage[level][0])),
      InfoRow(Icons.favorite_border, s.t(CompatText.plainLove).trim(),
          s.t(CompatText.usage[level][1])),
      InfoRow(Icons.work_outline, s.t(CompatText.plainWork).trim(),
          s.t(CompatText.usage[level][2])),
      Note(s.t(CompatText.note)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final ready = _dobA != null && _b != null;
    return PageShell(
      title: s.t(CompatText.title),
      children: [
        Note(s.t(CompatText.intro)),
        SectionLabel(s.t(CompatText.first)),
        ProfileHide(
          child: TextField(
            controller: _nameA,
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() => _checked = false),
            decoration: InputDecoration(
              labelText: s.t(CompatText.nameLabel),
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
        ),
        const SizedBox(height: 10),
        DateField(
          label: s.t(CompatText.dobLabel),
          value: _a,
          onChanged: (d) => setState(() {
            _a = d;
            _checked = false;
          }),
        ),
        SectionLabel(s.t(CompatText.second)),
        TextField(
          controller: _nameB,
          textCapitalization: TextCapitalization.words,
          onChanged: (_) => setState(() => _checked = false),
          decoration: InputDecoration(
            labelText: s.t(CompatText.nameLabel),
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 10),
        DateField(
          usesProfile: false,
          label: s.t(CompatText.dobLabel),
          value: _b,
          onChanged: (d) => setState(() {
            _b = d;
            _checked = false;
          }),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: ready ? _check : null,
            icon: const Icon(Icons.favorite_border),
            label: Text(s.t(CompatText.check)),
          ),
        ),
        if (_checked) FadeIn(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _result(s),
        )),
      ],
    );
  }
}
