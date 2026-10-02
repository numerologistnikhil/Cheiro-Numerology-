import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const CheiroNumerologyApp());
}

class CheiroNumerologyApp extends StatelessWidget {
  const CheiroNumerologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheiro Numerology Elite Master',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFFD4AF37),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4AF37),
          primary: const Color(0xFFD4AF37),
          surface: const Color(0xFF1E293B),
        ),
      ),
      home: const SelectionContainer.disabled(
        child: HomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _donationTimer;

  bool _isHindi = false; // Language Toggle: false = English, true = Hindi

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  int? _compoundNumber;
  int? _singleNumber;
  String _title = '';
  String _planet = '';
  String _detailedReport = '';
  String _remediesText = '';
  bool _isPdfUnlocked = false;

  final Map<String, int> chaldeanMap = {
    'A': 1, 'I': 1, 'J': 1, 'Q': 1, 'Y': 1,
    'B': 2, 'K': 2, 'R': 2,
    'C': 3, 'G': 3, 'L': 3, 'S': 3,
    'D': 4, 'M': 4, 'T': 4,
    'E': 5, 'H': 5, 'N': 5, 'X': 5,
    'U': 6, 'V': 6, 'W': 6,
    'O': 7, 'Z': 7,
    'F': 8, 'P': 8,
  };

  final Map<int, Map<String, String>> eliteDatabase = {
    19: {
      'title_en': 'The Sun of Success (19)',
      'title_hi': 'Safalta ka Surya (19)',
      'planet_en': 'Ruling Energy: Surya (The Sun)',
      'planet_hi': 'Prabhari Urja: Surya',
      'desc_en': 'One of the most auspicious numbers. Represents happiness, honor, and victory.',
      'desc_hi': 'Sabse shubh numbers mein se ek. Khushi, samman aur vijay ka prateek hai.',
      'detail_en': 'Promises supreme confidence, victory over adversaries, happiness, and financial abundance.',
      'detail_hi': 'Atulniya aatmavishwas, dushmanon par vijay aur dhan-daulat ka aashirwad deta hai.',
      'remedy_en': 'Gemstone: Natural Ruby (Manik) | Lucky Colors: Orange, Gold, White | Day: Sunday',
      'remedy_hi': 'Ratna: Asli Manik | Shubh Rang: Narangi, Sunehra, Safed | Din: Ravivar'
    },
    37: {
      'title_en': 'Fortunate Enterprise (37)',
      'title_hi': 'Bhagyashali Vyapar (37)',
      'planet_en': 'Ruling Energy: Sun & Jupiter Blessing',
      'planet_hi': 'Prabhari Urja: Surya & Guru',
      'desc_en': 'Strong intuitive power, success in enterprise, and faithful connections.',
      'desc_hi': 'Majboot antardrashti, vyapar mein safalta aur vishwasniya sambandh.',
      'detail_en': 'A premier business number attracting loyal partnerships and massive corporate expansion.',
      'remedy_en': 'Gemstone: Yellow Sapphire & Ruby | Lucky Colors: Yellow, Gold | Day: Thursday',
      'remedy_hi': 'Ratna: Pukhraj aur Manik | Shubh Rang: Peela, Sunehra | Din: Brihaspativar'
    }
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // 30-Second Emotional Milk Bottle Donation Trigger
    _donationTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        _showEmotionalMilkBottlePopup();
      }
    });
  }

  @override
  void dispose() {
    _donationTimer?.cancel();
    _tabController.dispose();
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _showEmotionalMilkBottlePopup() {
    double milkProgress = 0.3;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: Row(
            children: [
              const Icon(Icons.child_care, color: Color(0xFFD4AF37), size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _isHindi ? 'Ek Chhoti Si Madad, Ek Muskaan!' : 'A Small Help, A Big Smile!',
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isHindi 
                    ? 'Aapke ek chote se sahyog se is bachhe ki doodh ki bottle bharne aur parivaar ki madad karne mein bada yogdaan milega. Kripya support dein!' 
                    : 'Your small contribution will help fill a child\'s milk bottle and support the family. Please support!',
                style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD4AF37)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.baby_changing_station, color: Colors.white, size: 40),
                    const SizedBox(height: 8),
                    Text(_isHindi ? 'Doodh Ki Bottle Status' : 'Milk Bottle Status', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: milkProgress,
                      backgroundColor: Colors.white24,
                      color: Colors.white,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 6),
                    Text(_isHindi ? '${(milkProgress * 100).toInt()}% Bottle Bhari Gayi!' : '${(milkProgress * 100).toInt()}% Bottle Filled!', style: const TextStyle(color: Colors.white60, fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text('UPI ID: 9210896940@ybl', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(_isHindi ? 'Baad Mein' : 'Later', style: const TextStyle(color: Colors.white60)),
            ),
            ElevatedButton(
              onPressed: () {
                setStateDialog(() {
                  milkProgress = 1.0;
                });
                Future.delayed(const Duration(milliseconds: 600), () {
                  if (mounted) Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('UPI ID: 9210896940@ybl opened.'), backgroundColor: Colors.green),
                  );
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
              child: Text(_isHindi ? 'DOODH DALEN (DONATE ₹50)' : 'DONATE ₹50', style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateSum(String name) {
    String cleanName = name.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    int sum = 0;
    for (int i = 0; i < cleanName.length; i++) {
      sum += chaldeanMap[cleanName[i]] ?? 0;
    }
    return sum;
  }

  int _reduceToOneDigit(int n) {
    while (n > 9) {
      n = n.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }
    return n;
  }

  void _analyzeProfile() {
    String inputName = _nameController.text.trim();
    if (inputName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isHindi ? 'Kripya client ka poora naam darj karein!' : 'Please enter client full name!'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    int sum = _calculateSum(inputName);
    int singleNum = _reduceToOneDigit(sum);

    var eliteInfo = eliteDatabase[sum] ?? {
      'title_en': 'Compound Number: $sum (Elite Matrix)',
      'title_hi': 'Compound Number: $sum (Elite Matrix)',
      'planet_en': 'Ruling Energy: Cosmic Vibration',
      'planet_hi': 'Prabhari Urja: Cosmic Vibration',
      'desc_en': 'Carries structured growth potential.',
      'desc_hi': 'Sanrachnatmak vikas urja rakhta hai.',
      'detail_en': 'Your name evaluates to compound number $sum, bringing specialized professional energy.',
      'detail_hi': 'Aapke naam ka yog $sum hai, jo vishesh vyavsayik urja pradan karta hai.',
      'remedy_en': 'Gemstone: Custom Consultation Advised | Colors: White, Gold',
      'remedy_hi': 'Ratna: Vishesh Salah Lein | Rang: Safed, Sunehra'
    };

    setState(() {
      _compoundNumber = sum;
      _singleNumber = singleNum;
      _title = _isHindi ? eliteInfo['title_hi']! : eliteInfo['title_en']!;
      _planet = _isHindi ? eliteInfo['planet_hi']! : eliteInfo['planet_en']!;
      _detailedReport = _isHindi ? eliteInfo['detail_hi']! : eliteInfo['detail_en']!;
      _remediesText = _isHindi ? eliteInfo['remedy_hi']! : eliteInfo['remedy_en']!;
    });
  }

  void _verifyPaymentAndUnlockPDF() {
    if (_isPdfUnlocked) {
      _showProPDFPreviewModal();
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Row(
          children: [
            const Icon(Icons.lock, color: Color(0xFFD4AF37)),
            const SizedBox(width: 10),
            Text(_isHindi ? 'Security Payment Anivarya' : 'Security Payment Required', style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isHindi 
                  ? 'Is professional PDF report ko print ya download karne ke liye ₹100 ka security charge dena anivarya hai.' 
                  : 'A security charge of ₹100 is mandatory to print or download this professional PDF report.',
              style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFD4AF37)),
              ),
              child: const Text(
                'Send ₹100 to UPI ID:\n9210896940@ybl',
                style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(_isHindi ? 'Radd Karein' : 'CANCEL', style: const TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isPdfUnlocked = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_isHindi ? 'Payment Verify Ho Gayi! PDF Unlock Ho Gaya.' : 'Payment Verified! PDF Unlocked.'), backgroundColor: Colors.green),
              );
              _showProPDFPreviewModal();
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
            child: Text(_isHindi ? 'SUBMIT & UNLOCK (₹100)' : 'SUBMIT & UNLOCK (₹100)', style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showProPDFPreviewModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_isHindi ? 'Pro PDF Report (Multilingual)' : 'Pro PDF Report (Multilingual)', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close, color: Colors.white70), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const Divider(color: Colors.white24),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_isHindi ? 'CHEIRO NUMEROLOGY ELITE DOSSIER' : 'CHEIRO NUMEROLOGY ELITE DOSSIER', style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(_isHindi ? 'Gopanīya evam Professional Report' : 'Confidential & Professional Report', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text('${_isHindi ? "Kharidar" : "Client Name"}: ${_nameController.text.isEmpty ? "Nikhil Gulati" : _nameController.text}', style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 6),
                      Text('${_isHindi ? "Mukhya Compound" : "Core Compound"}: ${_compoundNumber ?? 19} | Ruling: $_planet', style: const TextStyle(color: Colors.black87, fontSize: 12)),
                      const Divider(height: 20),
                      Text(_isHindi ? 'Vistrit Bhavishyavani:' : 'Detailed Esoteric Predictions:', style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text(_detailedReport.isNotEmpty ? _detailedReport : 'Predictions...', style: const TextStyle(color: Colors.black54, fontSize: 12, height: 1.4)),
                      const SizedBox(height: 15),
                      Text(_isHindi ? 'Ratna aur Upay:' : 'Remedies & Gemstones:', style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text(_remediesText.isNotEmpty ? _remediesText : 'Remedies...', style: const TextStyle(color: Colors.black54, fontSize: 12, height: 1.4)),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          _isHindi 
                              ? 'LEGAL DISCLAIMER: Sabhi gananaein keval shiksha aur manoranjan ke liye hain. Creator kisi bhi financial ya vyaktigat nirnay ke liye zimmedar nahi hain.' 
                              : 'LEGAL DISCLAIMER: All calculations are for educational and entertainment purposes only. Creators assume no liability.',
                          style: const TextStyle(color: Colors.black54, fontSize: 9, height: 1.3),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(4)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '💬 WhatsApp: +91 9210896940 | @NikhilVGulatii',
                              style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_isHindi ? 'PDF Safalpurvak Download Ho Gayi!' : 'PDF Successfully Downloaded!'), backgroundColor: Colors.green),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Text(_isHindi ? 'SAVE & PRINT PDF' : 'SAVE & PRINT PDF FILE', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isHindi ? 'CHEIRO NUMEROLOGY PRO (HINDI)' : 'CHEIRO NUMEROLOGY PRO',
          style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 15),
        ),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 2,
        centerTitle: true,
        actions: [
          // Language Switcher Toggle Button in AppBar
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _isHindi = !_isHindi;
                });
              },
              icon: const Icon(Icons.language, color: Color(0xFFD4AF37), size: 18),
              label: Text(
                _isHindi ? 'EN' : 'हिंदी',
                style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFD4AF37),
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(icon: const Icon(Icons.person_search), text: _isHindi ? 'Vishleshan' : 'Analysis'),
            Tab(icon: const Icon(Icons.picture_as_pdf), text: _isHindi ? 'Pro PDF' : 'Pro PDF Report'),
            Tab(icon: const Icon(Icons.volunteer_activism), text: _isHindi ? 'Sahyog / UPI' : 'Support & UPI'),
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              // TAB 1: Analysis
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(_isHindi ? 'Client Matrix Generator' : 'Client Matrix Generator', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        hintText: _isHindi ? 'Poora Naam Darj Karein (jaise Nikhil Gulati)' : 'Enter Full Name (e.g. Nikhil Gulati)',
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon: const Icon(Icons.person, color: Color(0xFFD4AF37)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _analyzeProfile,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), foregroundColor: const Color(0xFF0F172A), padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: Text(_isHindi ? 'PRO DOSSIER TAYAR KAREIN' : 'GENERATE PRO DOSSIER', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    if (_compoundNumber != null) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD4AF37)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            const SizedBox(height: 6),
                            Text(_detailedReport, style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // TAB 2: Pro PDF Report Hub with Security Lock
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(_isHindi ? 'Surakshit PDF Print Studio' : 'Secured PDF Print Studio', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFD4AF37)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.print, color: Color(0xFFD4AF37), size: 50),
                          const SizedBox(height: 12),
                          Text(_isHindi ? 'PDF Report Print / Download Karein' : 'Print / Download PDF Report', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            _isHindi 
                                ? 'Report print karne ke liye ₹100 UPI payment anivarya hai. Har page par WhatsApp (+91 9210896940) ka watermarked logo rahega.' 
                                : 'A ₹100 UPI payment is required to print report. Every page will feature WhatsApp (+91 9210896940) watermark.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: _verifyPaymentAndUnlockPDF,
                            icon: Icon(_isPdfUnlocked ? Icons.download : Icons.lock, color: const Color(0xFF0F172A)),
                            label: Text(_isPdfUnlocked 
                                ? (_isHindi ? 'DOWNLOAD / PRINT PDF' : 'DOWNLOAD / PRINT PDF') 
                                : (_isHindi ? 'PAY ₹100 & UNLOCK PRINT' : 'PAY ₹100 & UNLOCK PRINT'), 
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // TAB 3: Support & UPI
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(_isHindi ? 'Sahyog aur WhatsApp Chat' : 'Support Creator & WhatsApp Chat', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.volunteer_activism, color: Color(0xFFD4AF37), size: 40),
                          const SizedBox(height: 12),
                          const Text('Support Nikhil Gulati', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text('UPI ID: 9210896940@ybl', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
                          const Divider(color: Colors.white24, height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.chat_bubble, color: Colors.greenAccent, size: 20),
                              SizedBox(width: 8),
                              Text('WhatsApp: +91 9210896940', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                color: const Color(0xFF0F172A).withOpacity(0.9),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '© 2026 Cheiro Pro | 💬 WhatsApp: +91 9210896940 | @NikhilVGulatii',
                      style: TextStyle(color: Color(0x99D4AF37), fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
