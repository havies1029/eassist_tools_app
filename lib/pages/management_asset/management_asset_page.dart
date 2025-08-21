import 'package:eassist_tools_app/blocs/gen_aset_par/asetparcari_bloc.dart';
import 'package:flutter/material.dart';

import '../../blocs/gen_aset_dashboard/asetdashboardcari_bloc.dart';
import '../../blocs/gen_aset_mv/asetmvcari_bloc.dart';
import '../../blocs/gen_aset_ringkasan/asetringkasancari_bloc.dart';
import '../../common/constants.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/management_polis_asset/header_polis.dart';
import '../../widgets/section/management_polis_asset/category_tab_bar.dart';
import '../../widgets/section/management_polis_asset/polis_status_card.dart';
import '../../widgets/section/management_polis_asset/tables/asset_tables/action_button_section.dart';
import '../../widgets/section/management_polis_asset/tables/asset_tables/table_main.dart';
import '../../widgets/section/management_polis_asset/category_type.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../base/base_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetManagementPage extends StatefulWidget {
  const AssetManagementPage({super.key});

  @override
  State<AssetManagementPage> createState() => _AssetManagementPageState();
}

class _AssetManagementPageState extends State<AssetManagementPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CategoryType selectedCategory = CategoryType.ringkasan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = MediaQuery.of(context).size.width < 768;
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
                        sectionType: SectionType.management_asset,
                      ),
                      FloatingButtons(constraints: constraints),
                      HeaderPolis(constraints: constraints, isAsset: true),
                      CategoryTabBar(
                        constraints: constraints,
                        selectedCategory: selectedCategory,
                        onCategorySelected: (value) async {
                          setState(() {
                            selectedCategory = value;
                          });

                          context.read<AsetDashboardCariBloc>().add(
                            RefreshAsetDashboardCariEvent(cobAppId: value.cobKode),
                          );
                        },
                      ),

                      // ⬇️ Langsung tampilkan konten tanpa loading UI
                      Column(
                        key: const ValueKey('content'),
                        children: [
                          BlocBuilder<AsetDashboardCariBloc, AsetDashboardCariState>(
                            builder: (context, state) {
                              if (state.status == ListStatus.success &&
                                  state.items.isNotEmpty) {
                                final summary = state.items.first;
                                debugPrint(
                                    '[SUMMARY DEBUG] Aktif: ${summary.aktifQty}, NonAktif: ${summary.nonAktifQty}, Berakhir: ${summary.berakhirQty}, OnProgress: ${summary.onProgressQty}');

                                return PolisSummarySection(
                                  constraints: constraints,
                                  aktifQty: summary.aktifQty,
                                  nonAktifQty: summary.nonAktifQty,
                                  onProgressQty: summary.onProgressQty,
                                  berakhirQty: summary.berakhirQty,
                                );
                              }

                              return const SizedBox.shrink(); // atau “Data tidak tersedia”
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