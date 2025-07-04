import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../hero_client_page/hero_user_main.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late final AnimationController _orbitController;
  late final AnimationController _fadeController;
  late final AnimationController _progressController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // Orbit animation - planets rotating around center
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Fade animation for text
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Progress animation
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    // Start progress animation
    _progressController.forward();

    // // Simulasi loading + render halaman hero_user di background
    // Future.delayed(const Duration(seconds: 4), () async {
    //   if (mounted) {
    //     SchedulerBinding.instance.addPostFrameCallback((_) {
    //       context.read<HomeBloc>().add(HeroUserPageActiveEvent());
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _fadeController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  Widget _buildCenterSun(double size) {
    return Container(
      width: size * 0.2,
      height: size * 0.2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade400.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Colors.green.shade400.withOpacity(0.2),
            blurRadius: 25,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/jps-image.png',
          width: size * 0.2,
          height: size * 0.2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOrbitingPlanet({
    required double orbitRadius,
    required double planetSize,
    required Color planetColor,
    required double speed,
    required double offset,
  }) {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (_, child) {
        final angle = (_orbitController.value * speed + offset) * 2 * math.pi;
        final x = orbitRadius * math.cos(angle);
        final y = orbitRadius * math.sin(angle);

        return Transform.translate(
          offset: Offset(x, y),
          child: Container(
            width: planetSize,
            height: planetSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  planetColor.withOpacity(0.7),
                  planetColor,
                  planetColor.withOpacity(0.8),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: planetColor.withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrbitPath(double radius) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.shade300.withOpacity(0.3),
          width: 1,
        ),
      ),
    );
  }

  Widget _buildSolarSystem(double size) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Orbit paths
          _buildOrbitPath(size * 0.2),
          _buildOrbitPath(size * 0.3),
          _buildOrbitPath(size * 0.4),
          _buildOrbitPath(size * 0.5),

          // Planets
          _buildOrbitingPlanet(
            orbitRadius: size * 0.2,
            planetSize: size * 0.03,
            planetColor: Colors.green.shade400,
            speed: 2.0,
            offset: 0.0,
          ),
          _buildOrbitingPlanet(
            orbitRadius: size * 0.3,
            planetSize: size * 0.025,
            planetColor: Colors.blue.shade400,
            speed: 1.5,
            offset: 0.3,
          ),
          _buildOrbitingPlanet(
            orbitRadius: size * 0.4,
            planetSize: size * 0.035,
            planetColor: Colors.green.shade600,
            speed: 1.0,
            offset: 0.7,
          ),
          _buildOrbitingPlanet(
            orbitRadius: size * 0.5,
            planetSize: size * 0.02,
            planetColor: Colors.teal.shade400,
            speed: 0.7,
            offset: 0.5,
          ),

          // Center Sun (JPS)
          _buildCenterSun(size),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double width) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (_, child) {
        return Container(
          width: width,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.grey.shade200,
          ),
          child: Stack(
            children: [
              Container(
                width: width * _progressAnimation.value,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade400,
                      Colors.green.shade600,
                      Colors.orange.shade400,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade400.withOpacity(0.4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingText() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (_, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            children: [
              Text(
                'JPS System',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingPercentage() {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (_, child) {
        final percentage = (_progressAnimation.value * 100).toInt();
        return Text(
          '$percentage%',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 800;
    final systemSize = isDesktop ? 300.0 : 200.0;
    final progressWidth = isDesktop ? 280.0 : 180.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Colors.orange.shade50.withOpacity(0.3),
              Colors.white,
              Colors.green.shade50.withOpacity(0.2),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Solar System
              _buildSolarSystem(systemSize),

              const SizedBox(height: 50),

              // Loading text
              _buildLoadingText(),

              const SizedBox(height: 30),

              // Progress bar
              _buildProgressBar(progressWidth),

              const SizedBox(height: 15),

              // Percentage
              _buildLoadingPercentage(),

              const SizedBox(height: 30),

              // Subtitle
              Text(
                'Protect your future with JPS. © 2025 JPS Insurance Platform.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}