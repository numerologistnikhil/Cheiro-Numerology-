import 'package:flutter/material.dart';
import '../core/app.dart';
import '../core/numerology_tools.dart';
import 'ui_kit.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Learn Numerology',
      children: [
        const SectionLabel('Lessons'),
        for (final l in NumerologyTools.lessons)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 18),
                  childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                  iconColor: AnkdharaColors.gold,
                  collapsedIconColor: AnkdharaColors.gold,
                  title: Text(
                    l.title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l.body,
                        style: const TextStyle(fontSize: 14.5, height: 1.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SectionLabel('Test yourself'),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizScreen()),
            ),
            icon: const Icon(Icons.quiz_outlined),
            label: Text('Start Quiz (${NumerologyTools.quiz.length} questions)'),
          ),
        ),
      ],
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;
  int _score = 0;
  int? _picked;

  List<QuizQuestion> get _qs => NumerologyTools.quiz;

  void _pick(int i) {
    if (_picked != null) return;
    setState(() {
      _picked = i;
      if (i == _qs[_index].answer) _score++;
    });
  }

  void _next() {
    setState(() {
      _index++;
      _picked = null;
    });
  }

  void _restart() {
    setState(() {
      _index = 0;
      _score = 0;
      _picked = null;
    });
  }

  Widget _finished() {
    final total = _qs.length;
    String msg;
    if (_score >= total * 0.8) {
      msg = 'Excellent. You know your basics well.';
    } else if (_score >= total * 0.5) {
      msg = 'Good effort. Revisit the lessons and try again.';
    } else {
      msg = 'A good start. Read the lessons once more and retry.';
    }
    return PageShell(
      title: 'Quiz Result',
      children: [
        const SizedBox(height: 20),
        Center(child: NumberBadge(_score, size: 90)),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'You scored $_score out of $total',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8),
        Center(child: Text(msg, textAlign: TextAlign.center)),
        const SizedBox(height: 24),
        FilledButton(onPressed: _restart, child: const Text('Try Again')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_index >= _qs.length) return _finished();
    final q = _qs[_index];
    final picked = _picked;
    return PageShell(
      title: 'Quiz',
      children: [
        Text(
          'Question ${_index + 1} of ${_qs.length}',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AnkdharaColors.gold,
          ),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: (_index + 1) / _qs.length,
          color: AnkdharaColors.gold,
          backgroundColor: AnkdharaColors.cream,
          minHeight: 6,
        ),
        const SizedBox(height: 20),
        Text(q.question, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        for (var i = 0; i < q.options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: picked == null
                  ? Colors.white
                  : (i == q.answer
                      ? const Color(0xFFDDEFD9)
                      : (i == picked
                          ? const Color(0xFFF6D9D6)
                          : Colors.white)),
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _pick(i),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AnkdharaColors.goldLine),
                  ),
                  child: Text(q.options[i], style: const TextStyle(fontSize: 15.5)),
                ),
              ),
            ),
          ),
        if (picked != null) ...[
          const SizedBox(height: 6),
          Text(
            picked == q.answer ? 'Correct. ${q.explanation}' : 'Not quite. ${q.explanation}',
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _next,
            child: Text(_index == _qs.length - 1 ? 'See Result' : 'Next'),
          ),
        ],
      ],
    );
  }
}
