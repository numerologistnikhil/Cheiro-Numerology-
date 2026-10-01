
import 'package:flutter/material.dart';

void main() => runApp(const CheiroApp());

class CheiroApp extends StatelessWidget {
  const CheiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheiro Numerology',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF071426),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD9AD50),
          brightness: Brightness.dark,
          surface: const Color(0xFF10243B),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

const gold = Color(0xFFE4B95B);
const panel = Color(0xFF10243B);

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  final nameCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  String reportName = '';
  DateTime? birthDate;

  @override
  void dispose() {
    nameCtrl.dispose();
    dateCtrl.dispose();
    super.dispose();
  }

  int reduce(int n) {
    while (n > 9 && n != 11 && n != 22 && n != 33) {
      n = n.toString().split('').fold(0, (a, b) => a + int.parse(b));
    }
    return n;
  }

  int birthNumber(DateTime d) => reduce(d.day);
  int lifePath(DateTime d) => reduce(d.day + d.month + d.year.toString().split('').fold(0, (a, b) => a + int.parse(b)));

  int nameNumber(String name) {
    const values = {
      'A':1,'I':1,'J':1,'Q':1,'Y':1,
      'B':2,'K':2,'R':2,
      'C':3,'G':3,'L':3,'S':3,
      'D':4,'M':4,'T':4,
      'E':5,'H':5,'N':5,'X':5,
      'U':6,'V':6,'W':6,
      'O':7,'Z':7,
      'F':8,'P':8
    };
    final sum = name.toUpperCase().split('').fold<int>(0, (total, c) => total + (values[c] ?? 0));
    return sum == 0 ? 0 : reduce(sum);
  }

  String meaning(int n) {
    const descriptions = {
      1: 'Leadership, initiative and independence. Balance confidence with patience.',
      2: 'Cooperation, sensitivity and diplomacy. Protect your boundaries.',
      3: 'Expression, creativity and sociability. Give ideas a practical structure.',
      4: 'Order, discipline and steady effort. Stay flexible when plans change.',
      5: 'Adaptability, curiosity and communication. Avoid scattered priorities.',
      6: 'Responsibility, care and harmony. Make room for your own needs.',
      7: 'Reflection, analysis and inner growth. Pair insight with action.',
      8: 'Ambition, organization and material goals. Keep decisions ethical and measured.',
      9: 'Compassion, idealism and completion. Set realistic limits.',
      11: 'A traditional master-number interpretation emphasizes intuition and inspiration.',
      22: 'A traditional master-number interpretation emphasizes building and long-term plans.',
      33: 'A traditional master-number interpretation emphasizes service and responsibility.',
    };
    return descriptions[n] ?? 'A number for reflection and personal exploration.';
  }

  void makeReport() {
    final parsed = DateTime.tryParse(dateCtrl.text.trim());
    if (nameCtrl.text.trim().isEmpty || parsed == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your name and birth date as YYYY-MM-DD.')),
      );
      return;
    }
    setState(() {
      reportName = nameCtrl.text.trim();
      birthDate = parsed;
      tab = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(),
      _report(),
      _nameTool(),
      _remedies(),
      _more(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('✦  Cheiro Numerology', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFF071426),
        foregroundColor: gold,
      ),
      body: SafeArea(child: IndexedStack(index: tab, children: pages)),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF0B1C30),
        indicatorColor: gold.withOpacity(.18),
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), label: 'Report'),
          NavigationDestination(icon: Icon(Icons.edit_outlined), label: 'Name'),
          NavigationDestination(icon: Icon(Icons.spa_outlined), label: 'Remedies'),
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'More'),
        ],
      ),
    );
  }

  Widget _home() => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(colors: [Color(0xFF172F4A), Color(0xFF0B1B30)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          border: Border.all(color: gold.withOpacity(.5)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('YOUR NUMBERS • YOUR STORY', style: TextStyle(color: gold, letterSpacing: 1.4, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Discover your numerology profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Explore traditional Cheiro-inspired number meanings and reflective guidance.', style: TextStyle(color: Colors.white.withOpacity(.75))),
          const SizedBox(height: 18),
          TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Full name', hintText: 'e.g. Rahul Sharma', filled: true, border: OutlineInputBorder())),
          const SizedBox(height: 10),
          TextField(controller: dateCtrl, keyboardType: TextInputType.datetime, decoration: const InputDecoration(labelText: 'Date of birth', hintText: 'YYYY-MM-DD', helperText: 'Example: 1990-08-15', filled: true, border: OutlineInputBorder())),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: const Color(0xFF071426), padding: const EdgeInsets.symmetric(vertical: 15)),
            onPressed: makeReport, child: const Text('Create my free report', style: TextStyle(fontWeight: FontWeight.bold)),
          )),
        ]),
      ),
      const SizedBox(height: 18),
      const Text('Explore tools', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      GridView.count(
        crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.55,
        children: const [
          ToolTile(icon: Icons.numbers, title: 'Number profile', subtitle: 'Birth & life path'),
          ToolTile(icon: Icons.edit, title: 'Name analysis', subtitle: 'Compare spellings'),
          ToolTile(icon: Icons.calendar_month, title: 'Personal year', subtitle: 'Yearly theme'),
          ToolTile(icon: Icons.favorite_border, title: 'Compatibility', subtitle: 'Two profiles'),
        ],
      ),
      const SizedBox(height: 14),
      const Text('For reflection and entertainment. Numerology is not scientifically validated and should not replace professional advice.', style: TextStyle(color: Colors.white54, fontSize: 11)),
    ],
  );

  Widget _report() {
    if (birthDate == null) return const EmptyState(title: 'Your report is waiting', text: 'Enter your name and birth date on Home to create your profile.');
    final b = birthNumber(birthDate!);
    final lp = lifePath(birthDate!);
    final nn = nameNumber(reportName);
    return ListView(padding: const EdgeInsets.all(18), children: [
      Text('Hello, $reportName', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const Text('Your starter numerology profile', style: TextStyle(color: Colors.white60)),
      const SizedBox(height: 18),
      Row(children: [
        Expanded(child: NumberCard(label: 'Birth number', value: '$b')),
        const SizedBox(width: 10),
        Expanded(child: NumberCard(label: 'Life path', value: '$lp')),
        const SizedBox(width: 10),
        Expanded(child: NumberCard(label: 'Name number', value: nn == 0 ? '—' : '$nn')),
      ]),
      const SizedBox(height: 18),
      const Text('Traditional interpretations', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      InfoCard(title: 'Birth number $b', body: meaning(b)),
      InfoCard(title: 'Life path $lp', body: meaning(lp)),
      if (nn != 0) InfoCard(title: 'Name number $nn', body: meaning(nn)),
      const SizedBox(height: 12),
      const Text('These are general symbolic interpretations, not certain predictions about events or outcomes.', style: TextStyle(color: Colors.white54, fontSize: 12)),
    ]);
  }

  Widget _nameTool() {
    final ctrl = TextEditingController();
    return StatefulBuilder(builder: (context, localSet) {
      final number = nameNumber(ctrl.text);
      return ListView(padding: const EdgeInsets.all(18), children: [
        const Text('Name analysis & correction', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Try alternative spellings and compare their Chaldean-style name values. Suggestions are exploratory, not guarantees of success.', style: TextStyle(color: Colors.white60)),
        const SizedBox(height: 16),
        TextField(controller: ctrl, onChanged: (_) => localSet(() {}), decoration: const InputDecoration(labelText: 'Enter a name', hintText: 'e.g. Nikhil Gulati', border: OutlineInputBorder(), filled: true)),
        const SizedBox(height: 16),
        NumberCard(label: 'Name number', value: number == 0 ? '—' : '$number'),
        if (number != 0) InfoCard(title: 'Meaning', body: meaning(number)),
        const SizedBox(height: 10),
        const InfoCard(title: 'How name correction works', body: 'The app can compare the numerical values of spelling options. A future full version can add a guided suggestion engine, explain every proposed change, and let users choose whether to use it.'),
      ]);
    });
  }

  Widget _remedies() => ListView(padding: const EdgeInsets.all(18), children: const [
    Text('Traditional guidance', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
    SizedBox(height: 8),
    Text('Remedies in the full app will be presented as cultural or spiritual practices, not as guaranteed ways to change events.', style: TextStyle(color: Colors.white60)),
    SizedBox(height: 14),
    InfoCard(title: 'Colors & reflection', body: 'Some numerology traditions associate numbers with colors. Treat these as personal or cultural symbolism; choose colors that you enjoy.'),
    InfoCard(title: 'Favorable dates', body: 'Numerology can be used to select personally meaningful dates. For important medical, legal or financial decisions, use practical criteria and qualified advice.'),
    InfoCard(title: 'Gemstones', body: 'Traditional gemstone associations vary. The app should explain the tradition and avoid claiming that gemstones cure illness or guarantee wealth.'),
    InfoCard(title: 'Daily practice', body: 'Use a number-based affirmation or journaling prompt as a mindfulness exercise, if it feels useful to you.'),
  ]);

  Widget _more() => ListView(padding: const EdgeInsets.all(18), children: const [
    Text('More numerology tools', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
    SizedBox(height: 12),
    InfoCard(title: 'Lo Shu grid', body: 'A traditional 3×3 number chart based on a birth date. A complete version can show digit counts and explain common interpretations.'),
    InfoCard(title: 'Compatibility', body: 'Compare two birth dates and names, then display traditional number associations without presenting a compatibility score as a reliable relationship outcome.'),
    InfoCard(title: 'Personal year', body: 'Explore a symbolic annual theme calculated from birth day, birth month and the calendar year.'),
    InfoCard(title: 'Daily / monthly forecast', body: 'The complete product can generate date-based reflections from the profile. This starter app does not yet generate automated forecasts.'),
    InfoCard(title: 'Privacy', body: 'Before publishing, add a privacy policy and explain how birth dates and names are stored. This prototype keeps profile data only in the current app session.'),
  ]);
}

class ToolTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const ToolTile({super.key, required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: gold.withOpacity(.2))),
    padding: const EdgeInsets.all(13),
    child: Row(children: [
      Icon(icon, color: gold),
      const SizedBox(width: 9),
      Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ])),
    ]),
  );
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;
  const NumberCard({super.key, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 8),
    decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: gold.withOpacity(.55))),
    child: Column(children: [
      Text(value, style: const TextStyle(color: gold, fontSize: 27, fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.white70)),
    ]),
  );
}

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  const InfoCard({super.key, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 15)),
      const SizedBox(height: 6),
      Text(body, style: const TextStyle(height: 1.4, color: Colors.white80)),
    ]),
  );
}

class EmptyState extends StatelessWidget {
  final String title;
  final String text;
  const EmptyState({super.key, required this.title, required this.text});
  @override
  Widget build(BuildContext context) => Center(child: Padding(
    padding: const EdgeInsets.all(28),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.auto_awesome, size: 52, color: gold),
      const SizedBox(height: 14),
      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white60)),
    ]),
  ));
}
