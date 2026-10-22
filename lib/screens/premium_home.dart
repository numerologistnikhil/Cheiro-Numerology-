import 'dart:async';
import 'package:flutter/material.dart';
import 'ai_numerologist_screen.dart';
import 'business_screen.dart';
import 'client_vault_screen.dart';
import 'compatibility_screen.dart';
import 'home_screen.dart';
import 'learn_screen.dart';
import 'name_correction_screen.dart';
import 'number_check_screens.dart';
import 'predictions_screen.dart';
import 'remedies_screen.dart';
import 'report_builder_screen.dart';

/// Ankdhara premium home (Myntra-style layout, golden / cream theme).
/// Koi extra package nahi chahiye. Taps seedha asli screens kholte hain.
class PremiumHome extends StatefulWidget {
  final void Function(String key)? onOpen;
  const PremiumHome({super.key, this.onOpen});

  @override
  State<PremiumHome> createState() => _PremiumHomeState();
}

class _Gold {
  static const cream = Color(0xFFFFF8EC);
  static const pearl = Color(0xFFFFFDF8);
  static const gold = Color(0xFFC9A24A);
  static const goldDark = Color(0xFF8A6A1F);
  static const goldLight = Color(0xFFF3DFA2);
  static const ink = Color(0xFF3A2E14);
  static const soft = Color(0xFF7A6A48);
}

class _Item {
  final String key;
  final String label;
  final IconData icon;
  const _Item(this.key, this.label, this.icon);
}

class _PremiumHomeState extends State<PremiumHome> {
  int _tab = 0;
  int _banner = 0;
  int _nav = 0;
  final PageController _pc = PageController(viewportFraction: 0.92);
  Timer? _timer;

  static const _tabs = ['ALL', 'NUMBERS', 'NAME', 'REPORTS', 'LEARN'];

  static const _circles = <_Item>[
    _Item('profile', 'Profile', Icons.person_outline),
    _Item('compound', 'Compound', Icons.auto_awesome),
    _Item('name', 'Name', Icons.spellcheck),
    _Item('mobile', 'Mobile', Icons.phone_android),
    _Item('vehicle', 'Vehicle', Icons.directions_car_outlined),
    _Item('business', 'Business', Icons.storefront_outlined),
    _Item('compatibility', 'Match', Icons.favorite_border),
    _Item('predictions', 'Predict', Icons.timeline),
  ];

  static const _grid = <_Item>[
    _Item('predictions', 'Personal Year\nand Month', Icons.calendar_month),
    _Item('remedies', 'Remedies and\nGemstones', Icons.diamond_outlined),
    _Item('learn', 'Learn and\nQuiz', Icons.school_outlined),
    _Item('reports', 'Detailed\nPDF Report', Icons.picture_as_pdf_outlined),
  ];

  static const _banners = <List<String>>[
    ['Pehli detailed report', 'FREE', 'Abhi try karo'],
    ['Naam sahi karo', 'Lucky spelling', 'Name Correction'],
    ['Mobile aur Vehicle', 'Lucky number', 'Check karo'],
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_pc.hasClients) return;
      final next = (_banner + 1) % _banners.length;
      _pc.animateToPage(next,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pc.dispose();
    super.dispose();
  }

  void _open(String key) {
    widget.onOpen?.call(key);
    Widget? page;
    switch (key) {
      case 'profile':
      case 'compound':
        page = const HomeScreen(); // purana screen: profile + analysis
        break;
      case 'name':
        page = const NameCorrectionScreen();
        break;
      case 'mobile':
        page = const MobileNumberScreen();
        break;
      case 'vehicle':
        page = const VehicleNumberScreen();
        break;
      case 'business':
        page = const BusinessScreen();
        break;
      case 'compatibility':
        page = const CompatibilityScreen();
        break;
      case 'predictions':
        page = const PredictionsScreen();
        break;
      case 'remedies':
        page = const RemediesScreen();
        break;
      case 'learn':
        page = const LearnScreen();
        break;
      case 'reports':
        page = const ReportBuilderScreen();
        break;
      case 'vault':
        page = const ClientVaultScreen();
        break;
      case 'search':
        page = const AiNumerologistScreen();
        break;
    }
    if (page != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page!));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ye feature jald aa raha hai')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Gold.cream,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  _circleRow(),
                  _offerStrip(),
                  _bannerCarousel(),
                  _dots(),
                  _sectionTitle('Explore karo'),
                  _featureGrid(),
                  _cashbackStrip(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _header() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFBEFC9), Color(0xFFFFF8EC)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _open('search'),
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: _Gold.pearl,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _Gold.gold, width: 1),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x22C9A24A),
                            blurRadius: 8,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.auto_awesome, color: _Gold.gold, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text('Search "Name Correction"',
                              style: TextStyle(color: _Gold.soft, fontSize: 14)),
                        ),
                        Icon(Icons.search, color: _Gold.goldDark),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () => _open('notifications'),
                icon: const Icon(Icons.notifications_none,
                    color: _Gold.ink, size: 28),
              ),
              IconButton(
                onPressed: () => _open('account'),
                icon: const Icon(Icons.account_circle_outlined,
                    color: _Gold.ink, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              itemBuilder: (_, i) {
                final sel = i == _tab;
                return GestureDetector(
                  onTap: () => setState(() => _tab = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: sel ? _Gold.gold : Colors.transparent,
                            width: 3),
                      ),
                    ),
                    child: Text(
                      _tabs[i],
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
                        color: sel ? _Gold.ink : _Gold.soft,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleRow() {
    return SizedBox(
      height: 104,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: _circles.length,
        itemBuilder: (_, i) {
          final it = _circles[i];
          return GestureDetector(
            onTap: () => _open(it.key),
            child: Container(
              width: 76,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_Gold.goldLight, _Gold.gold],
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x44C9A24A),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: Icon(it.icon, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 6),
                  Text(it.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          color: _Gold.ink,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _offerStrip() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF8A6A1F),
          Color(0xFFC9A24A),
          Color(0xFF8A6A1F),
        ]),
      ),
      child: const Center(
        child: Text(
          'PEHLI REPORT FREE  *  ANKDHARA',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              fontSize: 15),
        ),
      ),
    );
  }

  Widget _bannerCarousel() {
    return SizedBox(
      height: 190,
      child: PageView.builder(
        controller: _pc,
        onPageChanged: (i) => setState(() => _banner = i),
        itemCount: _banners.length,
        itemBuilder: (_, i) {
          final b = _banners[i];
          return Container(
            margin: const EdgeInsets.fromLTRB(6, 10, 6, 6),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF3CF), Color(0xFFE9C766)],
              ),
              border: Border.all(color: _Gold.gold, width: 1.5),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x33C9A24A),
                    blurRadius: 14,
                    offset: Offset(0, 6))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(b[0],
                          style: const TextStyle(
                              color: _Gold.goldDark,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(b[1],
                          style: const TextStyle(
                              color: _Gold.ink,
                              fontSize: 30,
                              fontWeight: FontWeight.w900)),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _open(i == 0 ? 'reports' : i == 1 ? 'name' : 'mobile'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: _Gold.ink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(b[2],
                              style: const TextStyle(
                                  color: _Gold.goldLight,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.auto_awesome, size: 84, color: Color(0xAAFFFFFF)),
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
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
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

  Widget _sectionTitle(String t) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Text(t,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _Gold.ink,
              letterSpacing: 0.5)),
    );
  }

  Widget _featureGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.35,
        children: _grid.map((it) {
          return GestureDetector(
            onTap: () => _open(it.key),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _Gold.pearl,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _Gold.goldLight, width: 1.2),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x22C9A24A),
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(it.icon, color: _Gold.gold, size: 32),
                  Text(it.label,
                      style: const TextStyle(
                          color: _Gold.ink,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          height: 1.2)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _cashbackStrip() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Gold.pearl,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Gold.goldLight),
      ),
      child: Row(
        children: [
          const Icon(Icons.card_giftcard, color: _Gold.gold, size: 30),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Dost ko refer karo, aapko ek detailed report FREE',
              style: TextStyle(
                  color: _Gold.ink, fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () => _open('referral'),
            child: const Text('Refer',
                style: TextStyle(
                    color: _Gold.goldDark, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: _Gold.pearl,
        border: Border(top: BorderSide(color: _Gold.goldLight)),
      ),
      child: BottomNavigationBar(
        currentIndex: _nav,
        backgroundColor: _Gold.pearl,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _Gold.goldDark,
        unselectedItemColor: _Gold.soft,
        onTap: (i) {
          setState(() => _nav = i);
          const keys = ['home', 'reports', 'learn', 'vault', 'account'];
          if (i != 0) _open(keys[i]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf_outlined), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.lock_outline), label: 'Vault'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
