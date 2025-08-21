import 'package:eassist_tools_app/pages/base/base_page.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/active_assets/action_active_assets_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/components/footer/footer_section.dart';

class ActiveAssetMain extends StatelessWidget {
  const ActiveAssetMain({super.key});

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
      home: const ActiveAssetPage(),
    );
  }
}

class ActiveAssetPage extends StatefulWidget {
  const ActiveAssetPage({super.key});

  @override
  State<ActiveAssetPage> createState() => _ActiveAssetPageState();
}

class _ActiveAssetPageState extends State<ActiveAssetPage> {
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
                    ? Container(color: kBrandPrimaryColor)
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
                          sectionType: SectionType.active_asset),
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