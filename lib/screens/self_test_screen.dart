import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../core/app_settings.dart';
import '../core/cheiro_timing.dart';
import '../core/story_report.dart';
import '../core/translations.dart';
import '../core/user_profile.dart';
import '../core/voice_answers.dart';
import '../core/voice_parser.dart';
import 'ai_numerologist_screen.dart';
import 'angel_numbers_screen.dart';
import 'baby_names_screen.dart';
import 'badges_screen.dart';
import 'business_screen.dart';
import 'cheiro_timing_screen.dart';
import 'compatibility_screen.dart';
import 'daily_lucky_screen.dart';
import 'date_selection_screen.dart';
import 'famous_screen.dart';
import 'gemstone_screen.dart';
import 'health_screen.dart';
import 'home_screen.dart';
import 'learn_screen.dart';
import 'lo_shu_screen.dart';
import 'name_correction_screen.dart';
import 'number_check_screens.dart';
import 'predictions_screen.dart';
import 'profession_screen.dart';
import 'remedies_screen.dart';
import 'report_builder_screen.dart';
import 'rudraksha_screen.dart';
import 'settings_screen.dart';
import 'signature_screen.dart';
import 'western_screen.dart';

class _Row {
  final String name;
  final bool ok;
  final String detail;
  final int ms;
  const _Row(this.name, this.ok, this.detail, this.ms);
}

/// One button: the app checks itself and collects every problem it finds in
/// one report, which can be sent to Claude in a single step.
class SelfTestScreen extends StatefulWidget {
  const SelfTestScreen({super.key});

  @override
  State<SelfTestScreen> createState() => _SelfTestScreenState();
}

class _SelfTestScreenState extends State<SelfTestScreen> {
  final List<_Row> _rows = <_Row>[];
  final List<String> _files = <String>[];
  bool _running = false;
  bool _done = false;
  String _now = '';
  final List<String> _caught = <String>[];

  void _add(String name, bool ok, String detail, int ms) {
    if (!mounted) return;
    setState(() => _rows.add(_Row(name, ok, detail, ms)));
  }

  /// Runs one check. The body returns null when all is well, or a text that
  /// says what is wrong. A crash is reported as a problem too.
  Future<void> _step(String name, Future<String?> Function() body) async {
    if (mounted) setState(() => _now = name);
    final sw = Stopwatch()..start();
    try {
      final r = await body();
      _add(name, r == null, r ?? 'OK', sw.elapsedMilliseconds);
    } catch (e, st) {
      final lines = st.toString().split('\n').take(4).join(' | ');
      _add(name, false, 'CRASH: $e | $lines', sw.elapsedMilliseconds);
    }
  }

  Future<void> _run({required bool withPdf}) async {
    if (_running) return;
    setState(() {
      _running = true;
      _done = false;
      _rows.clear();
      _files.clear();
      _caught.clear();
    });

    final profile = UserProfile.instance;
    final oldName = profile.name;
    final oldDob = profile.dob;
    final oldMobile = profile.mobile;
    final oldLang = AppSettings.instance.code;
    final oldOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails d) {
      final t = d.exceptionAsString().replaceAll('\n', ' ');
      _caught.add(t.length > 220 ? t.substring(0, 220) : t);
    };

    try {
      await _step('Calculations (5 birth dates)', () async {
        final dobs = <DateTime>[
          DateTime(1988, 4, 6),
          DateTime(1982, 1, 1),
          DateTime(2000, 12, 31),
          DateTime(1999, 2, 28),
          DateTime(2015, 9, 9),
        ];
        final now = DateTime.now();
        for (final d in dobs) {
          final m = VoiceAnswers.mulank(d);
          final b = VoiceAnswers.bhagyank(d);
          if (m < 1 || m > 9 || b < 1 || b > 9) {
            return 'Wrong root for $d: $m / $b';
          }
          final y = CheiroTiming.year(d, now.year, m, b);
          final mo = CheiroTiming.month(d, now.year, now.month, m, b);
          final dy = CheiroTiming.day(d, now, m, b);
          for (final p in [y, mo, dy]) {
            if (p.root < 1 || p.root > 9) return 'Wrong period root for $d';
          }
        }
        return null;
      });

      await _step('Voice answers (English and Hindi)', () async {
        final qs = <String>[
          'my lucky number',
          'mera lucky color kya hai',
          'aaj ka din kaisa rahega',
          'which gemstone should I wear',
          'career advice',
          'health',
        ];
        for (final hi in [false, true]) {
          for (final q in qs) {
            final a = VoiceAnswers.answer(q, DateTime(1988, 4, 6), DateTime.now(),
                hindi: hi);
            if (a.spoken.trim().isEmpty) return 'Empty answer for "$q" hindi=$hi';
          }
        }
        return null;
      });

      await _step('Voice parser (name, birth date, mobile)', () async {
        final a = VoiceParser.parse(
            'my name is Rahul Sharma my date of birth is 6 April 1988 mobile 9876543210');
        if (a.mobile != '9876543210') return 'Mobile read as "${a.mobile}"';
        final d = a.dob;
        if (d == null || d.year != 1988 || d.month != 4 || d.day != 6) {
          return 'Birth date read as $d';
        }
        if (!a.name.toLowerCase().contains('rahul')) {
          return 'Name read as "${a.name}"';
        }
        final b = VoiceParser.parse('mera naam Amit hai 15/08/1990');
        final e = b.dob;
        if (e == null || e.day != 15 || e.month != 8 || e.year != 1990) {
          return 'Day-first date read as $e';
        }
        return null;
      });

      await _step('Languages (every text translated)', () async {
        for (final e in Translations.table.entries) {
          if (e.value.length != Translations.codes.length) {
            return 'Row has wrong size: ${e.key}';
          }
        }
        for (final c in Translations.codes) {
          if (Translations.lookup(c, 'Home') == null) return 'No Home text for $c';
        }
        return null;
      });

      await _step('Hindi text pictures (mix-up check)', () async {
        final bad = await StoryReport.pictureCheck();
        return bad.isEmpty
            ? null
            : 'Pictures came out different for: ${bad.join(', ')}';
      });

      if (withPdf) {
        final dir = await getTemporaryDirectory();
        Future<String?> pdf(String label, bool hi, int years) async {
          final sw = Stopwatch()..start();
          final doc = await StoryReport.build(
            name: 'Test Person',
            dob: DateTime(1988, 4, 6),
            mobile: '9876543210',
            hindi: hi,
            years: years,
            limitSeconds: 300,
          );
          final bytes = await doc.save();
          final head = String.fromCharCodes(bytes.take(5));
          if (head != '%PDF-') return 'Not a PDF file';
          final text = String.fromCharCodes(bytes);
          final pages = RegExp(r'/Type\s*/Page[^s]').allMatches(text).length;
          final f = File('${dir.path}/selftest_$label.pdf');
          await f.writeAsBytes(bytes, flush: true);
          _files.add(f.path);
          final mb = (bytes.length / 1048576).toStringAsFixed(1);
          return pages < 3
              ? 'Only $pages pages'
              : (sw.elapsedMilliseconds > 120000
                  ? 'Too slow: ${(sw.elapsedMilliseconds / 1000).round()} s ($pages pages, $mb MB)'
                  : null);
        }

        await _step('PDF English, 5 years', () => pdf('english_5y', false, 5));
        await _step('PDF Hindi, 5 years', () => pdf('hindi_5y', true, 5));
        await _step('PDF Hindi, 10 years', () => pdf('hindi_10y', true, 10));
      }

      // Every screen, in English and in Hindi.
      profile.name = 'Test Person';
      profile.dob = DateTime(1988, 4, 6);
      profile.mobile = '9876543210';
      final screens = <String, Widget Function()>{
        'My Numbers': () => const HomeScreen(),
        'Name Correction': () => const NameCorrectionScreen(),
        'Mobile': () => const MobileNumberScreen(),
        'Vehicle': () => const VehicleNumberScreen(),
        'Gemstones': () => const GemstoneScreen(),
        'Rudraksha': () => const RudrakshaScreen(),
        'Signature': () => const SignatureScreen(),
        'Cheiro Timing': () => const CheiroTimingScreen(),
        'Famous People': () => const FamousScreen(),
        'Health': () => const HealthScreen(),
        'Western Chart': () => const WesternScreen(),
        'Business': () => const BusinessScreen(),
        'Compatibility': () => const CompatibilityScreen(),
        'Predictions': () => const PredictionsScreen(),
        'Daily Lucky': () => const DailyLuckyScreen(),
        'Good Dates': () => const DateSelectionScreen(),
        'Baby Names': () => const BabyNamesScreen(),
        'Remedies': () => const RemediesScreen(),
        'Profession': () => const ProfessionScreen(),
        'Learn': () => const LearnScreen(),
        'Ask': () => const AiNumerologistScreen(),
        'Angel Numbers': () => const AngelNumbersScreen(),
        'Report Builder': () => const ReportBuilderScreen(),
        'Lo Shu': () => const LoShuScreen(),
        'Badges': () => const BadgesScreen(),
        'Settings': () => const SettingsScreen(),
      };
      for (final code in <String>['en', 'hi', 'es']) {
        await AppSettings.instance.setLanguage(code);
        for (final e in screens.entries) {
          if (!mounted) return;
          _caught.clear();
          await _step('Screen ${e.key} [$code]', () async {
            final nav = Navigator.of(context);
            unawaited(nav.push(MaterialPageRoute<void>(builder: (_) => e.value())));
            await Future<void>.delayed(const Duration(milliseconds: 800));
            nav.pop();
            await Future<void>.delayed(const Duration(milliseconds: 150));
            if (_caught.isEmpty) return null;
            return 'Errors: ${_caught.take(3).join(' || ')}';
          });
        }
      }
    } finally {
      FlutterError.onError = oldOnError;
      profile.name = oldName;
      profile.dob = oldDob;
      profile.mobile = oldMobile;
      await AppSettings.instance.setLanguage(oldLang);
      if (mounted) {
        setState(() {
          _running = false;
          _done = true;
          _now = '';
        });
      }
    }
  }

  String _summary() {
    final b = StringBuffer();
    final bad = _rows.where((r) => !r.ok).length;
    b.writeln('Ank Dhara self test');
    b.writeln('Time: ${DateTime.now()}');
    b.writeln('Phone: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}');
    b.writeln('Checks: ${_rows.length}, problems: $bad');
    b.writeln('');
    for (final r in _rows) {
      b.writeln('${r.ok ? 'OK  ' : 'FAIL'} | ${r.name} | ${r.ms} ms | ${r.detail}');
    }
    return b.toString();
  }

  Future<void> _share() async {
    final dir = await getTemporaryDirectory();
    final f = File('${dir.path}/ankdhara_selftest.txt');
    await f.writeAsString(_summary(), flush: true);
    final files = <XFile>[XFile(f.path), ..._files.map(XFile.new)];
    await Share.shareXFiles(files, text: 'Ank Dhara self test result');
  }

  @override
  Widget build(BuildContext context) {
    final bad = _rows.where((r) => !r.ok).length;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Test')),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const Text(
            'Press the button. The app checks its numbers, languages, voice '
            'reading, Hindi text pictures, the PDF reports and about 25 screens '
            'by itself. It can take 3 to 6 minutes. Keep the app open.',
            style: TextStyle(fontSize: 13.5, height: 1.4),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _running ? null : () => _run(withPdf: true),
            icon: const Icon(Icons.play_arrow),
            label: Text(_running ? 'Running...' : 'Start full test'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _running ? null : () => _run(withPdf: false),
            icon: const Icon(Icons.bolt),
            label: const Text('Quick test (no PDF)'),
          ),
          if (_running) ...[
            const SizedBox(height: 12),
            const LinearProgressIndicator(),
            const SizedBox(height: 6),
            Text('Now: $_now', style: const TextStyle(fontSize: 12.5)),
          ],
          if (_rows.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              _done
                  ? (bad == 0
                      ? 'All ${_rows.length} checks passed.'
                      : '$bad problem(s) in ${_rows.length} checks.')
                  : '${_rows.length} checks done, $bad problem(s) so far.',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: bad == 0 ? Colors.green.shade800 : Colors.red.shade800),
            ),
            const SizedBox(height: 6),
            for (final r in _rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(r.ok ? Icons.check_circle : Icons.cancel,
                        size: 18,
                        color: r.ok ? Colors.green.shade700 : Colors.red.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        r.ok
                            ? '${r.name}  (${(r.ms / 1000).toStringAsFixed(1)} s)'
                            : '${r.name}\n${r.detail}',
                        style: const TextStyle(fontSize: 12.5, height: 1.35),
                      ),
                    ),
                  ],
                ),
              ),
          ],
          if (_done) ...[
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: _share,
              icon: const Icon(Icons.share),
              label: const Text('Send result to Claude (share)'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: _summary()));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Result copied.')));
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copy result text'),
            ),
          ],
        ],
      ),
    );
  }
}
