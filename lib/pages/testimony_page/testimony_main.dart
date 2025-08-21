import 'package:flutter/material.dart';
import '../../common/constants.dart';
import '../../repositories/user/user_repository.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/testimoni/testimonial_page.dart';
import '../base/base_page.dart';

class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

class TestimonyMain extends StatelessWidget {
  const TestimonyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPS Insurance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kBrandPrimaryColor,
        scaffoldBackgroundColor: kBrandLightColor,
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
          buttonColor: kBrandPrimaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const TestimonyPage(),
    );
  }
}

class TestimonyPage extends StatelessWidget {
  const TestimonyPage({super.key});

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
                child: Image.asset(
                  'assets/images/article_3.png',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 3),
                  cacheWidth: 1440,
                  cacheHeight: 800,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),

              // Layer 2: Scrollable content (tanpa navbar)
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 88), // space for navbar
                  child: Column(
                    children: [
                      HeroSection(constraints: constraints,
                          sectionType: SectionType.testimony),
                      FloatingButtons(constraints: constraints),
                      ActionSection(constraints: constraints),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}