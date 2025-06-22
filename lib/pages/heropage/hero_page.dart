import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';

import '../../repositories/user/user_repository.dart';
import '../../widgets/account/login/login_gmail/popup_dialog_login.dart';
import '../../widgets/account/profile/profile_main_page.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/components/action/action_section.dart';
import '../../widgets/components/carousel/carousel_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';
import '../../widgets/components/feature/feature_section.dart';
import '../../widgets/components/floating_button/floating_buttons.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/testimoni/testimonial_section.dart';

import '../gen_profile/test_profile_page.dart';
import 'fixed_navbar_overlay.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MRekan1CrudBloc, MRekan1CrudState>(
        listener: (context, state) {
          final mjnsclientId = state.record?.mjnsclientId?.toString();
          if (!_dialogShown && (mjnsclientId == "10" || mjnsclientId == "20")) {
            _dialogShown = true;
            showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding: const EdgeInsets.all(32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SizedBox(
                  width: 1200,
                  child: ProfileMainPage(
                    userid: 123,
                    selectedChoice:
                    mjnsclientId == "10" ? 'Individual' : 'Perusahaan',
                  ),
                ),
              ),
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 768;

            // Trigger login popup once on build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_dialogShown) {
                _dialogShown = true;
                CustomPopupsLoginUser.showLoginUserDialog(context);
              }
            });

            return Stack(
              children: [
                // Layer 1: Background
                Positioned.fill(
                  child: isMobile
                      ? Container(color: const Color(0xFF79AB43))
                      : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/bg-home.jpg',
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

                // Layer 2: Konten scrollable
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: isMobile ? 50 : 88),
                    child: Column(
                      children: [
                        HeroSection(constraints: constraints, pageType: PageType.home),
                        Transform.translate(
                          offset: const Offset(0, -40),
                          child: FloatingButtons(constraints: constraints),
                        ),
                        ActionSection(constraints: constraints, showCTAs: true),
                        CarouselSection(constraints: constraints),
                        FeatureSection(constraints: constraints),
                        TestimonialSection(constraints: constraints),
                        ClientSection(constraints: constraints),
                        FooterSection(constraints: constraints),
                      ],
                    ),
                  ),
                ),

                // Layer 3: Navbar overlay
                const FixedNavbarOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }
}
