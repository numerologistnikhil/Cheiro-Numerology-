import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/numerology_engine.dart';
import 'analysis_card.dart';
import 'ai_numerologist_screen.dart';
import 'baby_names_screen.dart';
import 'business_screen.dart';
import 'client_vault_screen.dart';
import 'compatibility_screen.dart';
import 'daily_lucky_screen.dart';
import 'date_selection_screen.dart';
import 'learn_screen.dart';
import 'name_correction_screen.dart';
import 'predictions_screen.dart';
import 'profession_screen.dart';
import 'remedies_screen.dart';
import 'report_builder_screen.dart';

class _Module {
  final String title;
  final IconData icon;
  final Widget screen;
  const _Module(this.title, this.icon, this.screen);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final vehicleController = TextEditingController();

  DateTime? dob;
  NumerologyResult? nameResult;
  NumerologyResult? dateResult;
  NumerologyResult? mobileResult;
  NumerologyResult? vehicleResult;

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    vehicleController.dispose();
    super.dispose();
  }

  void calculate() {
    setState(() {
      nameResult = NumerologyEngine.name(nameController.text);
      if (dob != null) {
        dateResult = NumerologyEngine.date(dob!);
      }
      mobileResult = NumerologyEngine.mobile(mobileController.text);
      vehicleResult = NumerologyEngine.vehicle(vehicleController.text);
    });
  }

  Widget resultCard(String title, NumerologyResult? result) {
    if (result == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AnkdharaColors.gold, AnkdharaColors.goldLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  '${result.root}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 6),
                    Text(
                      'Compound: ${result.total}  •  Root: ${result.root}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AnkdharaColors.gold,
                      ),
                    ),
                    if (result.hasCheiroCompound) ...[
                      const SizedBox(height: 10),
                      Text(result.compoundMeaning,
                          style:
                              const TextStyle(fontSize: 14, height: 1.5)),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget heroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xFF9C6F08), AnkdharaColors.gold, AnkdharaColors.goldLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33B8860B),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'ANKDHARA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              letterSpacing: 4,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'अंकधारा',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Your numbers, patterns and personal guidance in one private place.',
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  @override
  Widget build(BuildContext context) {
    final modules = <_Module>[
      const _Module('Name Correction', Icons.spellcheck, NameCorrectionScreen()),
      const _Module('Compatibility', Icons.favorite_border, CompatibilityScreen()),
      const _Module('Predictions', Icons.timeline, PredictionsScreen()),
      const _Module('Daily Lucky', Icons.wb_sunny_outlined, DailyLuckyScreen()),
      const _Module('Business', Icons.storefront, BusinessScreen()),
      const _Module('Profession', Icons.work_outline, ProfessionScreen()),
      const _Module('Remedies', Icons.diamond_outlined, RemediesScreen()),
      const _Module('Baby Names', Icons.child_care, BabyNamesScreen()),
      const _Module('AI Numerologist', Icons.auto_awesome, AiNumerologistScreen()),
      const _Module('Report Builder', Icons.picture_as_pdf_outlined, ReportBuilderScreen()),
      const _Module('Learn Numerology', Icons.menu_book_outlined, LearnScreen()),
      const _Module('Client Vault', Icons.lock_outline, ClientVaultScreen()),
      const _Module('Date Selection', Icons.event_available, DateSelectionScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/ankdhara_logo.png',
              height: 32,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
            const SizedBox(width: 8),
            const Text('Ankdhara'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heroCard(),
            const SizedBox(height: 26),
            sectionTitle('Your Details'),
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  initialDate: dob ?? DateTime(1990),
                );
                if (picked != null) {
                  setState(() => dob = picked);
                }
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AnkdharaColors.goldLine),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month,
                        color: AnkdharaColors.gold),
                    const SizedBox(width: 12),
                    Text(
                      dob == null
                          ? 'Date of Birth'
                          : '${dob!.day}/${dob!.month}/${dob!.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: vehicleController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Number',
                prefixIcon: Icon(Icons.directions_car_outlined),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Calculate Numerology'),
              ),
            ),
            const SizedBox(height: 22),
            AnalysisCard(title: 'Name Analysis', result: nameResult),
            AnalysisCard(title: 'Date of Birth Analysis', result: dateResult),
            AnalysisCard(title: 'Mobile Analysis', result: mobileResult),
            AnalysisCard(title: 'Vehicle Analysis', result: vehicleResult),
            const SizedBox(height: 8),
            sectionTitle('Explore Modules'),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.15,
              ),
              itemCount: modules.length,
              itemBuilder: (context, index) {
                final m = modules[index];
                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => m.screen),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AnkdharaColors.cream,
                            ),
                            child: Icon(m.icon, color: AnkdharaColors.gold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            m.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
