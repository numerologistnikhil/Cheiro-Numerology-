import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/feedback_config.dart';
import '../core/feedback_texts.dart';
import '../core/rate_app.dart';
import 'ui_kit.dart';

/// Customers write a suggestion here. It goes to the owner's Google Form.
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _msg = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  int _type = 0;
  int _stars = 0;
  bool _busy = false;
  String? _status;
  bool _ok = false;

  @override
  void dispose() {
    _msg.dispose();
    _contact.dispose();
    super.dispose();
  }

  Future<void> _send(AppSettings s) async {
    FocusScope.of(context).unfocus();
    if (_msg.text.trim().length < 5) {
      setState(() {
        _ok = false;
        _status = s.t(FeedbackTexts.tooShort);
      });
      return;
    }
    if (!FeedbackConfig.connected) {
      setState(() {
        _ok = false;
        _status = s.t(FeedbackTexts.notConnected);
      });
      return;
    }
    setState(() {
      _busy = true;
      _status = null;
    });
    try {
      final body = <String, String>{
        FeedbackConfig.entryMessage: _msg.text.trim(),
        if (FeedbackConfig.entryType.isNotEmpty)
          FeedbackConfig.entryType: FeedbackTexts.typeValues[_type],
        if (FeedbackConfig.entryRating.isNotEmpty && _stars > 0)
          FeedbackConfig.entryRating: '$_stars',
        if (FeedbackConfig.entryContact.isNotEmpty &&
            _contact.text.trim().isNotEmpty)
          FeedbackConfig.entryContact: _contact.text.trim(),
        if (FeedbackConfig.entryApp.isNotEmpty)
          FeedbackConfig.entryApp:
              'Ank Dhara, ${s.hindi ? 'Hindi' : 'English'}',
      };
      final r = await http
          .post(Uri.parse(FeedbackConfig.formResponseUrl), body: body)
          .timeout(const Duration(seconds: 20));
      // A Google Form answers 200, or 302 after it saved the answer.
      final good = r.statusCode >= 200 && r.statusCode < 400;
      if (!mounted) return;
      setState(() {
        _ok = good;
        _status = s.t(good ? FeedbackTexts.thanks : FeedbackTexts.failed);
        if (good) {
          _msg.clear();
          _contact.clear();
          _stars = 0;
        }
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _ok = false;
          _status = s.t(FeedbackTexts.failed);
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    return PageShell(
      title: s.t(FeedbackTexts.title),
      children: [
        Note(s.t(FeedbackTexts.intro)),
        SectionLabel(s.t(FeedbackTexts.typeLabel)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < FeedbackTexts.types.length; i++)
              ChoiceChip(
                label: Text(s.t(FeedbackTexts.types[i])),
                selected: _type == i,
                onSelected: (_) => setState(() => _type = i),
              ),
          ],
        ),
        SectionLabel(s.t(FeedbackTexts.messageLabel)),
        TextField(
          controller: _msg,
          minLines: 4,
          maxLines: 8,
          maxLength: 1000,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(),
        ),
        SectionLabel(s.t(FeedbackTexts.ratingLabel)),
        Row(
          children: [
            for (var i = 1; i <= 5; i++)
              IconButton(
                onPressed: () => setState(() => _stars = _stars == i ? 0 : i),
                icon: Icon(
                  i <= _stars ? Icons.star : Icons.star_border,
                  color: AnkdharaColors.gold,
                  size: 30,
                ),
              ),
          ],
        ),
        SectionLabel(s.t(FeedbackTexts.contactLabel)),
        TextField(
          controller: _contact,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _busy ? null : () => _send(s),
            icon: const Icon(Icons.send_outlined),
            label: Text(s.t(_busy ? FeedbackTexts.sending : FeedbackTexts.send)),
          ),
        ),
        if (_status != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              _status!,
              style: TextStyle(
                color: _ok ? const Color(0xFF2E7D32) : Colors.red,
                fontSize: 14,
              ),
            ),
          ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: RateApp.open,
            icon: const Icon(Icons.star_outline),
            label: Text(s.t(RateApp.button)),
          ),
        ),
      ],
    );
  }
}
