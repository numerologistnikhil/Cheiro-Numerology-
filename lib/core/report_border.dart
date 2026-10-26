// Ank Dhara - page border drawing for the PDF report.
// Draws the chosen border style behind the content of every page.

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'report_options.dart';

class ReportBorder {
  ReportBorder._();

  static const double _edge = 22; // page ke kinare se doori

  /// Page ke peeche ka background (border). Rang int 0xAARRGGBB me.
  static pw.Widget background(BorderStyleOption b, int mainColor, int softColor) {
    if (b.kind == BorderKind.none) return pw.SizedBox();
    final w = PdfPageFormat.a4.width;
    final h = PdfPageFormat.a4.height;
    return pw.FullPage(
      ignoreMargins: true,
      child: pw.SizedBox(
        width: w,
        height: h,
        child: pw.CustomPaint(
          painter: (PdfGraphics g, PdfPoint size) {
            _paint(g, size, b, PdfColor.fromInt(mainColor), PdfColor.fromInt(softColor));
          },
        ),
      ),
    );
  }

  static void _setup(PdfGraphics g, PdfColor c, double width) {
    g.setStrokeColor(c);
    g.setLineWidth(width);
  }

  static void _rect(PdfGraphics g, PdfPoint s, double inset) {
    g.drawRect(inset, inset, s.x - 2 * inset, s.y - 2 * inset);
    g.strokePath();
  }

  static void _rrect(PdfGraphics g, PdfPoint s, double inset, double r) {
    g.drawRRect(inset, inset, s.x - 2 * inset, s.y - 2 * inset, r, r);
    g.strokePath();
  }

  static void _brackets(PdfGraphics g, PdfPoint s, double inset, double len) {
    final x0 = inset;
    final y0 = inset;
    final x1 = s.x - inset;
    final y1 = s.y - inset;
    // neeche-baayen
    g.moveTo(x0, y0 + len);
    g.lineTo(x0, y0);
    g.lineTo(x0 + len, y0);
    g.strokePath();
    // neeche-daayen
    g.moveTo(x1 - len, y0);
    g.lineTo(x1, y0);
    g.lineTo(x1, y0 + len);
    g.strokePath();
    // upar-daayen
    g.moveTo(x1, y1 - len);
    g.lineTo(x1, y1);
    g.lineTo(x1 - len, y1);
    g.strokePath();
    // upar-baayen
    g.moveTo(x0 + len, y1);
    g.lineTo(x0, y1);
    g.lineTo(x0, y1 - len);
    g.strokePath();
  }

  static void _dots(PdfGraphics g, PdfPoint s, double inset, double r, PdfColor c) {
    g.setFillColor(c);
    final xs = [inset, s.x - inset];
    final ys = [inset, s.y - inset];
    for (final x in xs) {
      for (final y in ys) {
        g.drawEllipse(x, y, r, r);
        g.fillPath();
      }
    }
  }

  static void _paint(PdfGraphics g, PdfPoint s, BorderStyleOption b, PdfColor main, PdfColor soft) {
    switch (b.kind) {
      case BorderKind.none:
        break;
      case BorderKind.single:
      case BorderKind.thick:
        _setup(g, main, b.outerWidth);
        _rect(g, s, _edge);
        break;
      case BorderKind.doubleLine:
        _setup(g, main, b.outerWidth);
        _rect(g, s, _edge);
        _setup(g, main, b.innerWidth);
        _rect(g, s, _edge + b.gap + b.outerWidth);
        break;
      case BorderKind.thinThick:
        _setup(g, main, b.outerWidth);
        _rect(g, s, _edge);
        _setup(g, soft, b.innerWidth);
        _rect(g, s, _edge + b.gap + b.outerWidth);
        break;
      case BorderKind.dashed:
        _setup(g, main, b.outerWidth);
        g.setLineDashPattern([7, 4]);
        _rect(g, s, _edge);
        g.setLineDashPattern();
        break;
      case BorderKind.dotted:
        _setup(g, main, b.outerWidth);
        g.setLineCap(PdfLineCap.round);
        g.setLineDashPattern([0.1, 5]);
        _rect(g, s, _edge);
        g.setLineDashPattern();
        g.setLineCap(PdfLineCap.butt);
        break;
      case BorderKind.rounded:
        _setup(g, main, b.outerWidth);
        _rrect(g, s, _edge, b.radius);
        break;
      case BorderKind.cornerBrackets:
        _setup(g, main, b.outerWidth);
        _brackets(g, s, _edge + 2, 40);
        _setup(g, soft, 0.6);
        _rect(g, s, _edge + 2);
        break;
      case BorderKind.ornamentCorners:
        _setup(g, main, b.outerWidth);
        _rect(g, s, _edge);
        _setup(g, soft, b.innerWidth);
        _rect(g, s, _edge + b.gap + 3);
        _dots(g, s, _edge, 4.5, main);
        break;
      case BorderKind.tripleLine:
        _setup(g, main, b.outerWidth);
        _rect(g, s, _edge);
        _setup(g, soft, b.innerWidth);
        _rect(g, s, _edge + b.gap + 2);
        _setup(g, main, b.innerWidth);
        _rect(g, s, _edge + 2 * b.gap + 4);
        break;
      case BorderKind.doubleRounded:
        _setup(g, main, b.outerWidth);
        _rrect(g, s, _edge, b.radius);
        _setup(g, soft, b.innerWidth);
        _rrect(g, s, _edge + b.gap + 3, b.radius - 3);
        break;
    }
  }
}
