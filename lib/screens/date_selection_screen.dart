import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/date_reasons.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import '../core/root_profiles.dart' show L;
import '../core/user_profile.dart';
import 'ui_kit.dart';

class DateSelectionScreen extends StatefulWidget {
  const DateSelectionScreen({super.key});

  @override
  State<DateSelectionScreen> createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  DateTime? _dob;
  String _purpose = 'Business start';
  List<DateSuggestion>? _dates;
  DateTime? _usedDob;

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded().then((_) {
      if (mounted) setState(() {});
    });
  }

  DateTime? get _date => _dob ?? UserProfile.instance.dob;

  void _find() {
    final d = _date;
    if (d == null) return;
    setState(() {
      _usedDob = d;
      _dates = NumerologyTools.suggestDates(d, _purpose, DateTime.now());
    });
  }

  Widget _tile(AppSettings s, DateSuggestion d) {
    final birth = NumerologyEngine.birth(_usedDob ?? _date!);
    final psychic = birth.psychic.root;
    final destiny = birth.destiny.root;
    final why = DateReasons.reasons(d, psychic, destiny, _purpose);
    final idea = _purpose == 'Business start' ? DateReasons.businessIdeas[d.dayNumber] : null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GoldCard(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 8),
            childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            leading: NumberBadge(d.dayNumber, size: 44),
            title: Text(formatDate(d.date),
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
            subtitle: Text(
              '${s.t(DateReasons.dayNo)} ${d.dayNumber}  |  ${s.t(DateReasons.fullNo)} ${d.fullNumber}',
              style: const TextStyle(
                  fontSize: 12.5, color: AnkdharaColors.gold, fontWeight: FontWeight.w700),
            ),
            trailing: d.score >= 5 ? Pill(s.t(DateReasons.strong)) : null,
            children: [
              Text(s.t(DateReasons.whyTitle),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
              for (final l in why)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('•  ${s.t(l)}', style: const TextStyle(fontSize: 13.5, height: 1.4)),
                ),
              if (idea != null) ...[
                const SizedBox(height: 10),
                Text(s.t(DateReasons.ideasTitle),
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(s.t(idea), style: const TextStyle(fontSize: 13.5, height: 1.4)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final dates = _dates;
    return PageShell(
      title: s.t(DateReasons.title),
      children: [
        SectionLabel(s.t(DateReasons.pickBirth)),
        DateField(
          label: s.t(DateReasons.pickDate),
          value: _dob,
          onChanged: (d) => setState(() {
            _dob = d;
            _dates = null;
          }),
        ),
        SectionLabel(s.t(DateReasons.purposeLabel)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in NumerologyTools.purposeFavoured.keys)
              ChoiceChip(
                label: Text(s.t(DateReasons.purposeNames[p] ?? L(p, p))),
                selected: _purpose == p,
                selectedColor: AnkdharaColors.goldLight,
                onSelected: (_) => setState(() {
                  _purpose = p;
                  _dates = null;
                }),
              ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _date == null ? null : _find,
            icon: const Icon(Icons.event_available),
            label: Text(s.t(DateReasons.findBtn)),
          ),
        ),
        const SizedBox(height: 16),
        if (dates != null && dates.isEmpty) Note(s.t(DateReasons.noDates)),
        if (dates != null && dates.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(s.t(DateReasons.tapHint),
                style: const TextStyle(fontSize: 12.5, fontStyle: FontStyle.italic)),
          ),
          FadeIn(child: Column(children: [for (final d in dates) _tile(s, d)])),
        ],
        if (_purpose == 'Business start') ...[
          InfoRow(Icons.storefront_outlined, s.t(DateReasons.launchTitle),
              s.t(DateReasons.launchBody)),
        ],
        Note(s.t(DateReasons.practicalNote)),
      ],
    );
  }
}
