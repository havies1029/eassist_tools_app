import 'package:flutter/material.dart';

import '../../../widgets/section/polis/simul_polis/simul_par/simul_par_page.dart';
import '../../../widgets/section/signature_joss_page/report_claim/jps_user/action_report_user_section.dart';
import '../../../widgets/components/navbar/navbar_widget.dart';
import '../../../widgets/section/about/floating_buttons_about.dart';
import '../../../widgets/components/footer/footer_section.dart';
import '../../base/base_page.dart';

class SimulPolisParMain extends StatelessWidget {
  const SimulPolisParMain({super.key});

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
      home: const SimulPolisParPagePage(),
    );
  }
}

class SimulPolisParPagePage extends StatefulWidget {
  const SimulPolisParPagePage({super.key});

  @override
  State<SimulPolisParPagePage> createState() => _SimulPolisParPagePageState();
}

class _SimulPolisParPagePageState extends State<SimulPolisParPagePage> {
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
                      SimulParPage(),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),

              // Layer 3: Navbar tetap di atas
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
              pageType: PageType.sppamv,
            ),
          ),
        ],
      ),
    );
  }
}
