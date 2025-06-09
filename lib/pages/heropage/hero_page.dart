import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/pages/about_jps/action_about_section.dart';
import 'package:eassist_tools_app/pages/find_insurance/find_section_insurance.dart';
import 'package:eassist_tools_app/pages/find_insurance/floating_buttons_insurance.dart';
import 'package:eassist_tools_app/pages/heropage/fixed_nambar_overlay.dart';
import 'package:eassist_tools_app/widgets/section/carousel_section.dart';
import 'package:eassist_tools_app/widgets/section/client_section.dart';
import 'package:eassist_tools_app/widgets/section/feature_section.dart';
import 'package:eassist_tools_app/widgets/section/footer_section.dart';
import 'package:eassist_tools_app/widgets/section/testimonial_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  @override
  void initState() {
    super.initState();

    /*
    // Memastikan dialog dipanggil setelah frame pertama selesai dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomPopupsLoginUser.showLoginDialog(context);
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child:
                        Icon(Icons.check_circle_outline, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      "state is AuthenticationAuthenticated",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red[600],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.all(16),
              elevation: 3,
              duration: const Duration(seconds: 3),
            ));
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 768;
            return Stack(
              children: [
                // Layer 1: Background (Image untuk non-mobile, hijau untuk mobile)
                Positioned.fill(
                  child: isMobile
                      ? Container(
                          color: const Color(0xFF79AB43), // hijau full-screen
                        )
                      : Image.asset(
                          'assets/images/bg-home.jpg',
                          fit: BoxFit.cover,
                          alignment: const Alignment(0, 3),
                          cacheWidth: 1440,
                          cacheHeight: 800,
                        ),
                ),

                // Layer 2: Konten scrollable
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(top: 88), // ruang untuk navbar
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(LoggedOut());
                            },
                            child: Text("Logout",
                                style: TextStyle(
                                    color: Colors.white))),
                        TextButton(
                            onPressed: () {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(RequireRegisterClient());
                            },
                            child: Text("Register Client",
                                style: TextStyle(
                                    color: Colors.white))),
                        HeroSection(constraints: constraints),
                        FloatingButtons(constraints: constraints),
                        ActionSection(constraints: constraints),
                        CarouselSection(constraints: constraints),
                        FeatureSection(constraints: constraints),
                        TestimonialSection(constraints: constraints),
                        ClientSection(constraints: constraints),
                        FooterSection(constraints: constraints),
                      ],
                    ),
                  ),
                ),

                // Layer 3: Navbar overlay di atas semua
                const FixedNavbarOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }
}
