import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/cheiro_timing.dart';
import '../core/numerology_engine.dart';
import '../core/root_profiles.dart' show L;
import '../core/user_profile.dart';
import 'ui_kit.dart';

class CheiroTimingScreen extends StatefulWidget {
  const CheiroTimingScreen({super.key});

  @override
  State<CheiroTimingScreen> createState() => _CheiroTimingScreenState();
}

class _CheiroTimingScreenState extends State<CheiroTimingScreen> {
  DateTime? _dob;
  int _year = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  DateTime? get _date => _dob ?? UserProfile.instance.dob;

  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  Color _col(TimingMood m) {
    switch (m) {
      case TimingMood.favourable:
        return const Color(0xFF2E7D32);
      case TimingMood.steady:
        return const Color(0xFFB8860B);
      case TimingMood.careful:
        return const Color(0xFFC0392B);
    }
  }

  Widget _chip(AppSettings s, TimingMood m) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _col(m).withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _col(m)),
        ),
        child: Text(s.t(CheiroTiming.moodName[m]!),
            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: _col(m))),
      );

  List<Widget> _detail(AppSettings s, TimingPeriod p) {
    final e = p.entry;
    return [
      Text('${p.steps}  ->  ${p.total}${p.total > 9 ? '/${p.root}' : ''}',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
      const SizedBox(height: 6),
      Text(s.t(CheiroTiming.rootTone[p.root]!), style: const TextStyle(fontSize: 14, height: 1.45)),
      const SizedBox(height: 6),
      Text(s.t(CheiroTiming.moodLine[p.mood]!), style: const TextStyle(fontSize: 14, height: 1.45)),
      if (p.heavy)
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(s.t(CheiroTiming.heavyNote),
              style: const TextStyle(fontSize: 13.5, color: Color(0xFFC0392B))),
        ),
      if (e != null) ...[
        const SizedBox(height: 8),
        Text('${s.t(CheiroTiming.compoundHead)} ${p.total}: ${e.title}',
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
        if (s.hindi)
          Text(s.t(CheiroTiming.englishNote), style: const TextStyle(fontSize: 11.5)),
        const SizedBox(height: 4),
        Text(e.summary, style: const TextStyle(fontSize: 13.5, height: 1.45)),
        const SizedBox(height: 4),
        Text('${s.t(CheiroTiming.cautions)}: ${e.cautions}',
            style: const TextStyle(fontSize: 13.5, height: 1.45)),
        const SizedBox(height: 4),
        Text('${s.t(CheiroTiming.advice)}: ${e.advice}',
            style: const TextStyle(fontSize: 13.5, height: 1.45)),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final d = _date;
    final now = DateTime.now();
    final kids = <Widget>[
      Note(s.t(CheiroTiming.intro)),
      InfoRow(Icons.calculate_outlined, s.t(CheiroTiming.method), s.t(CheiroTiming.methodBody)),
      const SizedBox(height: 10),
      DateField(
        label: s.hindi ? 'आपकी जन्म तिथि' : 'Your date of birth',
        value: _dob,
        onChanged: (v) => setState(() => _dob = v),
      ),
      const SizedBox(height: 10),
      Row(children: [
        Text('${s.t(CheiroTiming.pickYear)}:  ', style: const TextStyle(fontWeight: FontWeight.w700)),
        DropdownButton<int>(
          value: _year,
          items: [
            for (var y = now.year - 1; y <= now.year + 10; y++)
              DropdownMenuItem(value: y, child: Text('$y')),
          ],
          onChanged: (v) => setState(() => _year = v ?? _year),
        ),
      ]),
    ];
    if (d != null) {
      final b = NumerologyEngine.birth(d);
      final mu = b.psychic.root;
      final bh = b.destiny.root;
      final y = CheiroTiming.year(d, _year, mu, bh);
      kids.add(SectionLabel('${s.t(CheiroTiming.yearHead)} $_year'));
      kids.add(GoldCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              NumberBadge(y.root, size: 46),
              const SizedBox(width: 12),
              Expanded(child: Text('${s.t(CheiroTiming.tone)}', style: const TextStyle(fontWeight: FontWeight.w800))),
              _chip(s, y.mood),
            ]),
            const SizedBox(height: 8),
            ..._detail(s, y),
          ],
        ),
      ));

      kids.add(SectionLabel(s.t(CheiroTiming.monthsHead)));
      for (var m = 1; m <= 12; m++) {
        final p = CheiroTiming.month(d, _year, m, mu, bh);
        kids.add(Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GoldCard(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                leading: NumberBadge(p.root, size: 38),
                title: Text('${_months[m - 1]} $_year',
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text('${p.total}${p.total > 9 ? '/${p.root}' : ''}',
                    style: const TextStyle(fontSize: 12)),
                trailing: _chip(s, p.mood),
                children: _detail(s, p),
              ),
            ),
          ),
        ));
      }

      // Next 30 days
      final today = DateTime(now.year, now.month, now.day);
      final days = <MapEntry<DateTime, TimingPeriod>>[
        for (var i = 0; i < 30; i++)
          () {
            final dt = today.add(Duration(days: i));
            return MapEntry(dt, CheiroTiming.day(d, dt, mu, bh));
          }(),
      ];
      final best = days.where((e) => e.value.mood == TimingMood.favourable && !e.value.heavy).take(5).toList();
      final care = days.where((e) => e.value.mood == TimingMood.careful || e.value.heavy).take(5).toList();
      String fmt(DateTime x) => '${x.day} ${_months[x.month - 1]}';
      kids.add(SectionLabel(s.t(CheiroTiming.daysHead)));
      kids.add(InfoRow(Icons.thumb_up_alt_outlined, s.t(CheiroTiming.bestDays),
          best.isEmpty ? '-' : best.map((e) => '${fmt(e.key)} (${e.value.total})').join(',  ')));
      kids.add(InfoRow(Icons.slow_motion_video_outlined, s.t(CheiroTiming.careDays),
          care.isEmpty ? '-' : care.map((e) => '${fmt(e.key)} (${e.value.total})').join(',  ')));
      for (final e in days) {
        kids.add(Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(children: [
            SizedBox(width: 62, child: Text(fmt(e.key), style: const TextStyle(fontWeight: FontWeight.w700))),
            SizedBox(width: 56, child: Text('${e.value.total}/${e.value.root}', style: const TextStyle(fontSize: 13))),
            _chip(s, e.value.mood),
            if (e.value.heavy) const Padding(padding: EdgeInsets.only(left: 6), child: Icon(Icons.warning_amber, size: 16, color: Color(0xFFC0392B))),
          ]),
        ));
      }
    }
    kids.add(const SizedBox(height: 14));
    kids.add(Note(s.t(CheiroTiming.closing)));
    return PageShell(title: s.t(CheiroTiming.title), children: kids);
  }
}
