import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../widgets/components/action/menu_action_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/components/carousel/carousel_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';

import '../../widgets/section/homeclientpage/floating_buttons_user.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/components/action/action_section.dart';

import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../aset/aset_main.dart';
import '../base/base_page.dart';
import '../gen_aset_dashboard/asetdashboardcari_main.dart';
import '../gen_cob_app/cobcari_main.dart';



class HeroUserMain extends StatelessWidget {
  const HeroUserMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 768;

          return Stack(
            children: [
              // Layer 1: Background
              Positioned.fill(
                child: isMobile
                    ? Container(color: kBrandAccentColor)
                    : Image.asset(
                  'assets/images/bg-home.jpg',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 3),
                  cacheWidth: 1440,
                  cacheHeight: 800,
                ),
              ),

              // Layer 2: Content Scroll
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: isMobile ? 50 : 88),
                  child: Column(
                    children: [
                      isMobile
                          ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          HeroSection(constraints: constraints, sectionType: SectionType.home_client),
                          Positioned(
                            top: 0,
                            bottom: -235,
                            left: 0,
                            right: 0,
                            child: FloatingButtonsUser(constraints: constraints),
                          ),
                        ],
                      )
                          : Column(
                        children: [
                          HeroSection(constraints: constraints, sectionType: SectionType.home_client),
                          FloatingButtonsUser(constraints: constraints),
                        ],
                      ),
                      MenuActionSection(constraints: constraints),
                      CarouselSection(constraints: constraints),
                      ClientSection(constraints: constraints),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),

              // Layer 3: Navbar
              const _FixedNavbarOverlay(),
            ],
          );
        },
      ),
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
          // final mjnsclientId = state.record?.mjnsclientId.toString();
          // if (!_dialogShown && (mjnsclientId == "10" || mjnsclientId == "20")) {
          //   _dialogShown = true;
          //   showDialog(
          //     context: context,
          //     builder: (context) {
          //       final isMobile = MediaQuery.of(context).size.width < 600;
          //       final screenSize = MediaQuery.of(context).size;
          //
          //       return Dialog(
          //         insetPadding: isMobile
          //             ? EdgeInsets.zero
          //             : const EdgeInsets.all(32),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(isMobile ? 0 : 16.13),
          //         ),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(isMobile ? 0 : 16.13),
          //           child: SizedBox(
          //             width: isMobile ? screenSize.width : 1200,
          //             height: isMobile ? screenSize.height : null,
          //             child: ProfileMainPage(
          //               userid: 123,
          //               selectedChoice: mjnsclientId == "10" ? 'Individual' : 'Perusahaan',
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   );
          // }
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
                        ? Container(color: kBrandAccentColor)
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
                      ],
                    ),
                  ),

                  // Konten
                  Positioned.fill(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: isMobile ? 50 : 88),
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
                          //           const SizedBox(height: 8),
                          //           Text.rich(
                          //             TextSpan(
                          //               children: [
                          //                 const TextSpan(
                          //                   text: 'Rekan ID: ',
                          //                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          //                 ),
                          //                 TextSpan(
                          //                   text: state.record?.mrekan1Id?.toString() ?? 'Tidak diketahui',
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
                          // Lanjut section bawahnya
                          isMobile
                              ? Stack(
                            clipBehavior: Clip.none,
                            children: [
                              HeroSection(constraints: constraints, sectionType: SectionType.home_client),
                              Positioned(
                                top: 0,
                                bottom: -200,
                                left: 0,
                                right: 0,
                                child: FloatingButtonsUser(constraints: constraints),
                              ),
                            ],
                          )
                              : Column(
                            children: [
                              HeroSection(constraints: constraints, sectionType: SectionType.home_client),
                              Transform.translate(
                                offset: Offset(0, -40),
                                child: FloatingButtonsUser(constraints: constraints),
                              ),
                            ],
                          ),
                          MenuActionSection(constraints: constraints),
                          CarouselSection(constraints: constraints),
                          ClientSection(constraints: constraints),
                          FooterSection(constraints: constraints),
                        ],
                      ),
                    ),
                  ),


                  // Navbar overlay
                  // const _FixedNavbarOverlay(),
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
              pageType: PageType.home,
            ),
          ),
        ],
      ),
    );
  }
}
