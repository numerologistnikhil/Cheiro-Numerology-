import 'profile_screen.dart';
import '../core/user_profile.dart';
import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/knowledge_pack.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import 'ui_kit.dart';

/// Offline question guide. It answers from the app's own knowledge pack and
/// calculations; nothing is sent over the internet. A conversational online
/// assistant is planned for later and will need the person's consent.
class AiNumerologistScreen extends StatefulWidget {
  const AiNumerologistScreen({super.key});

  @override
  State<AiNumerologistScreen> createState() => _AiNumerologistScreenState();
}

class _AiNumerologistScreenState extends State<AiNumerologistScreen> {
  static const List<String> _topics = [
    'Career',
    'Money',
    'Relationships',
    'My name',
    'This year',
  ];

  final TextEditingController _name = ProfileController.name();
  DateTime? _dob;
  String _topic = 'Career';
  List<String>? _answer;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  List<String> _compose(DateTime dob, String name, String topic) {
    final birth = NumerologyEngine.birth(dob);
    final entry = KnowledgePack.compoundEntry(birth.destiny.total);
    final psychic = birth.psychic.root;
    final destiny = birth.destiny.root;
    final lines = <String>[];

    switch (topic) {
      case 'Career':
        if (entry != null) lines.add(entry.work);
        lines.add(
          'Your psychic number $psychic points towards: '
          '${NumerologyTools.professions[psychic]!.take(3).join('; ')}.',
        );
        lines.add(
          'Your destiny number $destiny adds: '
          '${NumerologyTools.professions[destiny]!.take(2).join('; ')}.',
        );
        break;
      case 'Money':
        if (entry != null) lines.add(entry.money);
        lines.add(
          'Root $destiny is read as: ${KnowledgePack.rootMeaning(destiny)} '
          'Steady habits matter more than any number.',
        );
        break;
      case 'Relationships':
        if (entry != null) lines.add(entry.relationships);
        lines.add(
          'Psychic $psychic and destiny $destiny shape how you relate and '
          'what you look for. Use the Compatibility module to compare with '
          'a partner.',
        );
        break;
      case 'My name':
        final n = NumerologyEngine.name(name);
        if (n.total == 0) {
          lines.add('Please enter a name with English letters A-Z to read it.');
        } else {
          final e = KnowledgePack.compoundEntry(n.total);
          lines.add('Your name totals ${n.total} with root ${n.root}.');
          if (e != null) lines.add('${e.title}. ${e.summary}');
          final r1 = NumerologyTools.relation(n.root, psychic);
          final r2 = NumerologyTools.relation(n.root, destiny);
          lines.add(
            'With your psychic $psychic the name is '
            '${NumerologyTools.relationLabel(r1).toLowerCase()}, and with '
            'your destiny $destiny it is '
            '${NumerologyTools.relationLabel(r2).toLowerCase()}. The Name '
            'Correction module lets you compare spellings.',
          );
        }
        break;
      default:
        final year = DateTime.now().year;
        final py = NumerologyTools.personalYear(dob, year);
        final t = NumerologyTools.yearThemes[py]!;
        lines.add('Personal Year $py in $year: ${t.title}.');
        lines.add(t.theme);
        lines.add('Focus on: ${t.focus}');
        lines.add('Be careful of: ${t.caution}');
    }
    return lines;
  }

  void _ask() {
    final dob = _dob;
    if (dob == null) {
      setState(() => _error = 'Please select the date of birth first.');
      return;
    }
    setState(() {
      _error = null;
      _answer = _compose(dob, _name.text, _topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    final answer = _answer;
    return PageShell(
      title: 'Ask Your Numbers',
      children: [
        const SectionLabel('Your details'),
        ProfileHide(child: TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Full name (needed for "My name")',
            prefixIcon: Icon(Icons.person_outline),
          ),
        )),
        const SizedBox(height: 12),
        DateField(
          label: 'Date of birth',
          value: _dob,
          onChanged: (d) => setState(() {
            _dob = d;
            _answer = null;
          }),
        ),
        const SectionLabel('What do you want to know about?'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final t in _topics)
              ChoiceChip(
                label: Text(t),
                selected: _topic == t,
                selectedColor: AnkdharaColors.goldLight,
                onSelected: (_) => setState(() {
                  _topic = t;
                  _answer = null;
                }),
              ),
          ],
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(_error!, style: const TextStyle(color: Colors.red)),
          ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _ask,
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Get Guidance'),
          ),
        ),
        const SizedBox(height: 16),
        if (answer != null)
          FadeIn(
            child: GoldCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_topic, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  for (final line in answer)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        line,
                        style: const TextStyle(fontSize: 14.5, height: 1.6),
                      ),
                    ),
                ],
              ),
            ),
          ),
        const Note(
          'This guide works fully offline from the app\'s own numerology '
          'knowledge; nothing leaves your phone. It is not an artificial '
          'intelligence chat. A conversational AI numerologist may be added '
          'later and will run only if you agree. Guidance is for reflection '
          'and does not guarantee outcomes.',
        ),
      ],
    );
  }
}
