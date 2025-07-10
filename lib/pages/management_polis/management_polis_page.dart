import 'package:flutter/material.dart';

import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/section/management_polis/header_polis.dart';
import '../../widgets/section/management_polis/category_tab_bar.dart';
import '../../widgets/section/management_polis/polis_status_card.dart';
import '../../widgets/section/management_polis/action_button_section.dart';
import '../../widgets/section/management_polis/polis_tables/table_main.dart';
import '../../widgets/section/management_polis/polis_tables/polis_category_type.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/about/floating_buttons_about.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../base/base_page.dart';

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
                  padding: EdgeInsets.only(top: isMobile? 65 : 88),
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
                        },
                      ),
                      PolisSummarySection(constraints: constraints,),
                      ActionButtonSection(
                        constraints: constraints,
                        moduleType: ActionButtonModuleType.polis,
                      ),
                      TableMain(
                        constraints: constraints,
                        selectedCategory: selectedCategory,
                      ),
                      FooterSection(constraints: constraints),
                    ],
                  ),
                ),
              ),

              // Layer 3: Fixed Navbar
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
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 20,
            child: NavbarWidget(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ), pageType: PageType.polismanagement,
            ),
          ),
        ],
      ),
    );
  }
}
