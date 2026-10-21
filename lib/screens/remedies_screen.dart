import 'package:flutter/material.dart';
import '../core/knowledge_pack.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import 'ui_kit.dart';

class RemediesScreen extends StatefulWidget {
  const RemediesScreen({super.key});

  @override
  State<RemediesScreen> createState() => _RemediesScreenState();
}

class _RemediesScreenState extends State<RemediesScreen> {
  DateTime? _dob;
  int? _selected;

  BirthNumbers? get _birth =>
      _dob == null ? null : NumerologyEngine.birth(_dob!);

  Widget _card(int n) {
    final r = NumerologyTools.remedies[n]!;
    return FadeIn(
      key: ValueKey(n),
      child: GoldCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NumberBadge(n, size: 56),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Number $n  |  ${r.planet}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        KnowledgePack.rootMeaning(n),
                        style: const TextStyle(fontSize: 13.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InfoRow(Icons.palette_outlined, 'Supportive colours', r.colours),
            InfoRow(Icons.today_outlined, 'Favourable day', r.day),
            InfoRow(Icons.diamond_outlined, 'Gemstone (traditional)', r.gemstone),
            InfoRow(Icons.circle_outlined, 'Metal', r.metal),
            InfoRow(Icons.volunteer_activism_outlined, 'Charity', r.charity),
            InfoRow(Icons.self_improvement, 'Daily practice', r.practice),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final birth = _birth;
    return PageShell(
      title: 'Remedies and Gemstones',
      children: [
        const SectionLabel('Your birth date (optional)'),
        DateField(
          label: 'Select date of birth',
          value: _dob,
          onChanged: (d) => setState(() {
            _dob = d;
            _selected = NumerologyEngine.birth(d).psychic.root;
          }),
        ),
        if (birth != null) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      setState(() => _selected = birth.psychic.root),
                  child: Text('Psychic ${birth.psychic.root}'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      setState(() => _selected = birth.destiny.root),
                  child: Text('Destiny ${birth.destiny.root}'),
                ),
              ),
            ],
          ),
        ],
        const SectionLabel('Or pick a number'),
        NumberChips(
          selected: _selected,
          onSelected: (n) => setState(() => _selected = n),
        ),
        const SizedBox(height: 18),
        if (_selected != null) _card(_selected!),
        const Note(
          'Colours, days, gemstones and charity are traditional suggestions '
          'for reflection and good habits. They are not medical or financial '
          'advice and no result is guaranteed. Gemstones can be costly; '
          'buy only from a trusted jeweller and take expert advice before '
          'wearing strong stones.',
        ),
      ],
    );
  }
}
