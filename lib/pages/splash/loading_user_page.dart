import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../hero_client_page/hero_user_main.dart';
import '../heropage/hero_main.dart';

class LoadingUserPage extends StatefulWidget {
  const LoadingUserPage({super.key});

  @override
  State<LoadingUserPage> createState() => _LoadingUserPageState();
}

class _LoadingUserPageState extends State<LoadingUserPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Simulasi loading + render halaman hero_user di background
    Future.delayed(const Duration(seconds: 2), () async {
      // Kamu bisa siapkan API call atau data apapun di sini
      // await someInitFunction();

      // Pindah ke halaman utama user
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HeroMain()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildRotatingSvg(double size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: SvgPicture.asset(
        'assets/images/loading2.svg',
        width: size,
        height: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;
    final svgSize = isDesktop ? 200.0 : 100.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _buildRotatingSvg(svgSize),
      ),
    );
  }
}
