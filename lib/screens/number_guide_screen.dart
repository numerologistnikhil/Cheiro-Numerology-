import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/root_profiles.dart';
import 'ui_kit.dart';

/// Interactive guide to root numbers 1-9, in English or Hindi.
class NumberGuideScreen extends StatefulWidget {
  /// Optionally open on a number (for example the user's own root number).
  final int initial;
  const NumberGuideScreen({super.key, this.initial = 1});

  @override
  State<NumberGuideScreen> createState() => _NumberGuideScreenState();
}

class _NumberGuideScreenState extends State<NumberGuideScreen> {
  late int selected;
  bool hindi = false;

  @override
  void initState() {
    super.initState();
    selected = (widget.initial >= 1 && widget.initial <= 9) ? widget.initial : 1;
  }

  @override
  Widget build(BuildContext context) {
    final p = RootProfiles.of(selected)!;
    final sections = <MapEntry<String, L>>[
      MapEntry(hindi ? 'व्यक्तित्व' : 'Personality', p.personality),
      MapEntry(hindi ? 'ताक़तें' : 'Strengths', p.strengths),
      MapEntry(hindi ? 'चुनौतियाँ' : 'Challenges', p.challenges),
      MapEntry(hindi ? 'करियर' : 'Career', p.career),
      MapEntry(hindi ? 'धन' : 'Money', p.money),
      MapEntry(hindi ? 'प्रेम और रिश्ते' : 'Love and relationships', p.love),
      MapEntry(hindi ? 'सेहत (सामान्य सुझाव)' : 'Health (general reminders)', p.health),
      MapEntry(hindi ? 'सलाह' : 'Advice', p.advice),
    ];

    return PageShell(
      title: hindi ? 'अंक गाइड' : 'Number Guide',
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: false, label: Text('English')),
              ButtonSegment(value: true, label: Text('हिन्दी')),
            ],
            selected: {hindi},
            onSelectionChanged: (v) => setState(() => hindi = v.first),
          ),
        ),
        const SizedBox(height: 12),
        NumberChips(
          selected: selected,
          onSelected: (n) => setState(() => selected = n),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeOut,
          child: Column(
            key: ValueKey('$selected-$hindi'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoldCard(
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AnkdharaColors.gold, width: 2),
                        color: AnkdharaColors.cream,
                      ),
                      child: Text(
                        '${p.number}',
                        style: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: AnkdharaColors.gold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        p.title.t(hindi),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GoldCard(
                child: Column(
                  children: [
                    _fact(hindi ? 'ग्रह' : 'Planet', p.planet.t(hindi)),
                    _fact(hindi ? 'शुभ दिन' : 'Lucky days', p.luckyDays.t(hindi)),
                    _fact(hindi ? 'शुभ रंग' : 'Colours', p.colours.t(hindi)),
                    _fact(hindi ? 'रत्न' : 'Gemstone', p.gemstone.t(hindi)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GoldCard(
                child: Text(
                  p.overview.t(hindi),
                  style: const TextStyle(fontSize: 15, height: 1.65),
                ),
              ),
              const SizedBox(height: 12),
              for (final s in sections)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Card(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 18),
                        childrenPadding:
                            const EdgeInsets.fromLTRB(18, 0, 18, 16),
                        iconColor: AnkdharaColors.gold,
                        collapsedIconColor: AnkdharaColors.gold,
                        title: Text(
                          s.key,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              s.value.t(hindi),
                              style: const TextStyle(fontSize: 14.5, height: 1.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 6),
              Note(hindi ? RootProfiles.disclaimerHi : RootProfiles.disclaimer),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fact(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AnkdharaColors.gold,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
