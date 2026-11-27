import 'package:flutter/material.dart';

import '../core/app_settings.dart';
import '../core/cheiro_timing.dart';
import '../core/root_profiles.dart' show L;
import '../core/user_profile.dart';
import '../core/voice_answers.dart';
import 'cheiro_timing_screen.dart';

/// Home card: the mood of today and a plan for the coming week. It is about
/// moods only, never about events. It needs the date of birth in the profile.
class TodayMoodCard extends StatefulWidget {
  const TodayMoodCard({super.key});

  @override
  State<TodayMoodCard> createState() => _TodayMoodCardState();
}

class _TodayMoodCardState extends State<TodayMoodCard> {
  static const _daysEn = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];
  static const _daysHi = [
    'सोम', 'मंगल', 'बुध', 'गुरु', 'शुक्र', 'शनि', 'रवि'
  ];

  @override
  void initState() {
    super.initState();
    UserProfile.instance.ensureLoaded();
  }

  String _dayName(DateTime d, bool hi) =>
      '${hi ? _daysHi[d.weekday - 1] : _daysEn[d.weekday - 1]} ${d.day}/${d.month}';

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    return AnimatedBuilder(
      animation: UserProfile.instance,
      builder: (context, _) {
        final dob = UserProfile.instance.dob;
        if (dob == null) return const SizedBox.shrink();
        final hi = s.hindi;
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final m = VoiceAnswers.mulank(dob);
        final b = VoiceAnswers.bhagyank(dob);
        final p = CheiroTiming.day(dob, today, m, b);

        String? best;
        final careful = <String>[];
        for (var i = 1; i <= 6; i++) {
          final d = today.add(Duration(days: i));
          final q = CheiroTiming.day(dob, d, m, b);
          if (q.mood == TimingMood.favourable && best == null) {
            best = _dayName(d, hi);
          }
          if (q.mood == TimingMood.careful && careful.length < 2) {
            careful.add(_dayName(d, hi));
          }
        }

        final moodName = s.t(CheiroTiming.moodName[p.mood]!);
        final tone = s.t(CheiroTiming.rootTone[p.root]!);
        final week = StringBuffer();
        week.write(best == null
            ? s.t(const L('No special start day this week, so keep steady effort.',
                'इस हफ़्ते कोई ख़ास शुरुआत का दिन नहीं, इसलिए लगातार मेहनत रखें।'))
            : '${s.t(const L('Good day to start something', 'कुछ शुरू करने का अच्छा दिन'))}: $best');
        if (careful.isNotEmpty) {
          week.write('\n${s.t(const L('Go slowly on', 'धीरे चलें'))}: ${careful.join(', ')}');
        }

        return Container(
          margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF0),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE7D6A8)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (_) => const CheiroTimingScreen())),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.t(const L("Today's mood", 'आज का मूड')),
                          style: const TextStyle(
                              fontFamily: 'serif',
                              fontSize: 16.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF5A430F)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E4B5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('$moodName  ·  ${p.root}',
                            style: const TextStyle(
                                fontSize: 12.5, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(tone, style: const TextStyle(fontSize: 13.5, height: 1.4)),
                  const SizedBox(height: 8),
                  Text(
                    s.t(const L('This week', 'इस हफ़्ते')),
                    style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF9C7A22)),
                  ),
                  Text(week.toString(),
                      style: const TextStyle(fontSize: 13, height: 1.4)),
                  const SizedBox(height: 6),
                  Text(
                    s.t(const L(
                        'A mood guide for planning, not a prediction of events.',
                        'योजना बनाने के लिए मूड-गाइड, घटनाओं की भविष्यवाणी नहीं।')),
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF7A6A44)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
