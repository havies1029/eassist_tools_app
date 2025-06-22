import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../../repositories/user/user_repository.dart';
import '../../widgets/components/action/action_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/components/carousel/carousel_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';
import '../../widgets/components/feature/feature_section.dart';
import '../../widgets/section/homeclientpage/floating_buttons_user.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/testimoni/testimonial_section.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_main_page.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../gen_profile/test_profile_page.dart';

class HeroUserMain extends StatelessWidget {
  const HeroUserMain({super.key});

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
          bodyMedium: TextStyle(fontSize: 16.0),
          titleLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFF79AB43),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const HeroUserPage(),
    );
  }
}

class HeroUserPage extends StatefulWidget {
  const HeroUserPage({super.key});

  @override
  State<HeroUserPage> createState() => _HeroUserPageState();
}

class _HeroUserPageState extends State<HeroUserPage> {
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    context.read<MRekan1CrudBloc>().add(MRekan1CrudLihatEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MRekan1CrudBloc, MRekan1CrudState>(
        listener: (context, state) {
          final mjnsclientId = state.record?.mjnsclientId.toString();
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
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = MediaQuery.of(context).size.width < 768;

              return Stack(
                children: [
                  // Background
                  Positioned.fill(
                    child: isMobile
                        ? Container(color: const Color(0xFF79AB43))
                        : Image.asset(
                      'assets/images/home_3.jpg',
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, 3),
                      cacheWidth: 1440,
                      cacheHeight: 800,
                    ),
                  ),

                  // Konten
                  Positioned.fill(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 88),
                      child: Column(
                        children: [
                          // Tampilkan data client
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 20, horizontal: 16),
                          //   child: Card(
                          //     elevation: 2,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(12)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(16.0),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text.rich(
                          //             TextSpan(
                          //               children: [
                          //                 const TextSpan(
                          //                   text: 'Nama Client: ',
                          //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          //                 ),
                          //                 TextSpan(
                          //                   text: state.record?.rekanNama.isNotEmpty == true
                          //                       ? state.record!.rekanNama
                          //                       : 'Tidak diketahui',
                          //                   style: const TextStyle(fontSize: 16),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           const SizedBox(height: 8),
                          //           Text.rich(
                          //             TextSpan(
                          //               children: [
                          //                 const TextSpan(
                          //                   text: 'Jenis Client ID: ',
                          //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          //                 ),
                          //                 TextSpan(
                          //                   text: state.record?.mjnsclientId?.toString() ?? 'Tidak diketahui',
                          //                   style: const TextStyle(fontSize: 15),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          HeroSection(
                              constraints: constraints,
                              pageType: PageType.home_client),
                          Transform.translate(
                            offset: Offset(0, -40),
                            child: FloatingButtons(constraints: constraints),
                          ),
                          ActionSection(constraints: constraints, showCTAs: true),
                          FeatureSection(constraints: constraints),
                          CarouselSection(constraints: constraints),
                          TestimonialSection(constraints: constraints),
                          ClientSection(constraints: constraints),
                          FooterSection(constraints: constraints),
                        ],
                      ),
                    ),
                  ),

                  // Navbar overlay
                  const _FixedNavbarOverlay(),
                ],
              );
            },
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
