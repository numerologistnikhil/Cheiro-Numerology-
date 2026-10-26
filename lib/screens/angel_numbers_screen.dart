import 'package:flutter/material.dart';

import '../core/angel_numbers.dart';
import '../core/app.dart';
import '../core/app_settings.dart';
import '../core/report_pages.dart';
import 'ui_kit.dart';

/// Angel Numbers: what they are, how each one is read, and which ones are
/// closest to the customer's date of birth. English or Hindi, one at a time.
class AngelNumbersScreen extends StatefulWidget {
  const AngelNumbersScreen({super.key});

  @override
  State<AngelNumbersScreen> createState() => _AngelNumbersScreenState();
}

class _AngelNumbersScreenState extends State<AngelNumbersScreen> {
  DateTime? _dob;

  Color _strengthColor(int s) {
    switch (s) {
      case 3:
        return const Color(0xFF8A6A1F);
      case 2:
        return const Color(0xFFC9A24A);
      case 1:
        return const Color(0xFFA08C55);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AnkdharaColors.gold,
          ),
        ),
      );

  Widget _para(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(t, style: const TextStyle(fontSize: 14, height: 1.55)),
      );

  List<Widget> _paras(String s) => [
        for (final p in s.split('\n\n'))
          if (p.trim().isNotEmpty) _para(p.trim()),
      ];

  Widget _field(String label, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: AnkdharaColors.gold,
              ),
            ),
            const SizedBox(height: 2),
            Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
        ),
      );

  Widget _tile(AngelNumber a, DobLink? link, bool hi) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(
          '${a.number}   ${a.title(hi)}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        subtitle: link == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Pill(link.label(hi), color: _strengthColor(link.strength)),
                ),
              ),
        children: [
          if (link != null) _field(hi ? 'आपसे संबंध' : 'Link with you', link.reason(hi)),
          _field(ReportPages.angelMeaning.t(hi), a.meaning(hi)),
          _field(ReportPages.angelMessage.t(hi), a.message(hi)),
          _field(ReportPages.angelLove.t(hi), a.love(hi)),
          _field(ReportPages.angelCareer.t(hi), a.career(hi)),
          _field(ReportPages.angelStep.t(hi), a.action(hi)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hi = AppLang.of(context).hindi;
    final year = DateTime.now().year;
    final dob = _dob;

    // Numbers closest to the date of birth come first.
    final order = <AngelNumber>[];
    final linkOf = <String, DobLink>{};
    if (dob != null) {
      for (final l in AngelNumbers.linksForDob(dob, year)) {
        linkOf[l.angel.number] = l;
      }
      final list = [...AngelNumbers.all];
      final index = {
        for (var i = 0; i < AngelNumbers.all.length; i++) AngelNumbers.all[i].number: i,
      };
      list.sort((x, y) {
        final c = linkOf[y.number]!.strength.compareTo(linkOf[x.number]!.strength);
        return c != 0 ? c : index[x.number]!.compareTo(index[y.number]!);
      });
      order.addAll(list);
    } else {
      order.addAll(AngelNumbers.all);
    }

    return PageShell(
      title: hi ? 'एंजल नंबर' : 'Angel Numbers',
      children: [
        GoldCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AngelNumbers.introTitle(hi),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              ..._paras(AngelNumbers.intro(hi)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ExpansionTile(
            shape: const Border(),
            collapsedShape: const Border(),
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            title: Text(
              AngelNumbers.dobTitle(hi),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            children: _paras(AngelNumbers.dobGeneral(hi)),
          ),
        ),
        _label(hi ? 'अपनी जन्मतिथि से जाँचिए' : 'Check with your date of birth'),
        DateField(
          label: hi ? 'जन्म तिथि चुनिए' : 'Choose date of birth',
          value: dob,
          onChanged: (d) => setState(() => _dob = d),
        ),
        if (dob != null) ...[
          const SizedBox(height: 10),
          GoldCard(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _paras(AngelNumbers.dobParagraph(dob, year, hi)),
            ),
          ),
        ],
        _label(hi ? 'सभी एंजल नंबर' : 'All angel numbers'),
        if (dob != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              ReportPages.angelAllIntro.t(hi),
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        for (final a in order) _tile(a, linkOf[a.number], hi),
        Note(hi
            ? 'यह अंक शास्त्र और आध्यात्मिक मान्यता पर आधारित मार्गदर्शन है, कोई पक्की भविष्यवाणी नहीं। बड़े फ़ैसले हमेशा व्यावहारिक सोच और भरोसेमंद सलाह के साथ लीजिए।'
            : 'This is guidance based on numerology and spiritual belief, not a fixed prediction. Take big decisions with practical thinking and trusted advice.'),
      ],
    );
  }
}
