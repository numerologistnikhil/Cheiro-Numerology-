import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../core/app_settings.dart';
import '../core/voice_parser.dart';
import 'ui_kit.dart';

/// Press the microphone, say the name, date of birth and mobile number.
/// The words are turned into details and shown for confirmation. Nothing is
/// saved until the person taps "Use these details".
class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  final SpeechToText _stt = SpeechToText();
  final TextEditingController _text = TextEditingController();
  bool _ready = false;
  bool _listening = false;
  bool _hindi = false;
  String _error = '';
  VoiceDetails _found = const VoiceDetails();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    bool ok = false;
    try {
      ok = await _stt.initialize(
        onError: (e) {
          if (!mounted) return;
          setState(() {
            _listening = false;
            _error = e.errorMsg;
          });
        },
        onStatus: (s) {
          if (!mounted) return;
          if (s == 'done' || s == 'notListening') {
            setState(() => _listening = false);
          }
        },
      );
    } catch (_) {
      ok = false;
    }
    if (!mounted) return;
    setState(() => _ready = ok);
  }

  @override
  void dispose() {
    _stt.cancel();
    _text.dispose();
    super.dispose();
  }

  void _reparse() {
    setState(() => _found = VoiceParser.parse(_text.text));
  }

  Future<void> _toggle() async {
    if (_listening) {
      await _stt.stop();
      setState(() => _listening = false);
      return;
    }
    setState(() {
      _error = '';
      _listening = true;
    });
    try {
      await _stt.listen(
        localeId: _hindi ? 'hi_IN' : 'en_IN',
        listenFor: const Duration(seconds: 45),
        pauseFor: const Duration(seconds: 6),
        listenOptions: SpeechListenOptions(partialResults: true),
        onResult: (r) {
          if (!mounted) return;
          _text.text = r.recognizedWords;
          _found = VoiceParser.parse(r.recognizedWords);
          setState(() {});
        },
      );
    } catch (_) {
      if (mounted) setState(() => _listening = false);
    }
  }

  String _date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

  Widget _row(String label, String value, bool hi) {
    final missing = value.isEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
          Expanded(
            child: Text(
              missing ? (hi ? 'सुनाई नहीं दिया' : 'not heard yet') : value,
              style: TextStyle(
                  color: missing ? Colors.black45 : null,
                  fontWeight: missing ? FontWeight.w400 : FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hi = AppLang.of(context).hindi;
    final f = _found;
    return PageShell(
      title: hi ? 'बोलकर जानकारी भरिए' : 'Fill details by voice',
      children: [
        Note(hi
            ? 'माइक का बटन दबाइए और एक साथ बोलिए, जैसे: "मेरा नाम राहुल शर्मा है, जन्म 15 अगस्त 1990, मोबाइल 98765 43210"। फिर नीचे जो समझ आया उसे जाँचिए। नाम अंग्रेज़ी में सबसे सही आता है।'
            : 'Tap the microphone and say it in one go, like: "My name is Rahul Sharma, born 15 August 1990, mobile 98765 43210". Then check what was understood below. Speaking in English gives the most accurate name.'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              label: const Text('English'),
              selected: !_hindi,
              onSelected: _listening ? null : (_) => setState(() => _hindi = false),
            ),
            ChoiceChip(
              label: const Text('हिन्दी'),
              selected: _hindi,
              onSelected: _listening ? null : (_) => setState(() => _hindi = true),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: _ready ? _toggle : null,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _listening ? Colors.red.shade600 : const Color(0xFFB8860B),
                boxShadow: [
                  BoxShadow(
                      color: (_listening ? Colors.red : const Color(0xFFB8860B))
                          .withOpacity(0.35),
                      blurRadius: 22,
                      spreadRadius: 4),
                ],
              ),
              child: Icon(_listening ? Icons.stop : Icons.mic,
                  color: Colors.white, size: 44),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            !_ready
                ? (hi
                    ? 'माइक उपलब्ध नहीं है। अनुमति दीजिए या नीचे टाइप कीजिए।'
                    : 'Microphone not available. Allow permission or type below.')
                : _listening
                    ? (hi ? 'सुन रहा हूँ... बोलिए' : 'Listening... speak now')
                    : (hi ? 'बोलने के लिए माइक दबाइए' : 'Tap the mic to speak'),
            textAlign: TextAlign.center,
          ),
        ),
        if (_error.isNotEmpty) ...[
          const SizedBox(height: 6),
          Center(
            child: Text(
              hi
                  ? 'आवाज़ पहचान में दिक्कत ($_error)। इंटरनेट चालू है? फिर कोशिश कीजिए।'
                  : 'Could not recognise the voice ($_error). Is the internet on? Try again.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
        const SizedBox(height: 16),
        TextField(
          controller: _text,
          minLines: 2,
          maxLines: 4,
          onChanged: (_) => _reparse(),
          decoration: InputDecoration(
            labelText: hi ? 'जो सुना गया (सुधार सकते हैं)' : 'What was heard (you can edit)',
            prefixIcon: const Icon(Icons.record_voice_over_outlined),
          ),
        ),
        const SizedBox(height: 14),
        GoldCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _row(hi ? 'नाम' : 'Name', f.name, hi),
              _row(hi ? 'जन्म तिथि' : 'Date of birth',
                  f.dob == null ? '' : _date(f.dob!), hi),
              _row(hi ? 'मोबाइल' : 'Mobile', f.mobile, hi),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: f.isEmpty ? null : () => Navigator.pop(context, f),
          child: Text(hi ? 'ये जानकारी इस्तेमाल कीजिए' : 'Use these details'),
        ),
      ],
    );
  }
}
