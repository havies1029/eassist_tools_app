import 'package:flutter/material.dart';
import 'dart:async';
import 'animation_helper.dart'; // Pastikan path file helper sudah benar

/// SplashScreen yang dapat digunakan ulang.
/// [imageAsset] -> path gambar/logo yang ingin ditampilkan.
/// [animationDuration] -> durasi animasi.
/// [onFinish] -> callback yang akan dipanggil setelah animasi selesai.
class SplashScreen extends StatefulWidget {
  final String imageAsset;
  final Duration animationDuration;
  final VoidCallback? onFinish;

  const SplashScreen({
    Key? key,
    required this.imageAsset,
    this.animationDuration = const Duration(seconds: 3),
    this.onFinish,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Buat AnimationController menggunakan helper
    _controller = createAnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    // Inisialisasi animasi-animasi
    _logoScaleAnimation = createScaleAnimation(_controller);
    _textFadeAnimation = createFadeAnimation(_controller);
    _progressAnimation = createProgressAnimation(_controller);

    // Jika animasi telah selesai, panggil callback onFinish (dengan sedikit delay agar transisi terasa halus)
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (widget.onFinish != null) widget.onFinish!();
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ubah sesuai kebutuhan
      body: SafeArea(
        child: Stack(
          children: [
            // Logo dengan animasi ScaleTransition
            Center(
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: Image.asset(
                  widget.imageAsset,
                  width: 120,
                  height: 120,
                ),
              ),
            ),

            // Bagian bawah: teks dan progress bar dengan FadeTransition
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _textFadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 48.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Contoh teks "JPS Calculator" dengan gradient
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GradientText(
                            'JPS ',
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF80B244),
                                Color(0xFF3C592C),
                              ],
                            ),
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GradientText(
                            'Calculator',
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFFEBA2B),
                                Color(0xFFF57933),
                              ],
                            ),
                            style: const TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Progress bar dengan animasi value
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                              value: _progressAnimation.value,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget untuk menampilkan teks dengan gradient.
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(
      this.text, {
        Key? key,
        required this.gradient,
        required this.style,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
