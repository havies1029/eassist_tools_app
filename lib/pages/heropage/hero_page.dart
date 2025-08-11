import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';

import '../../common/constants.dart';
import '../../repositories/user/user_repository.dart';
import '../../widgets/account/login/login_gmail/popup_dialog_login.dart';
import '../../widgets/account/profile/profile_main_page.dart';
import '../../widgets/components/hero/hero_section.dart';
import '../../widgets/components/action/menu_action_section.dart';
import '../../widgets/components/carousel/carousel_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';
import '../../widgets/components/feature/feature_section.dart';
import '../../widgets/components/floating_button/floating_buttons.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/homeclientpage/floating_buttons_user.dart';
import '../../widgets/section/testimoni/testimonial_section.dart';

import '../gen_profile/test_profile_page.dart';
import 'fixed_navbar_overlay.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<HeroPage> createState() => _HeroPageState();
}
class _HeroPageState extends State<HeroPage> {
  // bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MRekan1CrudBloc, MRekan1CrudState>(
        listener: (context, state) {
          // Dialog profile bisa kamu aktifkan kembali di sini kalau perlu
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 768;

            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
                return KeyedSubtree(
                  key: ValueKey(authState.runtimeType.toString() + DateTime.now().millisecondsSinceEpoch.toString()),
                  child: _buildHeroMainContent(authState, constraints),
                );
              },
            );
          },
        ),
      ),
    );
  }

  SectionType _getHeroSectionType(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      final from = state.authenticatedFrom;
      final custType = state.user.custType;

      if (from == "login_user") return SectionType.home;
      if (from == "login_client") return SectionType.home_client;
      if (from == "login_token") {
        return custType == "C" ? SectionType.home_client : SectionType.home;
      }
    }
    return SectionType.home;
  }

  bool _useUserButtons(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      final from = state.authenticatedFrom;
      final custType = state.user.custType;
      if (from == "login_client") return true;
      if (from == "login_token" && custType == "C") return true;
    }
    return false;
  }

  Widget _buildFloatingButtons(AuthenticationState state, BoxConstraints constraints) {
    if (state is AuthenticationAuthenticated) {
      final from = state.authenticatedFrom;
      final custType = state.user.custType;

      if (from == "login_client") return FloatingButtonsUser(constraints: constraints);
      if (from == "login_token" && custType == "C") return FloatingButtonsUser(constraints: constraints);
    }
    return FloatingButtons(constraints: constraints);
  }

  Widget _buildMenuAction(AuthenticationState state, BoxConstraints constraints) {
    if (state is AuthenticationAuthenticated) {
      final from = state.authenticatedFrom;
      final custType = state.user.custType;

      if (from == "login_client") return   MenuActionSection(constraints: constraints);
      if (from == "login_token" && custType == "C") return   MenuActionSection(constraints: constraints);
    }
    return MenuActionSection(
      constraints: constraints,
      enabledLabels: ['Cari Asuransi', 'Lapor Klaim'],
    );
  }

  Widget _buildHeroMainContent(AuthenticationState authState, BoxConstraints constraints) {
    final sectionType = _getHeroSectionType(authState);
    final floatingButtonWidget = _buildFloatingButtons(authState, constraints);
    final isMobile = constraints.maxWidth < 768;
    final isUserButtons = _useUserButtons(authState);
    return Stack(
      children: [
        // Background
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

        // Konten scrollable
        Positioned.fill(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: isMobile ? 50 : 88),
            child: Column(
              children: [
                isMobile
                    ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    HeroSection(constraints: constraints, sectionType: sectionType),
                    Positioned(
                      top: 0,
                      // ⬇️ Khusus FloatingButtonsUser pakai -200, selain itu -235
                      bottom: isUserButtons ? -200 : -235,
                      left: 0,
                      right: 0,
                      child: floatingButtonWidget,
                    ),
                  ],
                )
                    : Column(
                  children: [
                    HeroSection(constraints: constraints, sectionType: sectionType),
                    floatingButtonWidget,
                  ],
                ),
                const SizedBox(height: 0),
                _buildMenuAction(authState, constraints),
                CarouselSection(constraints: constraints),
                ClientSection(constraints: constraints),
                FooterSection(constraints: constraints),
              ],
            ),
          ),
        ),

        // // Navbar
        // const FixedNavbarOverlay(),
      ],
    );
  }

}
