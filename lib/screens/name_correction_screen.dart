import '../core/user_profile.dart';
import 'package:flutter/material.dart';
import '../core/numerology_engine.dart';

class NameCorrectionScreen extends StatefulWidget {
  const NameCorrectionScreen({super.key});

  @override
  State<NameCorrectionScreen> createState() =>
      _NameCorrectionScreenState();
}

class _NameCorrectionScreenState extends State<NameCorrectionScreen> {
  final TextEditingController _originalController =
      ProfileController.name();
  final TextEditingController _candidateController =
      TextEditingController();

  NumerologyResult? _originalResult;
  NumerologyResult? _candidateResult;
  String? _error;

  @override
  void dispose() {
    _originalController.dispose();
    _candidateController.dispose();
    super.dispose();
  }

  void _calculate() {
    final original = _originalController.text.trim();
    final candidate = _candidateController.text.trim();

    if (original.isEmpty || candidate.isEmpty) {
      setState(() {
        _error = 'Please enter both names to compare.';
        _originalResult = null;
        _candidateResult = null;
      });
      return;
    }

    final originalResult = NumerologyEngine.name(original);
    final candidateResult = NumerologyEngine.name(candidate);

    if (originalResult.total == 0 || candidateResult.total == 0) {
      setState(() {
        _error = 'Please enter names containing English letters A–Z.';
        _originalResult = null;
        _candidateResult = null;
      });
      return;
    }

    setState(() {
      _originalResult = originalResult;
      _candidateResult = candidateResult;
      _error = null;
    });
  }

  Widget _numberCard(String title, String name, NumerologyResult result) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontSize: 18)),
            const Divider(height: 24),
            _detailRow('Chaldean Total', '${result.total}'),
            _detailRow('Root Number', '${result.root}'),
            const SizedBox(height: 10),
            if (result.hasCheiroCompound) ...[
              const Text(
                'Compound Interpretation',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(result.compoundMeaning),
            ] else
              const Text(
                'A verified compound interpretation is not available '
                'in the current knowledge pack.',
                style: TextStyle(fontSize: 13),
              ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name Correction'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Compare Name Spellings',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Compare the numerology totals of your current name '
            'and an alternative spelling.',
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _originalController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Original Name',
              hintText: 'Enter your current name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _candidateController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Alternative Spelling',
              hintText: 'Enter the spelling to compare',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.edit_outlined),
            ),
            onSubmitted: (_) => _calculate(),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _calculate,
              icon: const Icon(Icons.compare_arrows),
              label: const Text('Compare Names'),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
          if (_originalResult != null && _candidateResult != null) ...[
            const SizedBox(height: 18),
            _numberCard(
              'Original Name',
              _originalController.text.trim(),
              _originalResult!,
            ),
            _numberCard(
              'Alternative Spelling',
              _candidateController.text.trim(),
              _candidateResult!,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Comparison Summary',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _originalResult!.total == _candidateResult!.total
                          ? 'Both spellings have the same total.'
                          : 'The totals are different: '
                              '${_originalResult!.total} versus '
                              '${_candidateResult!.total}.',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _originalResult!.root == _candidateResult!.root
                          ? 'Both spellings reduce to the same root number.'
                          : 'The root numbers are different: '
                              '${_originalResult!.root} versus '
                              '${_candidateResult!.root}.',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'A different total does not automatically mean '
                      'a better name. A meaningful recommendation '
                      'requires verified interpretations and the '
                      'person’s relevant numerology profile.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          const Text(
            'Method: Uses the app’s current Chaldean-style letter '
            'values. Numerology is a traditional belief system, '
            'not a scientifically established way to predict outcomes.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
