import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../../repositories/user/user_repository.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/customer_service/cs_section.dart';
import '../../widgets/section/customer_service/floating_buttons_cs.dart';
import '../../widgets/section/customer_service/action_section_cs.dart';
import '../../widgets/section/testimoni/testimonial_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';
import '../../widgets/components/footer/footer_section.dart';

class CSMain extends StatelessWidget {
  const CSMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPS Insurance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF79AB43),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Satoshi-Regular',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0),
          titleLarge: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF79AB43),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const CSPage(),
    );
  }
}

class CSPage extends StatelessWidget {
  const CSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              _buildBackground(constraints),
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 88),
                  child: Column(
                    children: [
                      CustomerServiceSection(constraints: constraints),
                      FloatingButtonsCS(constraints: constraints),
                      ActionSectionCS(constraints: constraints),
                      TestimonialSection(constraints: constraints),
                      ClientSection(constraints: constraints),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),
              const _FixedNavbarOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackground(BoxConstraints constraints) {
    final bool isMobile = constraints.maxWidth < 768;
    final double height = isMobile ? 500 : 400;

    return Positioned.fill(
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/cs_bg.png',
              fit: isMobile ? BoxFit.fitHeight : BoxFit.cover,
              alignment: const Alignment(0, 3),
              cacheWidth: 1440,
              cacheHeight: 900,
            ),
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ],
        ),
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
// 🔌 API / DUMMY REPOSITORY
// ============================

class DummyUserRepository extends UserRepository {
  // TODO: Implement real user fetching logic here
}