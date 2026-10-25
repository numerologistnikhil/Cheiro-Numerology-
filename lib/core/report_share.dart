import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// Print / save / share for a report that is already created.
/// Nothing is uploaded anywhere: the PDF stays on the phone and goes
/// out only when the user chooses an app in the Android share sheet.
class ReportShare {
  ReportShare._();

  /// Opens the print screen. "Save as PDF" there = download.
  static Future<void> printPdf(Uint8List bytes) async {
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }

  /// Opens the Android share sheet with the PDF attached.
  /// The user picks WhatsApp (or any app) and the contact there.
  static Future<void> sharePdf(Uint8List bytes, String customerName) async {
    final dir = await getTemporaryDirectory();
    await _cleanOld(dir);
    final safe = customerName
        .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
    final fileName = 'Ankdhara_${safe.isEmpty ? 'Report' : safe}.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    await Share.shareXFiles(
      [XFile(file.path, mimeType: 'application/pdf')],
      subject: 'Ank Dhara numerology report',
    );
  }

  /// Removes older shared reports from the private temp folder.
  static Future<void> _cleanOld(Directory dir) async {
    try {
      await for (final e in dir.list()) {
        if (e is File) {
          final name = e.uri.pathSegments.last;
          if (name.startsWith('Ankdhara_') && name.endsWith('.pdf')) {
            await e.delete();
          }
        }
      }
    } catch (_) {
      // Cleanup is best effort only.
    }
  }
}
