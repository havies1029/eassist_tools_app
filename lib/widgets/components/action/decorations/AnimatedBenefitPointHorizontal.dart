
// Widget baru untuk desktop layout horizontal
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedBenefitPointHorizontal extends StatefulWidget {
  final IconData icon;
  final String text;
  final Duration delay;

  const AnimatedBenefitPointHorizontal({
    super.key,
    required this.icon,
    required this.text,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedBenefitPointHorizontal> createState() => _AnimatedBenefitPointHorizontalState();
}

class _AnimatedBenefitPointHorizontalState extends State<AnimatedBenefitPointHorizontal>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // background putih
                    borderRadius: BorderRadius.circular(16.13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // shadow lembut
                        blurRadius: 8.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: const Color(0xFF79AB43), // warna ikon sesuai kebutuhan
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Satoshi-Regular',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}