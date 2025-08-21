import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/signature_joss_page/report_claim/non_jps_user/action_report_non_user_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../base/base_page.dart';

class UserNonJpsMain extends StatelessWidget {
  const UserNonJpsMain({super.key});

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
      home: const UserNonJpsPage(),
    );
  }
}

class UserNonJpsPage extends StatefulWidget {
  const UserNonJpsPage({super.key});

  @override
  State<UserNonJpsPage> createState() => _UserNonJpsPageState();
}

class _UserNonJpsPageState extends State<UserNonJpsPage> {
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
                      HeroSection(constraints: constraints,
                          sectionType: SectionType.report_claim),
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