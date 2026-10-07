import 'package:flutter/material.dart';
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              'Private, offline-first numerology analysis with a premium Cheiro-inspired engine.',
            ),
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
