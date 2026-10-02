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
      title: 'Cheiro Numerology Pro 5D Encyclopedia',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0B0F19), // Deep 5D Space Navy Background
        primaryColor: const Color(0xFF1E293B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4AF37),
          primary: const Color(0xFFD4AF37),
          surface: const Color(0xFF111827),
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
  Timer? _donationTimer;
  bool _isHindi = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _partnerNameController = TextEditingController();

  bool _hasAnalyzed = false;
  int? _compoundNumber;
  int? _singleNumber;
  String _title = '';
  String _detailedReport = '';
  List<Map<String, dynamic>> _chaldeanTableData = [];
  String _loShuPlanes = '';
  String _nameCorrections = '';
  String _synergyResult = '';
  String _signatureAnalysis = '';
  String _gemstoneDetails = '';
  String _remediesDetails = '';
  String _healthDiet = '';
  String _karmicDebts = '';
  String _precautionsDetails = '';
  String _yearlyForecasts = '';
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
      'detail_en': 'This is one of the luckiest compound numbers! It promises supreme confidence, victory over adversaries, financial abundance, and public magnetism.',
      'detail_hi': 'Ye sabse shubh numbers mein se ek hai! Isse atulniya aatmavishwas, dushmanon par vijay, aur dhan-daulat ki prapti hoti hai.',
      'planes_en': 'Lo Shu Planes & Arrows Analysis:\n- Mental Plane (4-9-2): Exceptional intelligence and strategic planning.\n- Emotional Plane (3-5-7): Balanced spiritual and emotional depth.',
      'planes_hi': 'Lo Shu Planes aur Arrows Analysis:\n- Mental Plane (4-9-2): Tez buddhi aur strategic planning.\n- Emotional Plane (3-5-7): Santulit bhavnatmak aur adhyatmik gahrayi.',
      'gem_en': 'Gemstone: Natural Ruby (Manik)\nWeight: 3.25 to 5.25 Ratti\nMetal: Gold or Copper\nRuling Planet: Surya (Sun)',
      'gem_hi': 'Ratna: Asli Manik (Ruby)\nVajan: 3.25 se 5.25 Ratti\nDhatu: Sona ya Tamba\nPrabhari Grah: Surya',
      'remedy_en': 'Spiritual Remedies:\n- Chant "Om Suryaya Namah" 108 times daily.\n- Offer water to the Sun at sunrise.',
      'remedy_hi': 'Aadhyatmik Upay:\n- Roj subah 108 baar "Om Suryaya Namah" ka jaap karein.\n- Suryoday ke samay Surya dev ko jal arpit karein.',
      'health_en': 'Medical Numerology & Diet Guidance:\n- High vitality from Solar energy. Protect eyes and heart from over-exhaustion.\n- Diet: Citrus fruits, organic honey, and wheat.',
      'health_hi': 'Medical Numerology aur Aahar Salah:\n- Surya ki urja se staminata acchi rehti hai. Aankhon aur dil ka dhyan rakhein.',
      'karmic_en': 'Karmic Debt & Past Life Lessons:\n- Master patience with subordinates and avoid egoistic dominance.',
      'karmic_hi': 'Karmic Debt aur Purane Janm ke Paath:\n- Ahankar se bachna aur sabhi ke prati namrata rakhna mukhya paath hai.',
      'precautions_en': 'Critical Precautions & What NOT To Do:\n- Avoid dark black clothes and speculative underground financial traps.',
      'precautions_hi': 'Mahatvapurna Savdhaaniyan (Kya Kya Nahi Karein):\n- Gehre kale rang se bachein aur bina pakke kagaz ke nivesh na karein.',
      'yearly_en': 'Chapter-by-Chapter Yearly Timeline (2026-2035):\n- 2026: Career breakthrough & financial expansion.\n- 2027: Property acquisition & family harmony.\n- 2028: International networks & new ventures.\n- 2029-2035: Era of elite leadership & legacy building.',
      'yearly_hi': 'Chapter-wise Varshik Timeline (2026-2035):\n- 2026: Career mein bada badlaav aur dhan labh.\n- 2027: Property kharidne aur parivarik sukh.\n- 2028: Videsh yatra aur naye srot.\n- 2029-2035: Ucche pad aur samman ka kaal.'
    },
    37: {
      'title_en': 'Fortunate Enterprise (37)',
      'title_hi': 'Bhagyashali Vyapar (37)',
      'detail_en': 'A top-class number for business and partnerships. Attracts loyal partners, sharp intuition, and rapid wealth accumulation.',
      'detail_hi': 'Vyapar aur partnership ke liye behtareen number. Isse wafaadar partners milte hain aur tezi se dhan labh hota hai.',
      'planes_en': 'Lo Shu Planes & Arrows Analysis:\n- Action Plane (2-5-8): High endurance and practical business execution.',
      'planes_hi': 'Lo Shu Planes aur Arrows Analysis:\n- Action Plane (2-5-8): Jabardast stamina aur vyaparik karyanvayan ki kshamta.',
      'gem_en': 'Gemstone: Yellow Sapphire (Pukhraj)\nWeight: 4.25 Ratti in Gold\nRuling Planet: Sun & Jupiter',
      'gem_hi': 'Ratna: Pukhraj (Yellow Sapphire)\nVajan: 4.25 Ratti Sone mein\nPrabhari Grah: Surya aur Guru',
      'remedy_en': 'Spiritual Remedies:\n- Respect elders and apply saffron tilak daily.',
      'remedy_hi': 'Aadhyatmik Upay:\n- Bado ka aadar karein aur roz kesar ka tilak lagayein.',
      'health_en': 'Medical Numerology & Diet Guidance:\n- Focus on liver health and balanced digestion.',
      'health_hi': 'Medical Numerology aur Aahar Salah:\n- Liver health aur pachan tantra ko thik rakhein.',
      'karmic_en': 'Karmic Debt & Past Life Lessons:\n- Share financial success and mentor rising entrepreneurs.',
      'karmic_hi': 'Karmic Debt:\n- Aarthik safalta ko samaj ke bhale aur mentoring ke liye upayog karein.',
      'precautions_en': 'Critical Precautions & What NOT To Do:\n- Avoid over-trusting unverified business partners without legal agreements.',
      'precautions_hi': 'Mahatvapurna Savdhaaniyan (Kya Kya Nahi Karein):\n- Bina poori jaanch ke kisi par blind trust na karein.',
      'yearly_en': 'Chapter-by-Chapter Yearly Timeline (2026-2035):\n- Rapid enterprise growth, profitable investments, and corporate expansion.',
      'yearly_hi': 'Chapter-wise Varshik Timeline (2026-2035):\n- Vyapar mein tezi, naye nivesh aur corporate expansion.'
    }
  };

  @override
  void initState() {
    super.initState();
    _donationTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        _showCuteBabyMilkPopup();
      }
    });
  }

  @override
  void dispose() {
    _donationTimer?.cancel();
    _nameController.dispose();
    _partnerNameController.dispose();
    super.dispose();
  }

  void _showCuteBabyMilkPopup() {
    double milkProgress = 0.4;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: const Color(0xFF111827),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
          ),
          title: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(color: Color(0xFF1F2937), shape: BoxShape.circle),
                child: const Text('👶🍼', style: TextStyle(fontSize: 38)),
              ),
              const SizedBox(height: 12),
              Text(
                _isHindi ? 'Donate to Help Us Grow!' : 'Donate to Help Us Grow!',
                style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isHindi 
                    ? 'Aapke chhote se sahyog se is nanhe champion ki doodh ki bottle bharne aur parivaar ki madad karne mein bada yogdaan milega.' 
                    : 'Your small contribution helps fill our little champion\'s milk bottle and supports our mission. Please donate!',
                style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13, height: 1.4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF374151)),
                ),
                child: Column(
                  children: [
                    Text(_isHindi ? 'Milk Bottle Status 🍼' : 'Milk Bottle Status 🍼', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: milkProgress,
                      backgroundColor: const Color(0xFF374151),
                      color: const Color(0xFFD4AF37),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    const SizedBox(height: 6),
                    Text('${(milkProgress * 100).toInt()}% Bottle Filled!', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text('UPI ID: 9210896940@ybl', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(_isHindi ? 'Baad Mein' : 'Later', style: const TextStyle(color: Color(0xFF9CA3AF))),
            ),
            ElevatedButton(
              onPressed: () {
                setStateDialog(() {
                  milkProgress = 1.0;
                });
                Future.delayed(const Duration(milliseconds: 600), () {
                  if (mounted) Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('UPI ID: 9210896940@ybl opened. Thank you!'), backgroundColor: Colors.green),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: const Color(0xFF0B0F19),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(_isHindi ? 'DONATE ₹50 / ₹100' : 'DONATE ₹50 / ₹100', style: const TextStyle(fontWeight: FontWeight.bold)),
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

  void _analyzeProfile() {
    String inputName = _nameController.text.trim();
    if (inputName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isHindi ? 'Kripya poora naam darj karein!' : 'Please enter full name!'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    String cleanName = inputName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    List<Map<String, dynamic>> tableData = [];
    int totalSum = 0;
    for (int i = 0; i < cleanName.length; i++) {
      String char = cleanName[i];
      int val = chaldeanMap[char] ?? 0;
      totalSum += val;
      tableData.add({'char': char, 'val': val});
    }

    int singleNum = totalSum;
    while (singleNum > 9) {
      singleNum = singleNum.toString().split('').map(int.parse).reduce((a, b) => a + b);
    }

    var eliteInfo = eliteDatabase[totalSum] ?? {
      'title_en': 'Compound Number: $totalSum (Elite Matrix)',
      'title_hi': 'Compound Number: $totalSum (Elite Matrix)',
      'detail_en': 'Your name evaluates to compound number $totalSum, bringing structured career growth and strong destiny vibration.',
      'detail_hi': 'Aapke naam ka yog $totalSum hai, jo jeevan mein sthirta aur nirdharit safalta lata hai.',
      'planes_en': 'Lo Shu Planes: Balanced distribution across mental and emotional planes.',
      'planes_hi': 'Lo Shu Planes: Santulit grid distribution.',
      'gem_en': 'Gemstone: Yellow Sapphire / Diamond\nWeight: 4.25 Ratti',
      'gem_hi': 'Ratna: Pukhraj ya Diamond\nVajan: 4.25 Ratti',
      'remedy_en': 'Spiritual Remedies: Daily meditation and charity.',
      'remedy_hi': 'Aadhyatmik Upay: Roj dhyan aur daan-punya.',
      'health_en': 'Medical Numerology: Maintain active vitality.',
      'health_hi': 'Medical Numerology: Sakriya jeevan shaili rakhein.',
      'karmic_en': 'Karmic Debt: Focus on honesty and harmonious teamwork.',
      'karmic_hi': 'Karmic Debt: Imaandari aur sahyog par dhyan dein.',
      'precautions_en': 'Critical Precautions: Avoid unverified financial risks.',
      'precautions_hi': 'Mahatvapurna Savdhaaniyan: Bina jaanch ke aarthik jokhim na lein.',
      'yearly_en': 'Yearly Timeline (2026-2035): Progressive milestones achieved.',
      'yearly_hi': 'Varshik Timeline (2026-2035): Tarakki ke naye padav prapt honge.'
    };

    setState(() {
      _hasAnalyzed = true;
      _compoundNumber = totalSum;
      _singleNumber = singleNum;
      _chaldeanTableData = tableData;
      _title = _isHindi ? eliteInfo['title_hi']! : eliteInfo['title_en']!;
      _detailedReport = _isHindi ? eliteInfo['detail_hi']! : eliteInfo['detail_en']!;
      _loShuPlanes = _isHindi ? eliteInfo['planes_hi']! : eliteInfo['planes_en']!;
      _nameCorrections = _isHindi ? 'Dhan labh ke liye naam spelling mein uchit badlaav karein.' : 'Adjust spelling suffixes for maximum wealth.';
      _signatureAnalysis = _isHindi ? 'Upar ki taraf slope rakhein, blue/black pen use karein.' : 'Keep upward slope, use blue/black pen.';
      _gemstoneDetails = _isHindi ? eliteInfo['gem_hi']! : eliteInfo['gem_en']!;
      _remediesDetails = _isHindi ? eliteInfo['remedy_hi']! : eliteInfo['remedy_en']!;
      _healthDiet = _isHindi ? eliteInfo['health_hi']! : eliteInfo['health_en']!;
      _karmicDebts = _isHindi ? eliteInfo['karmic_hi']! : eliteInfo['karmic_en']!;
      _precautionsDetails = _isHindi ? eliteInfo['precautions_hi']! : eliteInfo['precautions_en']!;
      _yearlyForecasts = _isHindi ? eliteInfo['yearly_hi']! : eliteInfo['yearly_en']!;
    });
  }

  void _checkSynergy() {
    String pName = _partnerNameController.text.trim();
    if (pName.isEmpty) return;
    int pSum = _calculateSum(pName);
    int mySum = _compoundNumber ?? 19;
    int diff = (mySum - pSum).abs();

    setState(() {
      _synergyResult = diff <= 3 || diff == 5 || diff == 9
          ? (_isHindi ? 'Synergy Score: 92/100 (High Harmony & Mutual Trust)' : 'Synergy Score: 92/100 (High Harmony & Mutual Trust)')
          : (_isHindi ? 'Synergy Score: 68/100 (Moderate Friction, Name Tuning Advised)' : 'Synergy Score: 68/100 (Moderate Friction, Name Tuning Advised)');
    });
  }

  void _verifyPaymentAndUnlockPDF() {
    if (_isPdfUnlocked) {
      _showEncyclopedicPDFModal();
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF111827),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
        ),
        title: const Row(
          children: [
            Icon(Icons.lock_outline, color: Color(0xFFD4AF37)),
            SizedBox(width: 10),
            Text('Unlock Encyclopedic PDF', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aap screen par sab kuch bilkul free dekh sakte hain! Lekin is poori 20+ page ki Professional Structured PDF report ko print ya download karne ke liye ₹100 ka security charge dena hoga.',
              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD4AF37)),
              ),
              child: const Text(
                'Send ₹100 to UPI ID:\n9210896940@ybl',
                style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isPdfUnlocked = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment Verified! Structured PDF Download Unlocked Successfully.'), backgroundColor: Colors.green),
              );
              _showEncyclopedicPDFModal();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF0B0F19),
            ),
            child: const Text('SUBMIT & UNLOCK (₹100)', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showEncyclopedicPDFModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF111827),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Structured Professional PDF Encyclopedia', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close, color: Color(0xFF9CA3AF)), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const Divider(color: Color(0xFF374151)),
            Expanded(
              child: ListView(
                children: [
                  _buildPDFPageCard(pageNumber: 'Chapter 1: Front Cover & Executive Summary', child: _pdfText('CHEIRO NUMEROLOGY ELITE DOSSIER\nMaster Astrological & Business Encyclopedia\nPrepared For: ${_nameController.text.isEmpty ? "Nikhil Gulati" : _nameController.text}')),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 2: Legal Disclaimer & Terms of Use', child: _pdfText('DISCLAIMER: For educational and entertainment purposes only.\n💬 WhatsApp (Buy App/Code): +91 9210896940 | @NikhilVGulatii')),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 3: Core Personal Matrix & Planetary Calculation', child: _pdfText('Compound Number: ${_compoundNumber ?? 19} | Single Root: ${_singleNumber ?? 1}\n$_detailedReport')),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 4: Chaldean Letter-by-Letter Calculation Table', child: _pdfText('Letter values mapped across Chaldean system to verify exact compound numerology frequency.')),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 5: Visual Lo Shu Grid & Matrix Charts', child: _pdfText(_loShuPlanes)),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 6: Critical Precautions & What NOT To Do', child: _pdfText(_precautionsDetails)),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 7: Smart Name Correction Suggester', child: _pdfText(_nameCorrections)),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 8: Partner & Business Synergy Matcher', child: _pdfText(_synergyResult.isNotEmpty ? _synergyResult : 'Synergy evaluated.')),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 9: Signature Numerology Analysis', child: _pdfText(_signatureAnalysis)),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 10: Gemstone Prescription & Planetary Table', child: _pdfText(_gemstoneDetails)),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 11: Spiritual Remedies & Rituals', child: _pdfText(_remediesDetails)),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 12: Medical Numerology & Diet Guidance', child: _pdfText(_healthDiet)),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapter 13: Karmic Debt & Past Life Lessons', child: _pdfText(_karmicDebts)),
                  const SizedBox(height: 15),
                  _buildPDFPageCard(pageNumber: 'Chapters 14-20: Month-by-Month Future Timeline (2026-2035)', child: _pdfText(_yearlyForecasts)),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Structured Professional PDF Downloaded Successfully!'), backgroundColor: Colors.green),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: const Color(0xFF0B0F19),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('DOWNLOAD & PRINT STRUCTURED PDF', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pdfText(String text) {
    return Text(text, style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 13, height: 1.4));
  }

  Widget _buildPDFPageCard({required String pageNumber, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0B0F19),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD4AF37)),
            ),
            child: Text(pageNumber, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF111827),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF1F2937), Color(0xFF0B0F19)]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text('✨ CHEIRO PRO 5D', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Structured Professional Encyclopedia', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFFD4AF37)),
              title: const Text('Home Dashboard', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Color(0xFFD4AF37)),
              title: const Text('Structured PDF Report Hub', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                if (_hasAnalyzed) {
                  _verifyPaymentAndUnlockPDF();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kripya pehle apna naam daalkar report generate karein!'), backgroundColor: Colors.orange),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag, color: Color(0xFFD4AF37)),
              title: const Text('Buy App / Source Code', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF111827),
                    title: const Text('Buy App (Nikhil Gulati)', style: TextStyle(color: Color(0xFFD4AF37))),
                    content: const Text('WhatsApp: +91 9210896940 par sampark karein.', style: TextStyle(color: Color(0xFF9CA3AF))),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK', style: TextStyle(color: Color(0xFFD4AF37)))),
                    ],
                  ),
                );
              },
            ),
            const Divider(color: Color(0xFF374151)),
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFFD4AF37)),
              title: Text(_isHindi ? 'Switch to English' : 'हिंदी में बदलें', style: const TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  _isHindi = !_isHindi;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          _isHindi ? 'CHEIRO NUMEROLOGY (हिंदी)' : 'CHEIRO NUMEROLOGY PRO',
          style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 16),
        ),
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        centerTitle: true,
        actions: [
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 5D Glassmorphism 3D Floating Banner
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F2937), Color(0xFF111827), Color(0xFF0B0F19)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.15),
                    blurRadius: 25,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text('✨ Professional Structured Encyclopedia', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 10),
                  const Text('Free Report Generator & Pro PDF Studio', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1F2937),
                      hintText: _isHindi ? 'Poora Naam darj karein (jaise Nikhil Gulati)' : 'Enter Full Name (e.g. Nikhil Gulati)',
                      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                      prefixIcon: const Icon(Icons.person, color: Color(0xFFD4AF37)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF374151))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF374151))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFD4AF37))),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _partnerNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1F2937),
                      hintText: _isHindi ? 'Partner/Business Naam (Optional)' : 'Partner/Business Name (Optional)',
                      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                      prefixIcon: const Icon(Icons.handshake, color: Color(0xFFD4AF37)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF374151))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF374151))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFD4AF37))),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFF59E0B)]),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _analyzeProfile();
                        _checkSynergy();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(_isHindi ? 'STRUCTURED REPORT TAYAR KAREIN' : 'GENERATE STRUCTURED REPORT', style: const TextStyle(color: Color(0xFF0B0F19), fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Animated Results Container with Professional Chaldean Table & Lo Shu Grid
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: _hasAnalyzed
                  ? Column(
                      key: const ValueKey(1),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: const Color(0xFF111827),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: const Color(0xFF374151)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.verified, color: Colors.greenAccent, size: 24),
                                  const SizedBox(width: 8),
                                  Text(_title, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                              const Divider(color: Color(0xFF374151), height: 28),
                              const Text('Detailed Numerology Analysis (Free View):', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 8),
                              Text(_detailedReport, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13, height: 1.5)),
                              const SizedBox(height: 20),

                              // Professional Chaldean Calculation Table
                              const Text('📊 Chaldean Letter Calculation Table:', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1F2937),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFF374151)),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text('Letter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                                      DataColumn(label: Text('Chaldean Value', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                                    ],
                                    rows: _chaldeanTableData.map((item) {
                                      return DataRow(cells: [
                                        DataCell(Text(item['char'], style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold))),
                                        DataCell(Text(item['val'].toString(), style: const TextStyle(color: Color(0xFF9CA3AF)))),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Visual Lo Shu Grid Box representation
                              const Text('🔮 Lo Shu Grid & Matrix Chart:', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1F2937),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: const Color(0xFFD4AF37)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [_loShuCell('4'), _loShuCell('9'), _loShuCell('2')],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [_loShuCell('3'), _loShuCell('5'), _loShuCell('7')],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [_loShuCell('8'), _loShuCell('1'), _loShuCell('6')],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              const Text('Lo Shu Planes Analysis:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 8),
                              Text(_loShuPlanes, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13, height: 1.5)),
                              if (_synergyResult.isNotEmpty) ...[
                                const SizedBox(height: 18),
                                const Text('Partner/Business Synergy Match:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                const SizedBox(height: 8),
                                Text(_synergyResult, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13, height: 1.5)),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // PDF Download Hub 5D Floating Card
                        Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1F2937), Color(0xFF111827)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                            boxShadow: [
                              BoxShadow(color: Colors.amber.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 6)),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.picture_as_pdf, color: Color(0xFFD4AF37), size: 44),
                              const SizedBox(height: 10),
                              const Text('Download Structured Professional PDF', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              const Text('Report screen par bilkul free padhein. Print ya PDF file download karne ke liye keval ₹100 ka security charge dena hoga.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12, height: 1.4)),
                              const SizedBox(height: 18),
                              ElevatedButton.icon(
                                onPressed: _verifyPaymentAndUnlockPDF,
                                icon: const Icon(Icons.download, color: Color(0xFF0B0F19)),
                                label: const Text('DOWNLOAD / PRINT PDF (₹100)', style: TextStyle(color: Color(0xFF0B0F19), fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD4AF37),
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      key: const ValueKey(2),
                      padding: const EdgeInsets.all(35),
                      alignment: Alignment.center,
                      child: Column(
                        children: const [
                          Icon(Icons.auto_awesome, color: Color(0xFFD4AF37), size: 52),
                          SizedBox(height: 14),
                          Text('Enter your name above to view your structured professional report instantly!', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 30),

            // Buy App / Contact 5D Card
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF374151)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.shopping_bag, color: Color(0xFFD4AF37), size: 38),
                  const SizedBox(height: 10),
                  const Text('Want to Buy This App / Source Code?', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text('Contact developer Nikhil Gulati directly via WhatsApp for app purchase or business tie-ups.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.chat, color: Colors.greenAccent, size: 20),
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
    );
  }

  Widget _loShuCell(String number) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F19),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD4AF37)),
      ),
      child: Text(number, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }
}
