import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/knowledge_pack.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import 'ui_kit.dart';

class BabyNamesScreen extends StatefulWidget {
  const BabyNamesScreen({super.key});

  @override
  State<BabyNamesScreen> createState() => _BabyNamesScreenState();
}

class _BabyNamesScreenState extends State<BabyNamesScreen> {
  DateTime? _dob;
  bool _boy = true;
  final TextEditingController _letter = TextEditingController();
  List<NameSuggestion>? _list;

  @override
  void dispose() {
    _letter.dispose();
    super.dispose();
  }

  void _suggest() {
    final d = _dob;
    if (d == null) return;
    setState(() {
      _list = NumerologyTools.suggestNames(
        d,
        boy: _boy,
        startsWith: _letter.text,
      );
    });
  }

  Widget _tile(NameSuggestion s) {
    final entry = KnowledgePack.compoundEntry(s.result.total);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            NumberBadge(s.result.root, size: 46),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.baby.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    s.baby.meaning,
                    style: const TextStyle(fontSize: 13.5),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total ${s.result.total}'
                    '${entry != null ? '  |  ${entry.title}' : ''}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AnkdharaColors.gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (s.score >= 4) const Pill('Best match'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = _list;
    BirthNumbers? birth;
    if (_dob != null) birth = NumerologyEngine.birth(_dob!);
    return PageShell(
      title: 'Baby Names',
      children: [
        const SectionLabel('Baby\'s birth date'),
        DateField(usesProfile: false,

          label: 'Select date of birth',
          value: _dob,
          lastDate: DateTime(2100),
          onChanged: (d) => setState(() {
            _dob = d;
            _list = null;
          }),
        ),
        if (birth != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Psychic ${birth.psychic.root}  |  Destiny ${birth.destiny.root}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AnkdharaColors.gold,
              ),
            ),
          ),
        const SectionLabel('Boy or girl'),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              label: const Text('Boy'),
              selected: _boy,
              selectedColor: AnkdharaColors.goldLight,
              onSelected: (_) => setState(() {
                _boy = true;
                _list = null;
              }),
            ),
            ChoiceChip(
              label: const Text('Girl'),
              selected: !_boy,
              selectedColor: AnkdharaColors.goldLight,
              onSelected: (_) => setState(() {
                _boy = false;
                _list = null;
              }),
            ),
          ],
        ),
        const SectionLabel('Starting letter (optional)'),
        TextField(
          controller: _letter,
          maxLength: 2,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            labelText: 'For example S',
            counterText: '',
            prefixIcon: Icon(Icons.sort_by_alpha),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _dob == null ? null : _suggest,
            icon: const Icon(Icons.child_care),
            label: const Text('Suggest Names'),
          ),
        ),
        const SizedBox(height: 16),
        if (list != null && list.isEmpty)
          const Note('No names in the built-in list match. Try another starting letter or clear it.'),
        if (list != null && list.isNotEmpty)
          FadeIn(
            child: Column(children: [for (final s in list) _tile(s)]),
          ),
        const Note(
          'Names come from a built-in list of popular Indian names. A name '
          'is shown when its root number is not challenging for the '
          'baby\'s psychic or destiny number. Meanings are short summaries; '
          'choose a name your family loves and can pronounce easily.',
        ),
      ],
    );
  }
}
