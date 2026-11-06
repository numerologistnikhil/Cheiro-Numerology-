import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import '../core/app_settings.dart';
import '../core/famous_people.dart';
import '../core/numerology_engine.dart';
import '../core/pythagorean.dart';
import '../core/root_profiles.dart';
import '../core/story_report.dart';
import 'ui_kit.dart';

String _date(DateTime d) {
  const m = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day} ${m[d.month - 1]} ${d.year}';
}

/// List of well-known people with free sample profiles.
class FamousScreen extends StatefulWidget {
  const FamousScreen({super.key});

  @override
  State<FamousScreen> createState() => _FamousScreenState();
}

class _FamousScreenState extends State<FamousScreen> {
  String _q = '';
  int _cat = -1;

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final q = _q.trim().toLowerCase();
    final list = [
      for (final p in FamousPeople.people)
        if ((_cat < 0 || p.category == _cat) && (q.isEmpty || p.name.toLowerCase().contains(q))) p,
    ];
    return PageShell(
      title: s.t(FamousPeople.title),
      children: [
        Note(s.t(FamousPeople.intro)),
        const SizedBox(height: 12),
        TextField(
          onChanged: (v) => setState(() => _q = v),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            labelText: s.t(FamousPeople.search),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ChoiceChip(
              label: Text(s.t(FamousPeople.all)),
              selected: _cat < 0,
              onSelected: (_) => setState(() => _cat = -1),
            ),
            for (var i = 0; i < FamousPeople.categories.length; i++)
              ChoiceChip(
                label: Text(s.t(FamousPeople.categories[i])),
                selected: _cat == i,
                onSelected: (_) => setState(() => _cat = i),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (list.isEmpty) Note(s.t(FamousPeople.noMatch)),
        for (final p in list) _tile(context, s, p),
      ],
    );
  }

  Widget _tile(BuildContext context, AppSettings s, FamousPerson p) {
    final b = NumerologyEngine.birth(p.dob);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GoldCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FamousDetail(p)),
          ),
          child: Row(
            children: [
              NumberBadge(b.psychic.root, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    Text(
                      '${_date(p.dob)}  |  ${s.t(FamousPeople.categories[p.category])}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class FamousDetail extends StatefulWidget {
  final FamousPerson person;
  const FamousDetail(this.person, {super.key});

  @override
  State<FamousDetail> createState() => _FamousDetailState();
}

class _FamousDetailState extends State<FamousDetail> {
  bool _busy = false;
  String? _error;

  Future<void> _report(AppSettings s) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      Uint8List? logo;
      try {
        final data = await rootBundle.load('assets/images/ankdhara_logo.png');
        logo = data.buffer.asUint8List();
      } catch (_) {}
      await StoryReport.preview(
        name: widget.person.name,
        dob: widget.person.dob,
        logo: logo,
        hindi: s.hindi,
        sample: true,
      );
    } catch (_) {
      if (mounted) setState(() => _error = s.t(FamousPeople.failed));
    }
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final p = widget.person;
    final b = NumerologyEngine.birth(p.dob);
    final nm = NumerologyEngine.name(p.name);
    final west = Pythagorean.chart(p.dob, '').lifePath;
    final prof = RootProfiles.of(b.psychic.root);
    Widget numCol(L label, int n) => Expanded(
          child: Column(children: [
            NumberBadge(n, size: 52),
            const SizedBox(height: 6),
            Text(s.t(label), textAlign: TextAlign.center, style: const TextStyle(fontSize: 11.5)),
          ]),
        );
    return PageShell(
      title: p.name,
      children: [
        Text('${s.t(FamousPeople.born)}: ${_date(p.dob)}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        Text(s.t(FamousPeople.categories[p.category]), style: const TextStyle(fontSize: 12.5)),
        const SizedBox(height: 14),
        GoldCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              numCol(FamousPeople.mulank, b.psychic.root),
              numCol(FamousPeople.bhagyank, b.destiny.root),
              numCol(FamousPeople.nameNo, nm.root),
              numCol(FamousPeople.lifePath, west),
            ],
          ),
        ),
        if (prof != null) ...[
          SectionLabel(s.t(FamousPeople.about)),
          Text(s.t(prof.title), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 6),
          Text(s.t(prof.overview), style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _busy ? null : () => _report(s),
            icon: const Icon(Icons.picture_as_pdf_outlined),
            label: Text(s.t(_busy ? FamousPeople.making : FamousPeople.openReport)),
          ),
        ),
        const SizedBox(height: 8),
        Text(s.t(FamousPeople.free), style: const TextStyle(fontSize: 12.5)),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_error!, style: const TextStyle(color: Colors.red)),
          ),
        const SizedBox(height: 12),
        Note(s.t(FamousPeople.intro)),
      ],
    );
  }
}
