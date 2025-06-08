import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../../repositories/user/user_repository.dart';
import '../../widgets/content/action/action_section.dart';
import '../../widgets/section/navbar/navbar_widget.dart';
import '../../widgets/content/carousel/carousel_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';
import '../../widgets/content/feature/feature_section.dart';
import '../../widgets/section/homeclientpage/floating_buttons_user.dart';
import '../../widgets/section/footer/footer_section.dart';
import '../../widgets/section/homeclientpage/hero_section_heropage.dart';
import '../../widgets/section/testimoni/testimonial_section.dart';

class HeroUserMain extends StatelessWidget {
  const HeroUserMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPS Insurance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF79AB43),
        scaffoldBackgroundColor: const Color(0xFFD5F4B4),
        fontFamily: 'Satoshi-Regular',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0),
          titleLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF79AB43),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const HeroUserPage(),
    );
  }
}

class HeroUserPage extends StatelessWidget {
  const HeroUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = MediaQuery.of(context).size.width < 768;

          return Stack(
            children: [
              // Layer 1: Background
              Positioned.fill(
                child: isMobile
                    ? Container(color: const Color(0xFF79AB43))
                    : Image.asset(
                  'assets/images/home_3.jpg',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 3),
                  cacheWidth: 1440,
                  cacheHeight: 800,
                ),
              ),

              // Layer 2: Content Scroll
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 88),
                  child: Column(
                    children: [
                      HeroSection(constraints: constraints),
                      FloatingButtons(constraints: constraints),
                      ActionSection(constraints: constraints),
                      FeatureSection(constraints: constraints),
                      CarouselSection(constraints: constraints),
                      TestimonialSection(constraints: constraints),
                      ClientSection(constraints: constraints),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),

              // Layer 3: Navbar
              const _FixedNavbarOverlay(),
            ],
          );
        },
      ),
    );
  }
}

class _FixedNavbarOverlay extends StatelessWidget {
  const _FixedNavbarOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 20,
            child: NavbarWidget(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================
// === API or dynamic data section ===
// ============================

class DummyUserRepository extends UserRepository {
  // Override semua method jika diperlukan
  // Contoh:
  // @override
  // Future<User> getUser() async => User(id: 1, name: "Dummy");
}