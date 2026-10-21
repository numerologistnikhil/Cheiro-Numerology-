import 'package:flutter/material.dart';
import '../core/numerology_engine.dart';
import '../core/pdf_report.dart';
import 'ui_kit.dart';

class ReportBuilderScreen extends StatefulWidget {
  const ReportBuilderScreen({super.key});

  @override
  State<ReportBuilderScreen> createState() => _ReportBuilderScreenState();
}

class _ReportBuilderScreenState extends State<ReportBuilderScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  DateTime? _dob;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    super.dispose();
  }

  Future<void> _make() async {
    final name = _name.text.trim();
    final dob = _dob;
    if (name.isEmpty || dob == null) {
      setState(() => _error = 'Please enter the full name and date of birth.');
      return;
    }
    if (NumerologyEngine.name(name).total == 0) {
      setState(() => _error = 'The name needs English letters A-Z.');
      return;
    }
    setState(() {
      _error = null;
      _busy = true;
    });
    try {
      await ReportBuilder.previewFull(
        name: name,
        dob: dob,
        mobile: _mobile.text,
      );
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Could not create the report. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Report Builder',
      children: [
        const SectionLabel('Report details'),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Full name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 12),
        DateField(
          label: 'Date of birth',
          value: _dob,
          onChanged: (d) => setState(() => _dob = d),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _mobile,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Mobile number (optional)',
            prefixIcon: Icon(Icons.phone_android),
          ),
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
            onPressed: _busy ? null : _make,
            icon: _busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.picture_as_pdf_outlined),
            label: Text(_busy ? 'Preparing...' : 'Create PDF Report'),
          ),
        ),
        const Note(
          'The report has core numbers, name analysis, personal year cycle '
          'and supportive habits, over several pages. Choose "Save as PDF" '
          'on the print screen to keep a copy or share it. Reports are in '
          'English for now. Paid reports and subscription (Google Play '
          'Billing) are not connected in this build, so reports are free '
          'to preview.',
        ),
      ],
    );
  }
}
