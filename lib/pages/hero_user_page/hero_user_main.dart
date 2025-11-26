import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../../repositories/user/user_repository.dart';
import '../../widgets/section/action_section.dart';
import '../../widgets/section/navbar/navbar_widget.dart';
import '../profile/profile_main_page.dart';
import '../../widgets/section/carousel_section.dart';
import '../../widgets/section/client_section.dart';
import '../../widgets/section/feature_section.dart';
import 'floating_buttons_user.dart';
import '../../widgets/section/footer_section.dart';
import 'hero_section_heropage.dart';
import '../../widgets/section/testimonial_section.dart';

class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

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
          bodyMedium: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 16.0,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
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
          return Stack(
            children: [
              // Layer 1: Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/home_3.jpg',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 3),
                  cacheWidth: 1440,
                  cacheHeight: 800,
                ),
              ),

              // Layer 2: Scrollable content (tanpa navbar)
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 88), // space for navbar
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

              // Layer 3: Always-on-top Navbar with overlay support
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
        clipBehavior: Clip.none, // ini penting agar pop-up bisa muncul di luar batas
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
