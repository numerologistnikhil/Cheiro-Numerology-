import 'package:flutter/material.dart';
import 'premium_home.dart';

/// Animated Ankdhara splash:
/// 1) logo fade + zoom in, 2) golden shimmer, 3) logo shrinks, floats up and
/// fades away into the Home screen. Tap anywhere to skip.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  bool _gone = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    );
    _c.forward().whenComplete(_goHome);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _goHome() {
    if (_gone || !mounted) return;
    _gone = true;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondary) => const PremiumHome(),
        transitionsBuilder: (context, animation, secondary, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  static double _seg(double t, double a, double b) =>
      ((t - a) / (b - a)).clamp(0.0, 1.0).toDouble();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoWidth = size.width * 0.8 > 360 ? 360.0 : size.width * 0.8;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF4E2),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _goHome,
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            final t = _c.value;
            final fadeIn = Curves.easeOut.transform(_seg(t, 0.0, 0.28));
            final zoomIn = Curves.easeOutBack.transform(_seg(t, 0.0, 0.34));
            final shimmer = _seg(t, 0.30, 0.68);
            final out = Curves.easeInOutCubic.transform(_seg(t, 0.72, 1.0));

            final scale = (0.75 + 0.25 * zoomIn) * (1 - 0.7 * out);
            final dy = -out * size.height * 0.36;
            final opacity = fadeIn * (1 - out);

            return Center(
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0).toDouble(),
                child: Transform.translate(
                  offset: Offset(0, dy),
                  child: Transform.scale(
                    scale: scale,
                    child: ShaderMask(
                      blendMode: BlendMode.srcATop,
                      shaderCallback: (rect) => LinearGradient(
                        begin: Alignment(-1.6 + 3.2 * shimmer, -0.4),
                        end: Alignment(-0.6 + 3.2 * shimmer, 0.4),
                        colors: const [
                          Color(0x00FFFFFF),
                          Color(0xAAFFFFFF),
                          Color(0x00FFFFFF),
                        ],
                        stops: const [0.30, 0.5, 0.70],
                      ).createShader(rect),
                      child: Image.asset(
                        'assets/images/ankdhara_logo.png',
                        width: logoWidth,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
