import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/numerology_tools.dart';
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

  void _find() {
    final d = _dob;
    if (d == null) return;
    setState(() {
      _dates = NumerologyTools.suggestDates(d, _purpose, DateTime.now());
    });
  }

  Widget _tile(DateSuggestion s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            NumberBadge(s.dayNumber, size: 44),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDate(s.date),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Day number ${s.dayNumber}  |  Full date number ${s.fullNumber}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AnkdharaColors.gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (s.score >= 5) const Pill('Strong'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dates = _dates;
    return PageShell(
      title: 'Date Selection',
      children: [
        const SectionLabel('Birth date of the main person'),
        DateField(
          label: 'Select date of birth',
          value: _dob,
          onChanged: (d) => setState(() {
            _dob = d;
            _dates = null;
          }),
        ),
        const SectionLabel('Purpose'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in NumerologyTools.purposeFavoured.keys)
              ChoiceChip(
                label: Text(p),
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
            onPressed: _dob == null ? null : _find,
            icon: const Icon(Icons.event_available),
            label: const Text('Find Dates (next 45 days)'),
          ),
        ),
        const SizedBox(height: 16),
        if (dates != null && dates.isEmpty)
          const Note('No dates matched in the next 45 days. Try another purpose.'),
        if (dates != null && dates.isNotEmpty)
          FadeIn(child: Column(children: [for (final s in dates) _tile(s)])),
        const Note(
          'Dates are chosen so the day number and full-date number are not '
          'challenging for the birth numbers, with a small bonus for numbers '
          'traditionally linked with the purpose. Always check practical '
          'factors first: availability, legal requirements, weather and '
          'family convenience. Where your family follows a panchang, '
          'consult it too.',
        ),
      ],
    );
  }
}
