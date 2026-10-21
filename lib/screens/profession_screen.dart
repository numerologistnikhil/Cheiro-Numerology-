import 'package:flutter/material.dart';
import '../core/knowledge_pack.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import 'ui_kit.dart';

class ProfessionScreen extends StatefulWidget {
  const ProfessionScreen({super.key});

  @override
  State<ProfessionScreen> createState() => _ProfessionScreenState();
}

class _ProfessionScreenState extends State<ProfessionScreen> {
  DateTime? _dob;

  Widget _section(String title, int n) {
    final list = NumerologyTools.professions[n] ?? const <String>[];
    return GoldCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NumberBadge(n, size: 48),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      NumerologyTools.planetOf(n),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            KnowledgePack.rootMeaning(n),
            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 10),
          for (final p in list)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.check_circle_outline, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(p, style: const TextStyle(fontSize: 14.5))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dob = _dob;
    BirthNumbers? birth;
    if (dob != null) birth = NumerologyEngine.birth(dob);
    return PageShell(
      title: 'Profession Guidance',
      children: [
        const SectionLabel('Birth date'),
        DateField(
          label: 'Select date of birth',
          value: dob,
          onChanged: (d) => setState(() => _dob = d),
        ),
        const SizedBox(height: 16),
        if (birth == null)
          const Note('Choose a date of birth to see work areas that suit the birth numbers.')
        else
          FadeIn(
            child: Column(
              children: [
                _section('Psychic ${birth.psychic.root}: natural talent', birth.psychic.root),
                const SizedBox(height: 14),
                _section('Destiny ${birth.destiny.root}: life direction', birth.destiny.root),
                const Note(
                  'Psychic shows what comes naturally; destiny shows the '
                  'direction life tends to push you. Interest, skill, '
                  'education and opportunity decide a career far more than '
                  'any number. Treat this as ideas to explore.',
                ),
              ],
            ),
          ),
      ],
    );
  }
}
