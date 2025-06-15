import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import '../../repositories/user/user_repository.dart';
import '../../widgets/section/about/PencapaianAbout.dart';
import '../../widgets/section/homepage/hero_section_heropage.dart';
import '../../widgets/components/action/action_section.dart';
import '../../widgets/components/carousel/carousel_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';
import '../../widgets/components/feature/feature_section.dart';
import '../../widgets/components/floating_button/floating_buttons.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/testimoni/testimonial_section.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fixed_navbar_overlay.dart';

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
                    child: Builder(
                      builder: (context) {
                        final state = context.read<AuthenticationBloc>().state;
                        String name = "[Nama User]";
                        if (state is AuthenticationAuthenticated &&
                            state.user.custType == "C") {
                          name = state.user.nama ?? "[Nama User]";
                        }

                        return Text(
                          "Selamat datang, $name",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
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
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                              if (state is AuthenticationAuthenticated) {
                                if (state.user.custType == "C") {
                                  return Text(
                                      'Username : ${state.user.username ?? "???"}');
                                }
                              }
                              return Container();
                            }),
                        HeroSection(constraints: constraints),
                        FloatingButtons(constraints: constraints),
                        ActionSection(constraints: constraints),
                        PencapaianSection(constraints: constraints),
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
