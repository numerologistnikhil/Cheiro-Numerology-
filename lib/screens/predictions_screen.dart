import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/numerology_tools.dart';
import 'ui_kit.dart';

class PredictionsScreen extends StatefulWidget {
  const PredictionsScreen({super.key});

  @override
  State<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  DateTime? _dob;
  int _year = DateTime.now().year;

  Widget _monthGrid(DateTime dob) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.05,
      children: [
        for (var m = 1; m <= 12; m++)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AnkdharaColors.goldLine),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  monthName(m),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${NumerologyTools.personalMonth(dob, _year, m)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AnkdharaColors.gold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _result(DateTime dob) {
    final py = NumerologyTools.personalYear(dob, _year);
    final theme = NumerologyTools.yearThemes[py]!;
    final nowMonth = DateTime.now().month;
    final thisYear = DateTime.now().year;
    final pm = NumerologyTools.personalMonth(dob, _year, nowMonth);

    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoldCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    NumberBadge(py, size: 68),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Year $py  |  $_year',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AnkdharaColors.gold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            theme.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(height: 1, color: AnkdharaColors.goldLine),
                InfoRow(Icons.auto_stories_outlined, 'Theme', theme.theme),
                InfoRow(Icons.flag_outlined, 'Focus on', theme.focus),
                InfoRow(Icons.warning_amber_rounded, 'Be careful of', theme.caution),
              ],
            ),
          ),
          if (_year == thisYear) ...[
            const SectionLabel('This month'),
            GoldCard(
              child: Row(
                children: [
                  NumberBadge(pm, size: 48),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Personal Month $pm. ${NumerologyTools.monthHints[pm]}',
                      style: const TextStyle(fontSize: 14.5, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SectionLabel('Month by month in $_year'),
          _monthGrid(dob),
          const SectionLabel('Coming years'),
          GoldCard(
            child: Column(
              children: [
                for (var y = _year; y < _year + 5; y++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 56,
                          child: Text(
                            '$y',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        NumberBadge(NumerologyTools.personalYear(dob, y), size: 34),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            NumerologyTools
                                .yearThemes[NumerologyTools.personalYear(dob, y)]!
                                .title,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const Note(
            'Personal Year = day + month of birth + the chosen year, reduced '
            'to a single digit. These are general themes for reflection and '
            'planning, not predictions or guarantees.',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dob = _dob;
    return PageShell(
      title: 'Predictions',
      children: [
        const SectionLabel('Birth date'),
        DateField(
          label: 'Select date of birth',
          value: dob,
          onChanged: (d) => setState(() => _dob = d),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _year > 1950 ? () => setState(() => _year--) : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Text(
              '$_year',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            IconButton(
              onPressed: _year < 2100 ? () => setState(() => _year++) : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (dob == null)
          const Note('Choose a date of birth to see the personal year and month cycle.')
        else
          _result(dob),
      ],
    );
  }
}
