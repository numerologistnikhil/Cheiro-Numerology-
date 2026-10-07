import 'package:flutter/material.dart';
import '../core/numerology_engine.dart';
import 'ai_numerologist_screen.dart';
import 'baby_names_screen.dart';
import 'business_screen.dart';
import 'client_vault_screen.dart';
import 'compatibility_screen.dart';
import 'date_selection_screen.dart';
import 'learn_screen.dart';
import 'name_correction_screen.dart';
import 'predictions_screen.dart';
import 'profession_screen.dart';
import 'remedies_screen.dart';
import 'report_builder_screen.dart';

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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              'Compound: ${result.total}  •  Root: ${result.root}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            if (result.hasCheiroCompound) ...[
              const SizedBox(height: 10),
              Text(result.compoundMeaning,
                  style: const TextStyle(fontSize: 14, height: 1.45)),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final modules = <String, Widget>{
      'Name Correction': const NameCorrectionScreen(),
      'Compatibility': const CompatibilityScreen(),
      'Predictions': const PredictionsScreen(),
      'Business': const BusinessScreen(),
      'Profession': const ProfessionScreen(),
      'Remedies': const RemediesScreen(),
      'Baby Names': const BabyNamesScreen(),
      'AI Numerologist': const AiNumerologistScreen(),
      'Report Builder': const ReportBuilderScreen(),
      'Learn Numerology': const LearnScreen(),
      'Client Vault': const ClientVaultScreen(),
      'Date Selection': const DateSelectionScreen(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cheiro Numerology'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Numerology Dashboard',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Personal Numerology Intelligence • Private • Offline-first',
            ),
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFF4D6),
                      ),
                      child: const Icon(Icons.auto_awesome),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        'Explore your numbers, patterns, predictions and personalised guidance.',
                        style: TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                dob == null
                    ? 'Date of Birth'
                    : '${dob!.day}/${dob!.month}/${dob!.year}',
              ),
              trailing: const Icon(Icons.calendar_month),
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
            ),
            const SizedBox(height: 12),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: vehicleController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Calculate Numerology'),
              ),
            ),
            const SizedBox(height: 18),
            resultCard('Name Analysis', nameResult),
            resultCard('Date of Birth Analysis', dateResult),
            resultCard('Mobile Analysis', mobileResult),
            resultCard('Vehicle Analysis', vehicleResult),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.45,
              ),
              itemCount: modules.length,
              itemBuilder: (context, index) {
                final entry = modules.entries.elementAt(index);
                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => entry.value),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          entry.key,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
