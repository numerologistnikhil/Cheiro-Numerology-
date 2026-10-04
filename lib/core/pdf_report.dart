import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportBuilder {
  static Future<void> preview({required String name, required String summary}) async {
    final doc=pw.Document();
    doc.addPage(pw.Page(build:(_)=>pw.Column(children:[pw.Text('Cheiro Numerology',style:pw.TextStyle(fontSize:28,fontWeight:pw.FontWeight.bold)),pw.SizedBox(height:16),pw.Text(name,style:pw.TextStyle(fontSize:20)),pw.SizedBox(height:20),pw.Text('Disclaimer & Methodology'),pw.SizedBox(height:8),pw.Text('Numerology is a traditional interpretive system. This report is for educational and reflective purposes and does not guarantee outcomes.'),pw.SizedBox(height:20),pw.Text(summary),pw.Spacer(),pw.Text('Watermark: @NikhilVGulatii')]));
    await Printing.layoutPdf(onLayout:(_)=>doc.save());
  }
}
