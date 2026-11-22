import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../core/app.dart';

/// A white page to sign on with a finger or a stylus. When the person taps
/// "Use this signature", the drawing is returned as PNG bytes, ready for the
/// same analysis as a photographed signature.
class SignaturePadScreen extends StatefulWidget {
  const SignaturePadScreen({super.key});

  @override
  State<SignaturePadScreen> createState() => _SignaturePadScreenState();
}

class _SignaturePadScreenState extends State<SignaturePadScreen> {
  final List<List<Offset>> _strokes = [];
  Size _size = const Size(300, 300);
  bool _saving = false;

  static const double _pen = 3.2;

  void _paintStrokes(Canvas c, double scale) {
    final p = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = _pen * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    for (final s in _strokes) {
      if (s.length == 1) {
        c.drawCircle(s.first * scale, _pen * scale / 2,
            Paint()..color = Colors.black);
        continue;
      }
      final path = Path()..moveTo(s.first.dx * scale, s.first.dy * scale);
      for (var i = 1; i < s.length; i++) {
        path.lineTo(s[i].dx * scale, s[i].dy * scale);
      }
      c.drawPath(path, p);
    }
  }

  Future<void> _use() async {
    if (_strokes.isEmpty || _saving) return;
    setState(() => _saving = true);
    try {
      const scale = 2.0;
      final w = (_size.width * scale).round();
      final h = (_size.height * scale).round();
      final rec = ui.PictureRecorder();
      final c = Canvas(rec);
      c.drawRect(Rect.fromLTWH(0, 0, w.toDouble(), h.toDouble()),
          Paint()..color = Colors.white);
      _paintStrokes(c, scale);
      final image = await rec.endRecording().toImage(w, h);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (!mounted) return;
      if (data == null) {
        setState(() => _saving = false);
        return;
      }
      Navigator.pop<Uint8List>(context, data.buffer.asUint8List());
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hi = AppLang.of(context).hindi;
    return Scaffold(
      appBar: AppBar(title: Text(hi ? 'यहाँ हस्ताक्षर कीजिए' : 'Sign here')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                hi
                    ? 'उँगली या स्टाइलस से वैसे ही हस्ताक्षर कीजिए जैसे आप काग़ज़ पर करते हैं। बीच में उँगली न हटाएँ तो वही जुड़ी हुई रेखा बनेगी जो आपकी आदत है।'
                    : 'Sign with your finger or a stylus the way you sign on paper. Keep your normal speed and size.',
                style: const TextStyle(height: 1.4),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: LayoutBuilder(builder: (context, box) {
                  _size = Size(box.maxWidth, box.maxHeight);
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (d) =>
                          setState(() => _strokes.add([d.localPosition])),
                      onPanUpdate: (d) => setState(() {
                        if (_strokes.isNotEmpty) {
                          _strokes.last.add(d.localPosition);
                        }
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFB8860B), width: 1.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: CustomPaint(
                          painter: _PadPainter(_strokes, _pen),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _strokes.isEmpty
                          ? null
                          : () => setState(() => _strokes.removeLast()),
                      icon: const Icon(Icons.undo),
                      label: Text(hi ? 'पिछली रेखा हटाएँ' : 'Undo'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          _strokes.isEmpty ? null : () => setState(_strokes.clear),
                      icon: const Icon(Icons.delete_outline),
                      label: Text(hi ? 'साफ़ कीजिए' : 'Clear'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: _strokes.isEmpty || _saving ? null : _use,
                child: Text(hi ? 'यह हस्ताक्षर इस्तेमाल कीजिए' : 'Use this signature'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PadPainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final double pen;
  _PadPainter(this.strokes, this.pen);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = pen
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    for (final s in strokes) {
      if (s.length == 1) {
        canvas.drawCircle(s.first, pen / 2, Paint()..color = Colors.black);
        continue;
      }
      final path = Path()..moveTo(s.first.dx, s.first.dy);
      for (var i = 1; i < s.length; i++) {
        path.lineTo(s[i].dx, s[i].dy);
      }
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant _PadPainter old) => true;
}
