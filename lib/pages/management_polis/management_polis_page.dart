import 'package:flutter/material.dart';

import '../../blocs/gen_aset_dashboard/asetdashboardcari_bloc.dart';
import '../../common/constants.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/management_polis_asset/header_polis.dart';
import '../../widgets/section/management_polis_asset/category_tab_bar.dart';
import '../../widgets/section/management_polis_asset/polis_status_card.dart';
import '../../widgets/section/management_polis_asset/tables/polis_tables/action_button_section.dart';
import '../../widgets/section/management_polis_asset/tables/polis_tables/table_main.dart';
import '../../widgets/section/management_polis_asset/category_type.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../base/base_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolisManagementPage extends StatefulWidget {
  const PolisManagementPage({super.key});

  @override
  State<PolisManagementPage> createState() => _PolisManagementPageState();
}

class _PolisManagementPageState extends State<PolisManagementPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CategoryType selectedCategory = CategoryType.ringkasan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = MediaQuery
              .of(context)
              .size
              .width < 768;
          return Stack(
            children: [
              // Layer 1: Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/management_polis_bg.png',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 3),
                  cacheWidth: 1440,
                  cacheHeight: 800,
                ),
              ),

              // Layer 2: Scrollable content
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: isMobile ? 65 : 88),
                  child: Column(
                    children: [
                      HeroSection(
                        constraints: constraints,
                        sectionType: SectionType.management_polis,
                      ),
                      FloatingButtons(constraints: constraints),
                      HeaderPolis(constraints: constraints),
                      CategoryTabBar(
                        constraints: constraints,
                        selectedCategory: selectedCategory,
                        onCategorySelected: (value) {
                          setState(() {
                            selectedCategory = value;
                          });

                          context.read<AsetDashboardCariBloc>().add(
                            RefreshAsetDashboardCariEvent(
                              cobAppId: value.cobKode,
                            ),
                          );
                        },
                      ),

                      // ⬇️ Langsung tampilkan konten
                      Column(
                        key: const ValueKey('content'),
                        children: [
                          BlocBuilder<AsetDashboardCariBloc,
                              AsetDashboardCariState>(
                            builder: (context, state) {
                              if (state.status == ListStatus.success &&
                                  state.items.isNotEmpty) {
                                final summary = state.items.first;
                                debugPrint(
                                    '[SUMMARY DEBUG] Aktif: ${summary
                                        .aktifQty}, NonAktif: ${summary
                                        .nonAktifQty}, Berakhir: ${summary
                                        .berakhirQty}, OnProgress: ${summary
                                        .onProgressQty}');

                                return PolisSummarySection(
                                  constraints: constraints,
                                  aktifQty: summary.aktifQty,
                                  nonAktifQty: summary.nonAktifQty,
                                  onProgressQty: summary.onProgressQty,
                                  berakhirQty: summary.berakhirQty,
                                );
                              }

                              return const SizedBox
                                  .shrink(); // atau tampilkan pesan "Data tidak tersedia"
                            },
                          ),
                          TableMain(
                            constraints: constraints,
                            selectedCategory: selectedCategory,
                          ),
                        ],
                      ),
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