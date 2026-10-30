import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../core/app_settings.dart';
import '../core/root_profiles.dart' show L;
import '../core/streaks.dart';
import 'ai_numerologist_screen.dart';
import 'angel_numbers_screen.dart';
import 'badges_screen.dart';
import 'baby_names_screen.dart';
import 'business_screen.dart';
import 'client_vault_screen.dart';
import 'compatibility_screen.dart';
import 'daily_lucky_screen.dart';
import 'date_selection_screen.dart';
import 'extras_screens.dart';
import 'home_screen.dart';
import 'learn_screen.dart';
import 'profile_screen.dart';
import 'lo_shu_screen.dart';
import 'name_correction_screen.dart';
import 'number_check_screens.dart';
import 'predictions_screen.dart';
import 'profession_screen.dart';
import 'remedies_screen.dart';
import 'report_builder_screen.dart';
import 'settings_screen.dart';

/// Ank Dhara home. Four numbered steps, one language at a time
/// (English or Hindi, chosen in the three-dot menu).
class PremiumHome extends StatefulWidget {
  final void Function(String key)? onOpen;
  const PremiumHome({super.key, this.onOpen});

  @override
  State<PremiumHome> createState() => _PremiumHomeState();
}

class _Gold {
  static const cream = Color(0xFFFFF8EC);
  static const pearl = Color(0xFFFFFFFF);
  static const gold = Color(0xFFC9A24A);
  static const goldDark = Color(0xFF8A6A1F);
  static const goldLight = Color(0xFFF3DFA2);
  static const ink = Color(0xFF3A2E14);
  static const soft = Color(0xFF7A6A48);
}

class _F {
  final String key;
  final L label;
  final L sub;
  final IconData icon;
  const _F(this.key, this.label, this.sub, this.icon);
}

class _Step {
  final L title;
  final L sub;
  final List<_F> items;
  const _Step(this.title, this.sub, this.items);
}

class _Banner {
  final L small;
  final L big;
  final L button;
  final String key;
  const _Banner(this.small, this.big, this.button, this.key);
}

const _steps = <_Step>[
  _Step(
    L('Know your numbers', 'अपने अंक जानिए'),
    L('Start here. Your birth date, name and phone number.',
        'यहाँ से शुरू कीजिए। आपकी जन्म तिथि, नाम और फ़ोन नंबर।'),
    [
      _F('mynumbers', L('My Numbers', 'मेरे अंक'),
          L('Birth and destiny number', 'मूलांक और भाग्यांक'), Icons.auto_awesome),
      _F('name', L('Name', 'नाम'),
          L('Check and correct a name', 'नाम जाँचिए और सुधारिए'), Icons.spellcheck),
      _F('mobile', L('Mobile', 'मोबाइल'),
          L('Is your number lucky?', 'क्या आपका नंबर शुभ है?'), Icons.phone_android),
      _F('vehicle', L('Vehicle', 'वाहन'),
          L('Check a vehicle number', 'वाहन नंबर जाँचिए'), Icons.directions_car_outlined),
      _F('business', L('Business', 'व्यापार'),
          L('Business name and number', 'व्यापार का नाम और अंक'), Icons.storefront_outlined),
      _F('compatibility', L('Match', 'मिलान'),
          L('Two people together', 'दो लोगों का मेल'), Icons.favorite_border),
      _F('loshu', L('Lo Shu Grid', 'लो शू ग्रिड'),
          L('Strong and missing numbers', 'मज़बूत और कमज़ोर अंक'), Icons.grid_view),
    ],
  ),
  _Step(
    L('Look at your future', 'अपना भविष्य देखिए'),
    L('Your years, months and good dates.',
        'आपके साल, महीने और शुभ तारीख़ें।'),
    [
      _F('predictions', L('Years and Months', 'साल और महीने'),
          L('10 years and more', '10 साल या ज़्यादा'), Icons.calendar_month),
      _F('daily', L('Today', 'आज का दिन'),
          L('Lucky number and colour', 'शुभ अंक और रंग'), Icons.wb_sunny_outlined),
      _F('dates', L('Good Dates', 'शुभ तारीख़ें'),
          L('Pick a lucky day', 'शुभ दिन चुनिए'), Icons.event_available_outlined),
      _F('baby', L('Baby Names', 'बच्चे का नाम'),
          L('Lucky names for a baby', 'शुभ नाम के सुझाव'), Icons.child_care),
    ],
  ),
  _Step(
    L('Get simple guidance', 'आसान सलाह पाइए'),
    L('Easy things you can do, and a place to learn.',
        'आसान उपाय जो आप कर सकते हैं, और सीखने की जगह।'),
    [
      _F('remedies', L('Remedies', 'उपाय'),
          L('Colours, stones, habits', 'रंग, रत्न, आदतें'), Icons.diamond_outlined),
      _F('profession', L('Career', 'करियर'),
          L('Work that suits you', 'आपके लायक काम'), Icons.work_outline),
      _F('learn', L('Learn and Quiz', 'सीखिए और क्विज़'),
          L('Understand numbers easily', 'अंकों को आसानी से समझिए'), Icons.school_outlined),
      _F('angel', L('Angel Numbers', 'एंजल नंबर'),
          L('What repeating numbers mean', 'दोहराए अंकों का मतलब'), Icons.stars_outlined),
      _F('ask', L('Ask', 'पूछिए'),
          L('Ask a question about numbers', 'अंकों के बारे में सवाल पूछिए'), Icons.chat_bubble_outline),
    ],
  ),
  _Step(
    L('Your reports', 'आपकी रिपोर्ट'),
    L('A full PDF report, and your saved clients.',
        'पूरी PDF रिपोर्ट, और आपके सेव किए हुए ग्राहक।'),
    [
      _F('reports', L('PDF Report', 'PDF रिपोर्ट'),
          L('Download, print, share', 'डाउनलोड, प्रिंट, शेयर'), Icons.picture_as_pdf_outlined),
      _F('vault', L('Client Vault', 'ग्राहक वॉल्ट'),
          L('Private and safe', 'निजी और सुरक्षित'), Icons.lock_outline),
    ],
  ),
];

const _banners = <_Banner>[
  _Banner(L('Your first report', 'आपकी पहली रिपोर्ट'), L('FREE', 'मुफ़्त'),
      L('Try now', 'अभी देखें'), 'reports'),
  _Banner(L('Fix your name', 'अपना नाम सुधारिए'), L('Lucky spelling', 'शुभ वर्तनी'),
      L('Open', 'खोलिए'), 'name'),
  _Banner(L('Mobile and vehicle', 'मोबाइल और वाहन'), L('Lucky number', 'शुभ अंक'),
      L('Check', 'जाँचिए'), 'mobile'),
];

class _PremiumHomeState extends State<PremiumHome> {
  int _banner = 0;
  StreakInfo? _streak;
  final PageController _pc = PageController(viewportFraction: 0.92);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    unawaited(Streaks.touch().then((v) {
      if (mounted) setState(() => _streak = v);
    }));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pc.dispose();
    super.dispose();
  }

  void _go(Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  void _open(String key) {
    widget.onOpen?.call(key);
    if (key != 'settings' && key != 'badges') {
      unawaited(Streaks.visit(key));
    }
    switch (key) {
      case 'mynumbers':
        _go(const HomeScreen());
        break;
      case 'name':
        _go(const NameCorrectionScreen());
        break;
      case 'mobile':
        _go(const MobileNumberScreen());
        break;
      case 'vehicle':
        _go(const VehicleNumberScreen());
        break;
      case 'business':
        _go(const BusinessScreen());
        break;
      case 'compatibility':
        _go(const CompatibilityScreen());
        break;
      case 'predictions':
        _go(const PredictionsScreen());
        break;
      case 'daily':
        _go(const DailyLuckyScreen());
        break;
      case 'dates':
        _go(const DateSelectionScreen());
        break;
      case 'baby':
        _go(const BabyNamesScreen());
        break;
      case 'remedies':
        _go(const RemediesScreen());
        break;
      case 'profession':
        _go(const ProfessionScreen());
        break;
      case 'learn':
        _go(const LearnScreen());
        break;
      case 'ask':
        _go(const AiNumerologistScreen());
        break;
      case 'angel':
        _go(const AngelNumbersScreen());
        break;
      case 'reports':
        _go(const ReportBuilderScreen());
        break;
      case 'vault':
        _go(const ClientVaultScreen());
        break;
      case 'referral':
      case 'pro':
        _go(extraPage(key));
        break;
      case 'loshu':
        _go(const LoShuScreen());
        break;
      case 'badges':
        _go(const BadgesScreen());
        break;
      case 'settings':
        _go(const SettingsScreen());
        break;
    }
  }

  Future<void> _search() async {
    final s = AppLang.of(context);
    final key = await showSearch<String?>(
      context: context,
      delegate: _FeatureSearch(s),
    );
    if (key != null) _open(key);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLang.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(s),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  const ProfileStrip(),
                  _streakStrip(s),
                  for (var i = 0; i < _steps.length; i++) _stepBlock(s, i),
                  _inviteStrip(s),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(s),
    );
  }

  Widget _header(AppSettings s) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFBEFC9), Color(0xFFFFFFFF)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 6, 2, 6),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _search,
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: _Gold.pearl,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _Gold.gold, width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: _Gold.goldDark),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        s.t(const L('Search a feature', 'सुविधा खोजिए')),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: _Gold.soft, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: _Gold.ink, size: 28),
            onSelected: (v) {
              if (v == 'english') {
                s.setHindi(false);
              } else if (v == 'hindi') {
                s.setHindi(true);
              } else if (v == 'share') {
                Share.share(s.t(const L(
                  'Try Ank Dhara, a simple numerology app in English and Hindi.',
                  'अंक धारा आज़माइए, हिन्दी और अंग्रेज़ी में एक आसान अंक-ज्योतिष ऐप।',
                )));
              } else {
                _open(v);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: Text(s.t(const L('Settings', 'सेटिंग्स'))),
                ),
              ),
              PopupMenuItem(
                value: s.hindi ? 'english' : 'hindi',
                child: ListTile(
                  leading: const Icon(Icons.translate),
                  title: Text(s.hindi ? 'Switch to English' : 'हिन्दी में बदलें'),
                ),
              ),
              PopupMenuItem(
                value: 'referral',
                child: ListTile(
                  leading: const Icon(Icons.card_giftcard),
                  title: Text(s.t(const L('Invite a friend', 'दोस्त को बुलाइए'))),
                ),
              ),
              const PopupMenuItem(
                value: 'pro',
                child: ListTile(
                  leading: Icon(Icons.workspace_premium_outlined),
                  title: Text('Ank Dhara Pro'),
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: const Icon(Icons.share_outlined),
                  title: Text(s.t(const L('Share this app', 'यह ऐप शेयर करें'))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bannerCarousel(AppSettings s) {
    return SizedBox(
      height: 124,
      child: PageView.builder(
        controller: _pc,
        onPageChanged: (i) => setState(() => _banner = i),
        itemCount: _banners.length,
        itemBuilder: (_, i) {
          final b = _banners[i];
          return Container(
            margin: const EdgeInsets.fromLTRB(6, 8, 6, 2),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF3CF), Color(0xFFE9C766)],
              ),
              border: Border.all(color: _Gold.gold, width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(s.t(b.small),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: _Gold.goldDark,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(s.t(b.big),
                            style: const TextStyle(
                                color: _Gold.ink,
                                fontSize: 24,
                                fontWeight: FontWeight.w900)),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _open(b.key),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: _Gold.ink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(s.t(b.button),
                              style: const TextStyle(
                                  color: _Gold.goldLight,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.auto_awesome,
                    size: 48, color: Color(0xAAFFFFFF)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_banners.length, (i) {
        final sel = i == _banner;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
          width: sel ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: sel ? _Gold.gold : const Color(0xFFE0D3B0),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _streakStrip(AppSettings s) {
    return const SizedBox.shrink();
    final st = _streak;
    if (st == null) return const SizedBox.shrink();
    final text =
        s.hindi ? '${st.current} दिन लगातार' : '${st.current}-day streak';
    return GestureDetector(
      onTap: () => _open('badges'),
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _Gold.pearl,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _Gold.goldLight),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_fire_department, color: _Gold.gold),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    color: _Gold.ink, fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              s.t(const L('Badges', 'बैज')),
              style: const TextStyle(
                  color: _Gold.goldDark, fontWeight: FontWeight.w800),
            ),
            const Icon(Icons.chevron_right, color: _Gold.goldDark),
          ],
        ),
      ),
    );
  }

  Widget _stepBlock(AppSettings s, int index) {
    final step = _steps[index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
        decoration: BoxDecoration(
          color: _Gold.pearl,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _Gold.goldLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: _Gold.gold,
                  ),
                  child: Text('${index + 1}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(s.t(step.title),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: _Gold.ink)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 1, 0, 6),
              child: Text(s.t(step.sub),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: _Gold.soft)),
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 0.8,
              children: [
                for (final it in step.items) _featureCard(s, it),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureCard(AppSettings s, _F it) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _open(it.key),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _Gold.cream,
                border: Border.all(color: _Gold.goldLight),
              ),
              child: Icon(it.icon, color: _Gold.goldDark, size: 22),
            ),
            const SizedBox(height: 5),
            Text(
              s.t(it.label),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: _Gold.ink,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5,
                  height: 1.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inviteStrip(AppSettings s) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _Gold.pearl,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Gold.goldLight),
      ),
      child: Row(
        children: [
          const Icon(Icons.card_giftcard, color: _Gold.gold, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              s.t(const L('Invite a friend and share your code.',
                  'दोस्त को बुलाइए और अपना कोड बाँटिए।')),
              style: const TextStyle(
                  color: _Gold.ink, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: () => _open('referral'),
            child: Text(s.t(const L('Invite', 'बुलाइए')),
                style: const TextStyle(
                    color: _Gold.goldDark, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav(AppSettings s) {
    const keys = ['home', 'mynumbers', 'reports', 'learn', 'vault'];
    return Container(
      decoration: const BoxDecoration(
        color: _Gold.pearl,
        border: Border(top: BorderSide(color: _Gold.goldLight)),
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: _Gold.pearl,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _Gold.goldDark,
        unselectedItemColor: _Gold.soft,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (i) {
          if (i != 0) _open(keys[i]);
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: s.t(const L('Home', 'होम'))),
          BottomNavigationBarItem(
              icon: const Icon(Icons.auto_awesome),
              label: s.t(const L('My Numbers', 'मेरे अंक'))),
          BottomNavigationBarItem(
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: s.t(const L('Reports', 'रिपोर्ट'))),
          BottomNavigationBarItem(
              icon: const Icon(Icons.school_outlined),
              label: s.t(const L('Learn', 'सीखें'))),
          BottomNavigationBarItem(
              icon: const Icon(Icons.lock_outline),
              label: s.t(const L('Vault', 'वॉल्ट'))),
        ],
      ),
    );
  }
}

class _FeatureSearch extends SearchDelegate<String?> {
  _FeatureSearch(this.s);
  final AppSettings s;

  @override
  String get searchFieldLabel => s.t(const L('Search a feature', 'सुविधा खोजिए'));

  List<_F> _matches() {
    final q = query.trim().toLowerCase();
    final all = [for (final st in _steps) ...st.items];
    if (q.isEmpty) return all;
    return all.where((f) {
      return f.label.en.toLowerCase().contains(q) ||
          f.label.hi.contains(q) ||
          f.sub.en.toLowerCase().contains(q) ||
          f.sub.hi.contains(q);
    }).toList();
  }

  Widget _list(BuildContext context) {
    final list = _matches();
    if (list.isEmpty) {
      return Center(
        child: Text(s.t(const L('Nothing found', 'कुछ नहीं मिला'))),
      );
    }
    return ListView(
      children: [
        for (final f in list)
          ListTile(
            leading: Icon(f.icon, color: _Gold.gold),
            title: Text(s.t(f.label)),
            subtitle: Text(s.t(f.sub)),
            onTap: () => close(context, f.key),
          ),
      ],
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _list(context);

  @override
  Widget buildSuggestions(BuildContext context) => _list(context);
}
