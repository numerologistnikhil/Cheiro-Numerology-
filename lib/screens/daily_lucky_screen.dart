import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app.dart';
import '../core/numerology_engine.dart';
import '../core/numerology_tools.dart';
import 'ui_kit.dart';

const Map<int, String> _dailyHints = {
  1: 'Take the lead and start something you have been postponing.',
  2: 'Cooperate and listen. Avoid arguments today.',
  3: 'Speak, create and meet people. Keep things light.',
  4: 'Be practical. Finish paperwork and routine tasks.',
  5: 'Expect change. Stay flexible and do not rush decisions.',
  6: 'Focus on family, home and responsibilities.',
  7: 'A quiet day for study and reflection. Avoid hurried deals.',
  8: 'Good for money, work and discipline. Be fair in dealings.',
  9: 'Finish old matters, help others and let go.',
};

/// Personal day number: root of (personal month + day of month).
int dailyNumber(DateTime birth, DateTime today) {
  final month = NumerologyTools.personalMonth(birth, today.year, today.month);
  return NumerologyEngine.root(month + today.day);
}

class DailyLuckyScreen extends StatefulWidget {
  const DailyLuckyScreen({super.key});

  @override
  State<DailyLuckyScreen> createState() => _DailyLuckyScreenState();
}

class _DailyLuckyScreenState extends State<DailyLuckyScreen> {
  static const _kDob = 'daily_lucky_dob';
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final p = await SharedPreferences.getInstance();
      final ms = p.getInt(_kDob);
      if (ms != null && mounted) {
        setState(() => _dob = DateTime.fromMillisecondsSinceEpoch(ms));
      }
    } catch (_) {
      // Remembering the date is optional.
    }
  }

  Future<void> _save(DateTime d) async {
    setState(() => _dob = d);
    try {
      final p = await SharedPreferences.getInstance();
      await p.setInt(_kDob, d.millisecondsSinceEpoch);
    } catch (_) {
      // Remembering the date is optional.
    }
  }

  @override
  Widget build(BuildContext context) {
    final dob = _dob;
    final now = DateTime.now();
    final int? number = dob == null ? null : dailyNumber(dob, now);
    final RemedyInfo? info = number == null ? null : NumerologyTools.remedies[number];

    return PageShell(
      title: 'Daily Lucky',
      children: [
        const SectionLabel('Your date of birth'),
        DateField(
          label: 'Date of birth',
          value: dob,
          onChanged: _save,
        ),
        const SizedBox(height: 18),
        if (number != null) ...[
          SectionLabel('Today, ${formatDate(now)}'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AnkdharaColors.goldLine),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lucky number today: $number',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AnkdharaColors.gold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _dailyHints[number] ?? '',
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
                const SizedBox(height: 12),
                Text(
                  'Planet: ${NumerologyTools.planetOf(number)}',
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
                if (info != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Lucky colours: ${info.colours}',
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ],
              ],
            ),
          ),
        ],
        const Note(
          'This is gentle guidance based on your personal day number, not a '
          'prediction. Daily Lucky is a Pro feature; it is free to try in '
          'this test build.',
        ),
      ],
    );
  }
}
