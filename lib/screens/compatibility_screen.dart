import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import 'ui_kit.dart';

class CompatibilityScreen extends StatefulWidget {
  const CompatibilityScreen({super.key});

  @override
  State<CompatibilityScreen> createState() => _CompatibilityScreenState();
}

class _CompatibilityScreenState extends State<CompatibilityScreen> {
  DateTime? _a;
  DateTime? _b;
  CompatibilityResult? _result;

  void _check() {
    final a = _a;
    final b = _b;
    if (a == null || b == null) return;
    setState(() => _result = NumerologyTools.compatibility(a, b));
  }

  Widget _personNumbers(String title, DateTime d) {
    final n = NumerologyEngine.birth(d);
    return Expanded(
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  NumberBadge(n.psychic.root, size: 44),
                  const SizedBox(height: 4),
                  const Text('Psychic', style: TextStyle(fontSize: 11.5)),
                ]),
                Column(children: [
                  NumberBadge(n.destiny.root, size: 44),
                  const SizedBox(height: 4),
                  const Text('Destiny', style: TextStyle(fontSize: 11.5)),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultView(CompatibilityResult r) {
    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              _personNumbers('First person', _a!),
              const SizedBox(width: 12),
              _personNumbers('Second person', _b!),
            ],
          ),
          const SectionLabel('Result'),
          GoldCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.label, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: r.score / r.maxScore,
                    minHeight: 12,
                    backgroundColor: AnkdharaColors.cream,
                    color: AnkdharaColors.gold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Harmony points: ${r.score} of ${r.maxScore}',
                  style: const TextStyle(fontSize: 12.5),
                ),
                const SizedBox(height: 12),
                Text(r.advice, style: const TextStyle(fontSize: 14.5, height: 1.55)),
                const SizedBox(height: 12),
                for (final line in r.lines)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text('• $line', style: const TextStyle(fontSize: 13.5)),
                  ),
              ],
            ),
          ),
          const Note(
            'Friendly, neutral and challenging pairs follow general '
            'traditional guidance; different books vary slightly. A number '
            'match can never decide a relationship on its own.',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ready = _a != null && _b != null;
    return PageShell(
      title: 'Compatibility',
      children: [
        const SectionLabel('First person'),
        DateField(
          label: 'Date of birth',
          value: _a,
          onChanged: (d) => setState(() {
            _a = d;
            _result = null;
          }),
        ),
        const SectionLabel('Second person'),
        DateField(
          label: 'Date of birth',
          value: _b,
          onChanged: (d) => setState(() {
            _b = d;
            _result = null;
          }),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: ready ? _check : null,
            icon: const Icon(Icons.favorite_border),
            label: const Text('Check Compatibility'),
          ),
        ),
        if (_result != null) _resultView(_result!),
      ],
    );
  }
}
