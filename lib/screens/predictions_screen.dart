import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/numerology_tools.dart';
import '../core/report_text.dart';
import 'report_builder_screen.dart';
import 'ui_kit.dart';

class PredictionsScreen extends StatefulWidget {
  const PredictionsScreen({super.key});

  @override
  State<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  DateTime? _dob;
  int _year = DateTime.now().year;
  int _years = 10;
  bool _hindi = false;

  Widget _monthGrid(DateTime dob) {
    final h = _hindi;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.85,
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
                  h ? ReportText.monthsHi[m - 1] : monthName(m),
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
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
                const SizedBox(height: 2),
                Text(
                  ReportText
                          .monthWord[NumerologyTools.personalMonth(dob, _year, m)]
                          ?.t(h) ??
                      '',
                  style: const TextStyle(fontSize: 10.5),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _yearCard(DateTime dob, int y) {
    final h = _hindi;
    final py = NumerologyTools.personalYear(dob, y);
    final ys = ReportText.years[py] ?? ReportText.years[1]!;
    final ar = ReportText.yearAreas[py] ?? ReportText.yearAreas[1]!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GoldCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NumberBadge(py, size: 52),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$y',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AnkdharaColors.gold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        ys.title.t(h),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              ys.story.t(h),
              style: const TextStyle(fontSize: 14.5, height: 1.5),
            ),
            const SizedBox(height: 8),
            Container(height: 1, color: AnkdharaColors.goldLine),
            InfoRow(Icons.work_outline, ReportText.careerTitle.t(h), ar.work.t(h)),
            InfoRow(Icons.savings_outlined, ReportText.moneyTitle.t(h), ar.money.t(h)),
            InfoRow(Icons.favorite_border, ReportText.loveTitle.t(h), ar.love.t(h)),
            InfoRow(Icons.flag_outlined, ReportText.doLabel.t(h), ys.doThis.t(h)),
            InfoRow(Icons.warning_amber_rounded, ReportText.takeCareLabel.t(h),
                ys.avoid.t(h)),
          ],
        ),
      ),
    );
  }

  Widget _controls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<bool>(
            segments: const [
              ButtonSegment<bool>(value: false, label: Text('English')),
              ButtonSegment<bool>(value: true, label: Text('हिन्दी')),
            ],
            selected: {_hindi},
            onSelectionChanged: (v) => setState(() => _hindi = v.first),
          ),
        ),
        const SectionLabel('How many years to read'),
        Row(
          children: [
            IconButton(
              onPressed: _years > 1 ? () => setState(() => _years--) : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '$_years years',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _years < 50 ? () => setState(() => _years++) : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: [
            for (final n in [5, 10, 15, 20, 30])
              ChoiceChip(
                label: Text('$n'),
                selected: _years == n,
                onSelected: (_) => setState(() => _years = n),
              ),
          ],
        ),
      ],
    );
  }

  Widget _result(DateTime dob) {
    final h = _hindi;
    final nowMonth = DateTime.now().month;
    final thisYear = DateTime.now().year;
    final pm = NumerologyTools.personalMonth(dob, _year, nowMonth);

    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_year == thisYear) ...[
            const SectionLabel('This month'),
            GoldCard(
              child: Row(
                children: [
                  NumberBadge(pm, size: 48),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      h
                          ? 'इस महीने का अंक $pm है: '
                              '${ReportText.monthWord[pm]?.t(true) ?? ''}।'
                          : 'Personal Month $pm. ${NumerologyTools.monthHints[pm]}',
                      style: const TextStyle(fontSize: 14.5, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SectionLabel('Month by month in $_year'),
          _monthGrid(dob),
          SectionLabel('Next $_years years, from $_year'),
          for (var y = _year; y < _year + _years; y++) _yearCard(dob, y),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ReportBuilderScreen(
                    initialDob: dob,
                    initialYears: _years,
                  ),
                ),
              ),
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: Text('Make a PDF report with $_years years'),
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
        _controls(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _year > 1950 ? () => setState(() => _year--) : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Text(
              'Start year: $_year',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
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
