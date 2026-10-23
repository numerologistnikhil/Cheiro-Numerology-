import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/entitlements.dart';
import '../core/numerology_engine.dart';
import '../core/pricing.dart';
import '../core/report_share.dart';
import '../core/story_report.dart';
import 'ui_kit.dart';

class ReportBuilderScreen extends StatefulWidget {
  const ReportBuilderScreen({super.key, this.initialDob, this.initialYears});

  /// Filled when the customer comes here from the Predictions screen.
  final DateTime? initialDob;
  final int? initialYears;

  @override
  State<ReportBuilderScreen> createState() => _ReportBuilderScreenState();
}

class _ReportBuilderScreenState extends State<ReportBuilderScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  DateTime? _dob;
  bool _busy = false;
  bool _hindi = false;
  int _years = 10;
  String? _error;
  Uint8List? _pdf;
  String _pdfFor = '';

  @override
  void initState() {
    super.initState();
    _dob = widget.initialDob;
    final y = widget.initialYears;
    if (y != null && y >= 1 && y <= 50) _years = y;
  }

  @override
  void dispose() {
    _name.dispose();
    _mobile.dispose();
    super.dispose();
  }

  String _confirmText(ReportAccess access) {
    switch (access) {
      case ReportAccess.freeFirst:
        return 'Your first detailed report is free.';
      case ReportAccess.paidCredit:
        return 'This uses 1 of your paid report credits.';
      case ReportAccess.testing:
        return 'Test build: payment is not connected yet, so this report is '
            'free. Normal price: Rs ${Pricing.reportPriceRupees} per report.';
      case ReportAccess.needsPayment:
        return 'Price: Rs ${Pricing.reportPriceRupees}.';
    }
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
    setState(() => _error = null);

    final access = await Entitlements.check();
    if (!mounted) return;

    if (access == ReportAccess.needsPayment) {
      await showDialog<void>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Report: Rs ${Pricing.reportPriceRupees}'),
          content: Text(
            '${Pricing.reportIncludes}\n\nPayment is not available in this '
            'version yet.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Create detailed report?'),
        content: Text(
          'Report for: $name\n'
          'Language: ${_hindi ? 'Hindi' : 'English'}\n'
          'Future years: $_years\n\n${_confirmText(access)}\n\n'
          '${Pricing.reportIncludes}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Create report'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;

    setState(() => _busy = true);
    try {
      Uint8List? logo;
      try {
        final data = await rootBundle.load('assets/images/ankdhara_logo.png');
        logo = data.buffer.asUint8List();
      } catch (_) {
        logo = null;
      }
      final doc = await StoryReport.build(
        name: name,
        dob: dob,
        mobile: _mobile.text,
        logo: logo,
        hindi: _hindi,
        years: _years,
      );
      final bytes = await doc.save();
      await Entitlements.consume(access);
      if (mounted) {
        setState(() {
          _pdf = bytes;
          _pdfFor = name;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = 'Could not create the report. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _print() async {
    final bytes = _pdf;
    if (bytes == null) return;
    try {
      await ReportShare.printPdf(bytes);
    } catch (e) {
      _snack('Could not open the print screen. The report is still saved here.');
    }
  }

  Future<void> _share({required bool whatsapp}) async {
    final bytes = _pdf;
    if (bytes == null) return;
    final go = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(whatsapp ? 'Send on WhatsApp?' : 'Share report?'),
        content: Text(
          whatsapp
              ? 'Report of: $_pdfFor\n\nThe share list will open. Choose '
                  'WhatsApp, then pick the customer yourself. Please check '
                  'the customer name and number before sending. The app '
                  'cannot tell whether WhatsApp delivered it.'
              : 'Report of: $_pdfFor\n\nThe share list will open. Choose '
                  'where to send it and check the receiver first.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Open share list'),
          ),
        ],
      ),
    );
    if (go != true) return;
    try {
      await ReportShare.sharePdf(bytes, _pdfFor);
    } catch (e) {
      _snack('Sharing did not work. You can use Download / Print instead.');
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
        const SectionLabel('Report language'),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<bool>(
            segments: const [
              ButtonSegment<bool>(value: false, label: Text('English')),
              ButtonSegment<bool>(value: true, label: Text('हिन्दी')),
            ],
            selected: {_hindi},
            onSelectionChanged: (v) => setState(() => _hindi = v.first),
          ),
        ),
        const SectionLabel('Future years in the report'),
        Row(
          children: [
            IconButton(
              onPressed: _years > 1 ? () => setState(() => _years--) : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '$_years years of predictions',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _years < 50 ? () => setState(() => _years++) : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: [
            for (final n in [5, 10, 15, 20, 30])
              ChoiceChip(
                label: Text('$n'),
                selected: _years == n,
                onSelected: (_) => setState(() => _years = n),
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
        if (_pdf != null) ...[
          const SizedBox(height: 22),
          SectionLabel('Report ready: $_pdfFor'),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _print,
              icon: const Icon(Icons.download_outlined),
              label: const Text('Download / Print'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _share(whatsapp: false),
              icon: const Icon(Icons.share_outlined),
              label: const Text('Share PDF'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _share(whatsapp: true),
              icon: const Icon(Icons.chat_outlined),
              label: const Text('Send on WhatsApp (optional)'),
            ),
          ),
        ],
        Note(
          'Rs ${Pricing.reportPriceRupees} per detailed report. '
          '${Pricing.reportIncludes} Your first report is free. Payment is '
          'not connected in this test build.',
        ),
      ],
    );
  }
}
