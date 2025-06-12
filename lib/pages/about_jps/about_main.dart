import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../../repositories/user/user_repository.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/PencapaianAbout.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/section/about/action_about_section.dart';
import '../../widgets/section/about/jps_intro_description_section.dart';
import '../../widgets/section/about/visi_section.dart';
import '../../widgets/section/about/value_section.dart';
import '../../widgets/section/about/peran_section.dart';
import '../../widgets/section/about/management_profile_section.dart';
import '../../widgets/section/about/artikel_card.dart';
import '../../widgets/section/testimoni/testimonial_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';

// ========================
// Dummy Repository (API placeholder)
// ========================
class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

class AboutMain extends StatelessWidget {
  const AboutMain({super.key});

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
            fontSize: 16.0,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF79AB43),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const AboutPage(),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = MediaQuery.of(context).size.width < 768;

          return Stack(
            children: [
              // Layer 1: Background Image
              Positioned.fill(
                child: _buildBackgroundImage(constraints),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),

              // Layer 2: Scrollable content (tanpa navbar)
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: isMobile? 65 : 88),
                  child: Column(
                    children: [
                      HeroSection(constraints: constraints,
                          pageType: PageType.about),
                      FloatingButtons(constraints: constraints),
                      ActionSection(constraints: constraints),
                      AboutJps(constraints: constraints),
                      VisiSection(constraints: constraints),
                      PeranJpsSection(constraints: constraints),
                      ValueSection(constraints: constraints),
                      PencapaianSection(constraints: constraints),
                      ManagementProfileSection(constraints: constraints),
                      ArtikelCard(constraints: constraints),
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

Widget _buildBackgroundImage(BoxConstraints constraints) {
  final bool isMobile = constraints.maxWidth < 768;

  return Image.asset(
    'assets/images/about_jps.png',
    fit: isMobile? BoxFit.fitHeight: BoxFit.cover,
    alignment: isMobile ? Alignment.topCenter : const Alignment(0, 3),
    cacheWidth: isMobile ? 720 : 1440,
    cacheHeight: isMobile ? 960 : 800,
  );
}