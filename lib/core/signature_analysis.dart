import 'dart:math' as math;

/// Measurements taken from a signature picture. All of them are plain
/// geometry (angles, ratios, counts) so they can be tested without a phone.
class SignatureMetrics {
  /// Lean of the strokes in degrees. Positive = leaning right.
  final double slantDeg;

  /// Direction of the signature line in degrees. Positive = rising to the right.
  final double baselineDeg;

  /// Width of the signature divided by its height.
  final double aspect;

  /// Ink covered, as a share of the signature's bounding box.
  final double density;

  /// Average stroke width divided by signature height.
  final double thickness;

  /// Separate pieces of ink (letters or groups of letters, ignoring specks).
  final int pieces;

  /// A long stroke under the name.
  final bool underline;

  /// A small dot or full stop after the name.
  final bool endDot;

  /// First letter much taller than the middle of the signature.
  final bool bigInitial;

  /// Where the end of the signature sits compared with its middle:
  /// positive = ends higher, negative = ends lower.
  final double endRise;

  const SignatureMetrics({
    required this.slantDeg,
    required this.baselineDeg,
    required this.aspect,
    required this.density,
    required this.thickness,
    required this.pieces,
    required this.underline,
    required this.endDot,
    required this.bigInitial,
    required this.endRise,
  });
}

/// Works on an ink mask: [ink] has w*h entries, 1 = ink, 0 = paper.
class SignatureAnalyzer {
  static SignatureMetrics? analyze(List<int> ink, int w, int h) {
    if (w <= 0 || h <= 0 || ink.length < w * h) return null;
    var minX = w, maxX = -1, minY = h, maxY = -1, count = 0;
    for (var y = 0; y < h; y++) {
      for (var x = 0; x < w; x++) {
        if (ink[y * w + x] != 0) {
          count++;
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    }
    if (count < 40 || maxX - minX < 8 || maxY - minY < 4) return null;
    final bw = maxX - minX + 1;
    final bh = maxY - minY + 1;

    // ---- slant: the shear that makes the strokes most upright
    final xs = <int>[];
    final ys = <int>[];
    final step = math.max(1, count ~/ 20000);
    var k = 0;
    for (var y = minY; y <= maxY; y++) {
      for (var x = minX; x <= maxX; x++) {
        if (ink[y * w + x] != 0) {
          if (k++ % step == 0) {
            xs.add(x - minX);
            ys.add(y - minY);
          }
        }
      }
    }
    final cy = bh / 2.0;
    var bestS = 0.0;
    var bestScore = -1.0;
    for (var si = -30; si <= 30; si++) {
      final s = si * 0.04;
      final off = (bh * 1.3).ceil() + 2;
      final bins = List<int>.filled(bw + 2 * off + 2, 0);
      for (var i = 0; i < xs.length; i++) {
        final xp = (xs[i] + s * (ys[i] - cy)).round() + off;
        if (xp >= 0 && xp < bins.length) bins[xp]++;
      }
      var score = 0.0;
      for (final b in bins) {
        score += b.toDouble() * b;
      }
      if (score > bestScore) {
        bestScore = score;
        bestS = s;
      }
    }
    final slant = math.atan(bestS) * 180 / math.pi;

    // ---- baseline: centre of ink in five vertical bands
    final bandX = <double>[];
    final bandY = <double>[];
    for (var b = 0; b < 5; b++) {
      final x0 = minX + (bw * b / 5).floor();
      final x1 = minX + (bw * (b + 1) / 5).floor();
      var sy = 0.0, n = 0;
      for (var y = minY; y <= maxY; y++) {
        for (var x = x0; x < x1; x++) {
          if (ink[y * w + x] != 0) {
            sy += y;
            n++;
          }
        }
      }
      if (n > 0) {
        bandX.add((x0 + x1) / 2);
        bandY.add(sy / n);
      }
    }
    var baseline = 0.0;
    if (bandX.length >= 3) {
      final mx = bandX.reduce((a, b) => a + b) / bandX.length;
      final my = bandY.reduce((a, b) => a + b) / bandY.length;
      var cov = 0.0, den = 0.0;
      for (var i = 0; i < bandX.length; i++) {
        cov += (bandX[i] - mx) * (bandY[i] - my);
        den += (bandX[i] - mx) * (bandX[i] - mx);
      }
      if (den > 0) {
        // image y grows downward, so a falling y means rising ink
        baseline = -math.atan(cov / den) * 180 / math.pi;
      }
    }

    // ---- stroke thickness: shorter of the horizontal and vertical run
    final hr = List<int>.filled(w * h, 0);
    final vr = List<int>.filled(w * h, 0);
    for (var y = minY; y <= maxY; y++) {
      var x = minX;
      while (x <= maxX) {
        if (ink[y * w + x] != 0) {
          var e = x;
          while (e <= maxX && ink[y * w + e] != 0) {
            e++;
          }
          for (var t = x; t < e; t++) {
            hr[y * w + t] = e - x;
          }
          x = e;
        } else {
          x++;
        }
      }
    }
    for (var x = minX; x <= maxX; x++) {
      var y = minY;
      while (y <= maxY) {
        if (ink[y * w + x] != 0) {
          var e = y;
          while (e <= maxY && ink[e * w + x] != 0) {
            e++;
          }
          for (var t = y; t < e; t++) {
            vr[t * w + x] = e - y;
          }
          y = e;
        } else {
          y++;
        }
      }
    }
    var wSum = 0.0;
    for (var y = minY; y <= maxY; y++) {
      for (var x = minX; x <= maxX; x++) {
        final i = y * w + x;
        if (ink[i] != 0) wSum += math.min(hr[i], vr[i]);
      }
    }
    final thickness = (wSum / count) / bh;

    // ---- connected pieces (8-neighbour)
    final label = List<int>.filled(w * h, 0);
    final sizes = <int>[];
    final boxes = <List<int>>[]; // minx, maxx, miny, maxy
    var next = 0;
    final stack = <int>[];
    for (var y = minY; y <= maxY; y++) {
      for (var x = minX; x <= maxX; x++) {
        final i = y * w + x;
        if (ink[i] == 0 || label[i] != 0) continue;
        next++;
        var size = 0;
        var bx0 = x, bx1 = x, by0 = y, by1 = y;
        stack.add(i);
        label[i] = next;
        while (stack.isNotEmpty) {
          final c = stack.removeLast();
          final cx = c % w, cyy = c ~/ w;
          size++;
          if (cx < bx0) bx0 = cx;
          if (cx > bx1) bx1 = cx;
          if (cyy < by0) by0 = cyy;
          if (cyy > by1) by1 = cyy;
          for (var dy = -1; dy <= 1; dy++) {
            for (var dx = -1; dx <= 1; dx++) {
              final nx = cx + dx, ny = cyy + dy;
              if (nx < minX || nx > maxX || ny < minY || ny > maxY) continue;
              final ni = ny * w + nx;
              if (ink[ni] != 0 && label[ni] == 0) {
                label[ni] = next;
                stack.add(ni);
              }
            }
          }
        }
        sizes.add(size);
        boxes.add([bx0, bx1, by0, by1]);
      }
    }
    var pieces = 0;
    var endDot = false;
    for (var i = 0; i < sizes.length; i++) {
      final big = sizes[i] >= count * 0.03;
      if (big) pieces++;
      final b = boxes[i];
      final small = sizes[i] < count * 0.03 && sizes[i] >= 6;
      final compact = (b[1] - b[0] + 1) <= bh * 0.25 && (b[3] - b[2] + 1) <= bh * 0.25;
      if (small && compact && b[0] >= minX + bw * 0.8) endDot = true;
    }
    if (pieces == 0) pieces = 1;

    // ---- underline: a long unbroken stroke in the lower half
    var underline = false;
    for (var y = minY + bh ~/ 2; y <= maxY && !underline; y++) {
      var run = 0, best = 0;
      for (var x = minX; x <= maxX; x++) {
        if (ink[y * w + x] != 0) {
          run++;
          if (run > best) best = run;
        } else {
          run = 0;
        }
      }
      if (best >= bw * 0.6 && bw > bh * 1.2) underline = true;
    }

    // ---- first letter height against the middle
    int zoneHeight(double a, double b) {
      final x0 = minX + (bw * a).floor();
      final x1 = minX + (bw * b).floor();
      var top = maxY + 1, bot = -1;
      for (var y = minY; y <= maxY; y++) {
        for (var x = x0; x < x1; x++) {
          if (ink[y * w + x] != 0) {
            if (y < top) top = y;
            if (y > bot) bot = y;
          }
        }
      }
      return bot < top ? 0 : bot - top + 1;
    }

    final first = zoneHeight(0.0, 0.18);
    final middle = zoneHeight(0.30, 0.75);
    final bigInitial = middle > 0 && first > middle * 1.45;

    // ---- where the end sits against the whole
    double centreY(double a, double b) {
      final x0 = minX + (bw * a).floor();
      final x1 = minX + (bw * b).floor();
      var s = 0.0, n = 0;
      for (var y = minY; y <= maxY; y++) {
        for (var x = x0; x < x1; x++) {
          if (ink[y * w + x] != 0) {
            s += y;
            n++;
          }
        }
      }
      return n == 0 ? (minY + maxY) / 2 : s / n;
    }

    final endRise = (centreY(0.0, 1.0) - centreY(0.85, 1.0)) / bh;

    return SignatureMetrics(
      slantDeg: slant,
      baselineDeg: baseline,
      aspect: bw / bh,
      density: count / (bw * bh),
      thickness: thickness,
      pieces: pieces,
      underline: underline,
      endDot: endDot,
      bigInitial: bigInitial,
      endRise: endRise,
    );
  }
}
