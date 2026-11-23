import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../core/app_settings.dart';
import '../core/user_profile.dart';
import '../core/voice_answers.dart';
import 'ui_kit.dart';

/// Talk to the app: tap the microphone, ask "what is my lucky number?" or
/// "what about this year?", and the app answers on screen and aloud.
/// It answers from the person's own numbers (profile date of birth). It is
/// mood and planning guidance, not a prediction of events.
class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  final SpeechToText _stt = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _q = TextEditingController();
  bool _sttReady = false;
  bool _listening = false;
  bool _speaking = false;
  bool _speakAloud = true;
  bool _loaded = false;
  String _error = '';
  VoiceAnswer? _answer;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await UserProfile.instance.ensureLoaded();
    try {
      _sttReady = await _stt.initialize(
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
            final was = _listening;
            setState(() => _listening = false);
            if (was && _q.text.trim().isNotEmpty) _ask(_q.text);
          }
        },
      );
    } catch (_) {
      _sttReady = false;
    }
    try {
      _tts.setCompletionHandler(() {
        if (mounted) setState(() => _speaking = false);
      });
      _tts.setCancelHandler(() {
        if (mounted) setState(() => _speaking = false);
      });
      _tts.setErrorHandler((_) {
        if (mounted) setState(() => _speaking = false);
      });
      await _tts.setSpeechRate(0.45);
    } catch (_) {}
    if (mounted) setState(() => _loaded = true);
  }

  @override
  void dispose() {
    _stt.cancel();
    _tts.stop();
    _q.dispose();
    super.dispose();
  }

  Future<void> _speak(String text, bool hi) async {
    try {
      await _tts.stop();
      await _tts.setLanguage(hi ? 'hi-IN' : 'en-IN');
      if (mounted) setState(() => _speaking = true);
      await _tts.speak(text);
    } catch (_) {
      if (mounted) setState(() => _speaking = false);
    }
  }

  Future<void> _stopSpeaking() async {
    try {
      await _tts.stop();
    } catch (_) {}
    if (mounted) setState(() => _speaking = false);
  }

  void _ask(String question) {
    final dob = UserProfile.instance.dob;
    if (dob == null) return;
    final hi = AppLang.of(context).hindi;
    final a = VoiceAnswers.answer(question, dob, DateTime.now(), hindi: hi);
    setState(() => _answer = a);
    if (_speakAloud) _speak(a.spoken, hi);
  }

  Future<void> _toggleMic() async {
    if (_listening) {
      await _stt.stop();
      return;
    }
    await _stopSpeaking();
    final hi = AppLang.of(context).hindi;
    setState(() {
      _error = '';
      _listening = true;
      _q.clear();
    });
    try {
      await _stt.listen(
        localeId: hi ? 'hi_IN' : 'en_IN',
        listenFor: const Duration(seconds: 20),
        pauseFor: const Duration(seconds: 3),
        listenOptions: SpeechListenOptions(partialResults: true),
        onResult: (r) {
          if (!mounted) return;
          setState(() => _q.text = r.recognizedWords);
        },
      );
    } catch (_) {
      if (mounted) setState(() => _listening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hi = AppLang.of(context).hindi;
    final dob = UserProfile.instance.dob;
    final a = _answer;
    final chips = hi
        ? const ['शुभ अंक', 'इस साल', 'इस महीने', 'सावधानी', 'शुभ रंग', 'रत्न', 'करियर', 'पैसा', 'प्रेम', 'सेहत']
        : const ['Lucky number', 'This year', 'This month', 'Precautions', 'Lucky colour', 'Gemstone', 'Career', 'Money', 'Love', 'Health'];
    return PageShell(
      title: hi ? 'बोलकर पूछिए' : 'Ask by voice',
      children: [
        Note(hi
            ? 'माइक दबाकर पूछिए, जैसे "मेरा शुभ अंक क्या है" या "इस साल क्या सावधानी रखूँ"। जवाब आपके अपने मूलांक और भाग्यांक से आता है। यह मूड और योजना की सलाह है, घटनाओं की भविष्यवाणी नहीं।'
            : 'Tap the mic and ask, like "What is my lucky number" or "What precautions this year". The answer comes from your own Mulank and Bhagyank. It is guidance on mood and planning, not a prediction of events.'),
        const SizedBox(height: 12),
        if (_loaded && dob == null)
          GoldCard(
            padding: const EdgeInsets.all(14),
            child: Text(hi
                ? 'पहले प्रोफ़ाइल में जन्म तिथि भरिए (बोलकर भी भर सकते हैं)।'
                : 'First enter the date of birth in the profile (you can also speak it).'),
          ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: (_sttReady && dob != null) ? _toggleMic : null,
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
        const SizedBox(height: 8),
        Center(
          child: Text(
            !_sttReady && _loaded
                ? (hi
                    ? 'माइक उपलब्ध नहीं। नीचे टाइप कीजिए या बटन दबाइए।'
                    : 'Microphone not available. Type below or tap a button.')
                : _listening
                    ? (hi ? 'सुन रहा हूँ... पूछिए' : 'Listening... ask now')
                    : (hi ? 'पूछने के लिए माइक दबाइए' : 'Tap the mic to ask'),
            textAlign: TextAlign.center,
          ),
        ),
        if (_error.isNotEmpty) ...[
          const SizedBox(height: 6),
          Center(
            child: Text(
              hi
                  ? 'आवाज़ पहचान में दिक्कत ($_error)। इंटरनेट चालू है?'
                  : 'Could not recognise the voice ($_error). Is the internet on?',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
        const SizedBox(height: 12),
        TextField(
          controller: _q,
          textInputAction: TextInputAction.search,
          onSubmitted: dob == null ? null : _ask,
          decoration: InputDecoration(
            labelText: hi ? 'आपका सवाल' : 'Your question',
            prefixIcon: const Icon(Icons.record_voice_over_outlined),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: dob == null ? null : () => _ask(_q.text),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (final c in chips)
              ActionChip(
                label: Text(c),
                onPressed: dob == null
                    ? null
                    : () {
                        _q.text = c;
                        _ask(c);
                      },
              ),
          ],
        ),
        if (a != null) ...[
          const SizedBox(height: 16),
          GoldCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(a.spoken, style: const TextStyle(height: 1.5)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: _speaking
                          ? _stopSpeaking
                          : () => _speak(a.spoken, hi),
                      icon: Icon(_speaking ? Icons.stop : Icons.volume_up),
                      label: Text(_speaking
                          ? (hi ? 'रोकिए' : 'Stop')
                          : (hi ? 'सुनिए' : 'Listen')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(hi ? 'जवाब बोलकर भी सुनाओ' : 'Also read the answer aloud'),
          value: _speakAloud,
          onChanged: (v) {
            setState(() => _speakAloud = v);
            if (!v) _stopSpeaking();
          },
        ),
      ],
    );
  }
}
