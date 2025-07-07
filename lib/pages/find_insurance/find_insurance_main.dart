import 'package:flutter/material.dart';

import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/signature_joss_page/find_insurance/paragraf_about.dart';
import '../../widgets/section/signature_joss_page/find_insurance/action_find_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../base/base_page.dart';

class FindInsuranceMain extends StatelessWidget {
  const FindInsuranceMain({super.key});

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
      home: const FindInsurancePage(),
    );
  }
}

class FindInsurancePage extends StatefulWidget {
  const FindInsurancePage({super.key});

  @override
  State<FindInsurancePage> createState() => _FindInsurancePageState();
}

class _FindInsurancePageState extends State<FindInsurancePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;
          return Stack(
            children: [
              // Layer 1: Background Image
              Positioned.fill(
                child: isMobile
                    ? Container(color: const Color(0xFF79AB43))
                    : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/home_3.jpg',
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, 3),
                      cacheWidth: 1440,
                      cacheHeight: 800,
                    ),
                    // Overlay gradient
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black54, // paling kiri
                            Colors.black26, // tengah kiri
                            Colors.transparent, // kanan (transparan)
                          ],
                          stops: [0.0, 0.5, 0.9], // atur area gelapnya
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Layer 2: Scrollable content (tanpa navbar)
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 88), // space for navbar
                  child: Column(
                    children: [
                      HeroSection(constraints: constraints,
                          sectionType: SectionType.find_insurance),
                      FloatingButtons(constraints: constraints),
                      ActionSection(constraints: constraints),
                      JPSInsuranceSection(constraints: constraints),
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
              pageType: PageType.findinsurance,
            ),
          ),
        ],
      ),
    );
  }
}
