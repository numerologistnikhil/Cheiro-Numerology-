import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// A picture turned into an ink mask (1 = ink, 0 = paper) plus a small JPEG
/// that can be shown and printed in the report.
class PreparedSignature {
  final List<int> ink;
  final int width;
  final int height;
  final Uint8List jpeg;
  const PreparedSignature(this.ink, this.width, this.height, this.jpeg);
}

class SignatureImage {
  /// Returns null when the bytes are not a readable picture.
  static PreparedSignature? prepare(Uint8List bytes) {
    img.Image? src;
    try {
      src = img.decodeImage(bytes);
    } catch (_) {
      src = null;
    }
    if (src == null) return null;
    var im = src;
    if (im.width > 640) im = img.copyResize(im, width: 640);
    final w = im.width, h = im.height;

    final lum = List<int>.filled(w * h, 255);
    final hist = List<int>.filled(256, 0);
    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        final p = im.getPixel(x, y);
        final a = p.a.toDouble();
        var v = (0.299 * p.r + 0.587 * p.g + 0.114 * p.b);
        // transparent pixels count as paper
        final maxA = p.maxChannelValue.toDouble();
        if (maxA > 0 && a < maxA * 0.5) v = p.maxChannelValue.toDouble();
        final l = (v * 255 / (p.maxChannelValue == 0 ? 255 : p.maxChannelValue)).round().clamp(0, 255).toInt();
        lum[y * w + x] = l;
        hist[l]++;
      }
    }

    // Otsu threshold
    final total = w * h;
    var sum = 0.0;
    for (var i = 0; i < 256; i++) {
      sum += i * hist[i];
    }
    var sumB = 0.0, wB = 0, best = 0.0, thr = 128;
    for (var t = 0; t < 256; t++) {
      wB += hist[t];
      if (wB == 0) continue;
      final wF = total - wB;
      if (wF == 0) break;
      sumB += t * hist[t];
      final mB = sumB / wB;
      final mF = (sum - sumB) / wF;
      final between = wB.toDouble() * wF * (mB - mF) * (mB - mF);
      if (between > best) {
        best = between;
        thr = t;
      }
    }

    var ink = List<int>.generate(w * h, (i) => lum[i] <= thr ? 1 : 0);
    var n = 0;
    for (final v in ink) {
      n += v;
    }
    // ink should be the minority; otherwise the picture is light on dark
    if (n > total * 0.5) {
      ink = ink.map((v) => v == 0 ? 1 : 0).toList();
    }
    final jpg = Uint8List.fromList(img.encodeJpg(im, quality: 85));
    return PreparedSignature(ink, w, h, jpg);
  }
}

/// Keeps the analysed signature for the PDF report (this session only).
class SignatureStore {
  SignatureStore._();
  static Uint8List? photo;
  static Object? reading; // SignatureReading, kept as Object to avoid cycles
  static String name = '';
  static bool include = false;

  static void clear() {
    photo = null;
    reading = null;
    name = '';
    include = false;
  }
}
