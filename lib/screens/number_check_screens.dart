import 'package:flutter/material.dart';
import '../core/numerology_engine.dart';
import 'ui_kit.dart';

/// Mobile number numerology.
class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _NumberCheck(
      title: 'Mobile Number',
      label: 'Mobile number',
      hint: 'Jaise 9876543210',
      keyboard: TextInputType.phone,
      intro:
          'Apna ya kisi ka mobile number daalo. Total, root number aur '
          'Cheiro ke hisaab se matlab dikhega.',
      calc: NumerologyEngine.mobile,
    );
  }
}

/// Vehicle number numerology.
class VehicleNumberScreen extends StatelessWidget {
  const VehicleNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _NumberCheck(
      title: 'Vehicle Number',
      label: 'Gaadi ka number',
      hint: 'Jaise DL3CAB1234',
      keyboard: TextInputType.text,
      intro:
          'Gaadi ka number daalo (letters aur digits dono chalenge). '
          'Total, root number aur matlab dikhega.',
      calc: NumerologyEngine.vehicle,
    );
  }
}

class _NumberCheck extends StatefulWidget {
  final String title;
  final String label;
  final String hint;
  final String intro;
  final TextInputType keyboard;
  final NumerologyResult Function(String) calc;

  const _NumberCheck({
    required this.title,
    required this.label,
    required this.hint,
    required this.intro,
    required this.keyboard,
    required this.calc,
  });

  @override
  State<_NumberCheck> createState() => _NumberCheckState();
}

class _NumberCheckState extends State<_NumberCheck> {
  final TextEditingController _c = TextEditingController();
  NumerologyResult? _result;
  String? _error;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _go() {
    final text = _c.text.trim();
    FocusScope.of(context).unfocus();
    if (text.isEmpty) {
      setState(() {
        _result = null;
        _error = 'Pehle number likho';
      });
      return;
    }
    final r = widget.calc(text);
    setState(() {
      _error = r.items.isEmpty ? 'Is number me kuch ginne layak nahi mila' : null;
      _result = r.items.isEmpty ? null : r;
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = _result;
    return PageShell(
      title: widget.title,
      children: [
        Note(widget.intro),
        const SizedBox(height: 14),
        TextField(
          controller: _c,
          keyboardType: widget.keyboard,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
          ),
          onSubmitted: (_) => _go(),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: _go, child: const Text('Check karo')),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Note(_error!),
        ],
        if (r != null) ...[
          const SizedBox(height: 18),
          const SectionLabel('Result'),
          const SizedBox(height: 8),
          FadeIn(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  NumberBadge(r.total),
                  const SizedBox(height: 4),
                  const Text('Total'),
                ]),
                const SizedBox(width: 28),
                Column(children: [
                  NumberBadge(r.root),
                  const SizedBox(height: 4),
                  const Text('Root'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 14),
          InfoRow(Icons.timeline, 'Reduction', r.reductionChain.join('  ->  ')),
          if (r.hasCheiroCompound)
            InfoRow(Icons.auto_awesome, 'Compound ${r.total}', r.compoundMeaning),
          const SizedBox(height: 10),
          const SectionLabel('Kaise gina'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: r.items.map((i) => Pill('${i.symbol} = ${i.value}')).toList(),
          ),
          if (r.ignored.isNotEmpty) ...[
            const SizedBox(height: 10),
            Note('Ye skip hue: ${r.ignored.join(' ')}'),
          ],
        ],
      ],
    );
  }
}
