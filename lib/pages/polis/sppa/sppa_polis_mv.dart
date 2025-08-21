import 'package:flutter/material.dart';

import '../../../widgets/section/polis/real_polis/sppa_mv/sppa_mv_page.dart';
import '../../../widgets/section/polis/simul_polis/simul_mv/simul_mv_page.dart';
import '../../../widgets/section/polis/simul_polis/simul_par/simul_par_page.dart';
import '../../../widgets/section/signature_joss_page/report_claim/jps_user/action_report_user_section.dart';
import '../../../widgets/components/navbar/navbar_widget.dart';
import '../../../widgets/section/about/floating_buttons_about.dart';
import '../../../widgets/components/footer/footer_section.dart';
import '../../base/base_page.dart';

class SppaPolisMvMain extends StatelessWidget {
  const SppaPolisMvMain({super.key});

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
      home: const SppaPolisMvPage(),
    );
  }
}

class SppaPolisMvPage extends StatefulWidget {
  const SppaPolisMvPage({super.key});

  @override
  State<SppaPolisMvPage> createState() => _SppaPolisMvPageState();
}

class _SppaPolisMvPageState extends State<SppaPolisMvPage> {
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
          final isMobile = MediaQuery.of(context).size.width < 768;

          return Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: isMobile ? 52 : 62),
                  child: Column(
                    children: [
                      SppaMvPage(),
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