import 'package:flutter/material.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import 'analysis_card.dart';
import 'ui_kit.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  final TextEditingController _name = TextEditingController();
  DateTime? _owner;
  NumerologyResult? _result;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _analyse() {
    final r = NumerologyEngine.name(_name.text);
    if (r.total == 0) {
      setState(() {
        _result = null;
        _error = 'Please enter a business name using English letters A-Z.';
      });
      return;
    }
    setState(() {
      _result = r;
      _error = null;
    });
  }

  Widget _ownerMatch(NumerologyResult r) {
    final owner = _owner;
    if (owner == null) {
      return const Note(
        'Add the owner\'s date of birth above to see how well this name '
        'matches the owner\'s psychic and destiny numbers.',
      );
    }
    final b = NumerologyEngine.birth(owner);
    final score = NumerologyTools.businessScore(
      r.root,
      b.psychic.root,
      b.destiny.root,
    );
    final r1 = NumerologyTools.relation(r.root, b.psychic.root);
    final r2 = NumerologyTools.relation(r.root, b.destiny.root);
    return GoldCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Match with the owner',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Name root ${r.root} with psychic ${b.psychic.root}: '
            '${NumerologyTools.relationLabel(r1)}',
          ),
          const SizedBox(height: 4),
          Text(
            'Name root ${r.root} with destiny ${b.destiny.root}: '
            '${NumerologyTools.relationLabel(r2)}',
          ),
          const SizedBox(height: 12),
          Text(
            NumerologyTools.businessVerdict(score),
            style: const TextStyle(fontWeight: FontWeight.w700, height: 1.5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = _result;
    return PageShell(
      title: 'Business Name',
      children: [
        const SectionLabel('Business name'),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Business or brand name',
            prefixIcon: Icon(Icons.storefront),
          ),
        ),
        const SectionLabel('Owner (optional)'),
        DateField(
          label: 'Owner\'s date of birth',
          value: _owner,
          onChanged: (d) => setState(() => _owner = d),
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
            onPressed: _analyse,
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Analyse Name'),
          ),
        ),
        const SizedBox(height: 18),
        if (r != null) ...[
          AnalysisCard(title: 'Business Name', result: r),
          _ownerMatch(r),
          const Note(
            'A good business rests on product, service, timing and effort. '
            'Use the numbers only as one extra check when choosing between '
            'names, and remember that spelling changes the total.',
          ),
        ],
      ],
    );
  }
}
