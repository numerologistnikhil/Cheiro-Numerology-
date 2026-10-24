import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/root_profiles.dart' show L;
import '../core/streaks.dart';
import 'ui_kit.dart';

class _Badge {
  final L title;
  final L how;
  final IconData icon;
  final bool Function(StreakInfo) earned;
  _Badge(this.title, this.how, this.icon, this.earned);
}

final List<_Badge> _badges = [
  _Badge(
    const L('First step', 'पहला कदम'),
    const L('Open the app', 'ऐप खोलिए'),
    Icons.flag_outlined,
    (i) => i.totalDays >= 1,
  ),
  _Badge(
    const L('3-day streak', '3 दिन लगातार'),
    const L('Open the app 3 days in a row', 'लगातार 3 दिन ऐप खोलिए'),
    Icons.local_fire_department_outlined,
    (i) => i.best >= 3,
  ),
  _Badge(
    const L('7-day streak', '7 दिन लगातार'),
    const L('Open the app 7 days in a row', 'लगातार 7 दिन ऐप खोलिए'),
    Icons.local_fire_department,
    (i) => i.best >= 7,
  ),
  _Badge(
    const L('30-day streak', '30 दिन लगातार'),
    const L('Open the app 30 days in a row', 'लगातार 30 दिन ऐप खोलिए'),
    Icons.whatshot,
    (i) => i.best >= 30,
  ),
  _Badge(
    const L('Explorer', 'खोजी'),
    const L('Open 5 different features', '5 अलग सुविधाएँ खोलिए'),
    Icons.explore_outlined,
    (i) => i.visited.length >= 5,
  ),
  _Badge(
    const L('Number Master', 'अंक गुरु'),
    const L('Open 10 different features', '10 अलग सुविधाएँ खोलिए'),
    Icons.workspace_premium_outlined,
    (i) => i.visited.length >= 10,
  ),
  _Badge(
    const L('Grid Reader', 'ग्रिड पाठक'),
    const L('Open the Lo Shu Grid', 'लो शू ग्रिड खोलिए'),
    Icons.grid_view,
    (i) => i.visited.contains('loshu'),
  ),
  _Badge(
    const L('Friend of Ankdhara', 'अंकधारा का दोस्त'),
    const L('Open Invite a friend', 'दोस्त को बुलाइए खोलिए'),
    Icons.card_giftcard,
    (i) => i.visited.contains('referral'),
  ),
];

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  StreakInfo? _info;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final v = await Streaks.load();
    if (mounted) setState(() => _info = v);
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AnkdharaColors.gold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12.5),
          ),
        ],
      ),
    );
  }

  Widget _badgeTile(AppSettings s, _Badge b, bool earned) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GoldCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: earned ? AnkdharaColors.goldLight : const Color(0xFFE9E3D2),
              ),
              child: Icon(
                b.icon,
                color: earned ? Colors.white : const Color(0xFFA89F86),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.t(b.title),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: earned ? AnkdharaColors.ink : const Color(0xFF8A7F6A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(s.t(b.how), style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
            if (earned)
              const Icon(Icons.check_circle, color: AnkdharaColors.gold),
          ],
        ),
      ),
    );
  }

  List<Widget> _body(AppSettings s, StreakInfo info) {
    final earnedCount = _badges.where((b) => b.earned(info)).length;
    return [
      GoldCard(
        child: Row(
          children: [
            _stat('${info.current}', s.t(const L('Current streak', 'अभी की लड़ी'))),
            _stat('${info.best}', s.t(const L('Best streak', 'सबसे लंबी लड़ी'))),
            _stat('${info.totalDays}', s.t(const L('Days used', 'ऐप के दिन'))),
          ],
        ),
      ),
      SectionLabel(
        s.hindi
            ? 'बैज: $earnedCount / ${_badges.length}'
            : 'Badges: $earnedCount of ${_badges.length}',
      ),
      for (final b in _badges) _badgeTile(s, b, b.earned(info)),
      Note(s.t(const L(
        'A streak counts the days in a row you open the app. Missing a day '
            'starts a new streak. Badges are just for fun.',
        'लड़ी उन दिनों को गिनती है जब आप लगातार ऐप खोलते हैं। एक दिन छूटने '
            'पर नई लड़ी शुरू होती है। बैज सिर्फ़ मज़े के लिए हैं।',
      ))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    final info = _info;
    return PageShell(
      title: s.t(const L('Streak and Badges', 'लगातार दिन और बैज')),
      children: [
        if (info == null)
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(child: CircularProgressIndicator()),
          )
        else
          ..._body(s, info),
      ],
    );
  }
}
