import 'package:flutter/material.dart';
import '../core/app_settings.dart';
import '../core/extra_insights.dart'
    show NumberPatterns, PatternReport, PatternFinding;
import '../core/numerology_engine.dart';
import '../core/root_profiles.dart' show L;
import 'ui_kit.dart';

/// Mobile number numerology.
class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _NumberCheck(
      title: const L('Mobile Number', 'मोबाइल नंबर'),
      label: const L('Mobile number', 'मोबाइल नंबर'),
      hint: const L('e.g. 9876543210', 'जैसे 9876543210'),
      keyboard: TextInputType.phone,
      intro: const L(
        'Enter a mobile number. You will see the total, the root number '
            'and its meaning as per Cheiro.',
        'मोबाइल नंबर डालिए। कुल जोड़, मूलांक और चीरो के हिसाब से '
            'मतलब दिखेगा।',
      ),
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
      title: const L('Vehicle Number', 'वाहन नंबर'),
      label: const L('Vehicle number', 'वाहन नंबर'),
      hint: const L('e.g. DL3CAB1234', 'जैसे DL3CAB1234'),
      keyboard: TextInputType.text,
      intro: const L(
        'Enter the vehicle number (letters and digits both work). '
            'You will see the total, the root number and the meaning.',
        'वाहन का नंबर डालिए (अक्षर और अंक दोनों चलेंगे)। कुल जोड़, '
            'मूलांक और मतलब दिखेगा।',
      ),
      calc: NumerologyEngine.vehicle,
    );
  }
}

class _NumberCheck extends StatefulWidget {
  final L title;
  final L label;
  final L hint;
  final L intro;
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
  PatternReport? _patterns;
  L? _error;

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
        _patterns = null;
        _error = const L('Please enter the number first', 'पहले नंबर लिखिए');
      });
      return;
    }
    final r = widget.calc(text);
    final empty = r.items.isEmpty;
    setState(() {
      _error = empty
          ? const L('Nothing countable was found in this number',
              'इस नंबर में गिनने लायक कुछ नहीं मिला')
          : null;
      _result = empty ? null : r;
      _patterns = empty ? null : NumberPatterns.analyze(text);
    });
  }

  IconData _patternIcon(String id) {
    switch (id) {
      case 'repeat':
        return Icons.repeat;
      case 'ascending':
        return Icons.trending_up;
      case 'descending':
        return Icons.trending_down;
      case 'palindrome':
        return Icons.flip;
      case 'alternating':
        return Icons.swap_horiz;
      default:
        return Icons.star_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final r = _result;
    final p = _patterns;
    return PageShell(
      title: s.t(widget.title),
      children: [
        Note(s.t(widget.intro)),
        const SizedBox(height: 14),
        TextField(
          controller: _c,
          keyboardType: widget.keyboard,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            labelText: s.t(widget.label),
            hintText: s.t(widget.hint),
          ),
          onSubmitted: (_) => _go(),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: _go,
          child: Text(s.t(const L('Check', 'जाँचिए'))),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Note(s.t(_error!)),
        ],
        if (r != null) ...[
          const SizedBox(height: 18),
          SectionLabel(s.t(const L('Result', 'नतीजा'))),
          const SizedBox(height: 8),
          FadeIn(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  NumberBadge(r.total),
                  const SizedBox(height: 4),
                  Text(s.t(const L('Total', 'कुल जोड़'))),
                ]),
                const SizedBox(width: 28),
                Column(children: [
                  NumberBadge(r.root),
                  const SizedBox(height: 4),
                  Text(s.t(const L('Root', 'मूलांक'))),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 14),
          InfoRow(
            Icons.timeline,
            s.t(const L('Reduction', 'जोड़ते जाना')),
            r.reductionChain.join('  ->  '),
          ),
          if (r.hasCheiroCompound)
            InfoRow(
              Icons.auto_awesome,
              s.t(L('Compound ${r.total}', 'कंपाउंड ${r.total}')),
              r.compoundMeaning,
            ),
          if (p != null) ...[
            const SizedBox(height: 14),
            SectionLabel(s.t(
                const L('Number pattern (digits only)', 'नंबर का पैटर्न (सिर्फ़ अंक)'))),
            const SizedBox(height: 8),
            if (p.findings.isEmpty)
              Note(s.t(const L(
                  'No special pattern found in the digits of this number.',
                  'इस नंबर के अंकों में कोई खास पैटर्न नहीं मिला।')))
            else
              ...p.findings.map((PatternFinding f) => InfoRow(
                    _patternIcon(f.id),
                    f.title.of(s.hindi),
                    f.message.of(s.hindi),
                  )),
          ],
          const SizedBox(height: 10),
          SectionLabel(s.t(const L('How it was counted', 'कैसे गिना'))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: r.items.map((i) => Pill('${i.symbol} = ${i.value}')).toList(),
          ),
          if (r.ignored.isNotEmpty) ...[
            const SizedBox(height: 10),
            Note('${s.t(const L('Skipped:', 'छोड़े गए:'))} ${r.ignored.join(' ')}'),
          ],
        ],
      ],
    );
  }
}
