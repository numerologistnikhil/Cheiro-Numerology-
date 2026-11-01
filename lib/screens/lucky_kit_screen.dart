import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/lucky_kit.dart';
import '../core/numerology_engine.dart';
import '../core/root_profiles.dart' show L, RootProfiles;
import '../core/user_profile.dart';
import 'ui_kit.dart';

/// Lucky Number Kit: house / flat number check and lucky numbers.
class LuckyKitScreen extends StatefulWidget {
  const LuckyKitScreen({super.key});

  @override
  State<LuckyKitScreen> createState() => _LuckyKitScreenState();
}

class _LuckyKitScreenState extends State<LuckyKitScreen> {
  final TextEditingController _house = TextEditingController();
  DateTime? _dob;
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
    _house.dispose();
    super.dispose();
  }

  DateTime? get _date => _dob ?? UserProfile.instance.dob;

  void _check() {
    FocusScope.of(context).unfocus();
    setState(() => _checked = true);
  }

  IconData _icon(HouseVerdict v) {
    switch (v) {
      case HouseVerdict.good:
        return Icons.home_outlined;
      case HouseVerdict.mixed:
        return Icons.balance;
      case HouseVerdict.careful:
        return Icons.info_outline;
    }
  }

  List<Widget> _houseResult(AppSettings s, DateTime d) {
    final b = NumerologyEngine.birth(d);
    final psychic = b.psychic.root;
    final destiny = b.destiny.root;
    final r = LuckyKit.house(_house.text, psychic, destiny);
    if (r == null) {
      return [const SizedBox(height: 12), Note(s.t(LuckyKitText.badHouse))];
    }
    final info = LuckyKitText.home[r.root]!;
    final res = r.number;
    return [
      const SizedBox(height: 18),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            NumberBadge(res.total),
            const SizedBox(height: 4),
            Text(s.t(LuckyKitText.total)),
          ]),
          const SizedBox(width: 28),
          Column(children: [
            NumberBadge(res.root),
            const SizedBox(height: 4),
            Text(s.t(LuckyKitText.root)),
          ]),
        ],
      ),
      const SizedBox(height: 14),
      InfoRow(_icon(r.verdict), s.t(LuckyKitText.verdictTitle[r.verdict]!),
          s.t(LuckyKitText.verdictBody[r.verdict]!)),
      InfoRow(
          Icons.person_outline,
          '${s.t(LuckyKitText.withMulank)} ($psychic)',
          LuckyKit.relWord(r.withPsychic, s.hindi)),
      InfoRow(
          Icons.stars_outlined,
          '${s.t(LuckyKitText.withBhagyank)} ($destiny)',
          LuckyKit.relWord(r.withDestiny, s.hindi)),
      InfoRow(Icons.home_work_outlined, s.t(LuckyKitText.homeNature),
          s.t(info.theme)),
      InfoRow(Icons.group_outlined, s.t(LuckyKitText.suitsLabel), s.t(info.suits)),
      InfoRow(Icons.warning_amber_rounded, s.t(LuckyKitText.watchLabel),
          s.t(info.watch)),
      InfoRow(Icons.lightbulb_outline, s.t(LuckyKitText.tipLabel), s.t(info.tip)),
      if (!s.hindi && res.hasCheiroCompound)
        InfoRow(Icons.auto_awesome,
            '${LuckyKitText.compoundLabel.en} ${res.total}', res.compoundMeaning),
      if (r.verdict != HouseVerdict.good) ...[
        const SizedBox(height: 6),
        InfoRow(Icons.spa_outlined, s.t(LuckyKitText.stepsTitle),
            s.t(LuckyKitText.steps)),
      ],
    ];
  }

  List<Widget> _lucky(AppSettings s, DateTime d) {
    final b = NumerologyEngine.birth(d);
    final psychic = b.psychic.root;
    final destiny = b.destiny.root;
    final picks = LuckyKit.luckyNumbers(psychic, destiny);
    final avoid = LuckyKit.avoidRoots(psychic, destiny);
    final p = RootProfiles.of(psychic);
    return [
      const SizedBox(height: 22),
      SectionLabel(s.t(LuckyKitText.luckyTitle)),
      const SizedBox(height: 6),
      Note(s.t(LuckyKitText.luckyIntro)),
      const SizedBox(height: 8),
      for (final k in picks)
        InfoRow(Icons.confirmation_number_outlined, '${k.number}', s.t(k.why)),
      InfoRow(
        Icons.block,
        s.t(LuckyKitText.avoidTitle),
        avoid.isEmpty
            ? s.t(LuckyKitText.avoidNone)
            : (s.hindi
                ? 'जिन नंबरों का जोड़ ${avoid.join(", ")} बनता है, उनसे बचना बेहतर माना जाता है।'
                : 'Numbers that add up to ${avoid.join(", ")} are traditionally better avoided.'),
      ),
      if (p != null) ...[
        const SizedBox(height: 14),
        SectionLabel(s.t(LuckyKitText.kitTitle)),
        InfoRow(Icons.palette_outlined, s.t(const L('Lucky colours', 'शुभ रंग')),
            s.t(p.colours)),
        InfoRow(Icons.calendar_today_outlined,
            s.t(const L('Lucky days', 'शुभ दिन')), s.t(p.luckyDays)),
        InfoRow(Icons.diamond_outlined,
            s.t(const L('Traditional stone', 'पारंपरिक रत्न')), s.t(p.gemstone)),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final d = _date;
    return PageShell(
      title: s.t(LuckyKitText.title),
      children: [
        Note(s.t(LuckyKitText.intro)),
        const SizedBox(height: 14),
        DateField(
          label: s.t(LuckyKitText.dobLabel),
          value: _dob,
          onChanged: (v) => setState(() {
            _dob = v;
            _checked = false;
          }),
        ),
        SectionLabel(s.t(LuckyKitText.houseSection)),
        TextField(
          controller: _house,
          textCapitalization: TextCapitalization.characters,
          onChanged: (_) => setState(() => _checked = false),
          onSubmitted: (_) => _check(),
          decoration: InputDecoration(
            labelText: s.t(LuckyKitText.houseLabel),
            prefixIcon: const Icon(Icons.home_outlined),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _check,
            icon: const Icon(Icons.search),
            label: Text(s.t(LuckyKitText.check)),
          ),
        ),
        if (_checked && d == null) ...[
          const SizedBox(height: 12),
          Note(s.t(LuckyKitText.needDob)),
        ],
        if (_checked && d != null)
          FadeIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _houseResult(s, d),
            ),
          ),
        if (d != null) ..._lucky(s, d),
        const SizedBox(height: 16),
        Note(s.t(LuckyKitText.note)),
      ],
    );
  }
}
