import 'package:flutter/material.dart';

void main() {
  runApp(const CheiroNumerologyApp());
}

class CheiroNumerologyApp extends StatelessWidget {
  const CheiroNumerologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheiro Numerology',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primarySwatch: Colors.amber,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _result = '';
  String _details = '';

  // Chaldean Numerology Letter Values
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

  void _calculateNumerology() {
    String name = _nameController.text.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    if (name.isEmpty) {
      setState(() {
        _result = 'Please enter a valid name';
        _details = '';
      });
      return;
    }

    int sum = 0;
    for (int i = 0; i < name.length; i++) {
      sum += chaldeanMap[name[i]] ?? 0;
    }

    setState(() {
      _result = 'Compound Number: $sum';
      _details = 'Calculated using authentic Chaldean vibration values.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cheiro Numerology', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter Full Name (Chaldean System)',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E293B),
                hintText: 'e.g., Nikhil Gulati',
                hintStyle: const TextStyle(color: Colors.white38),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateNumerology,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Calculate Number', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
              style: const TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _details,
              style: const TextStyle(color: Colors.white60, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
