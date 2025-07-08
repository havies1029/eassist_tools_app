import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../../../blocs/home/home_bloc.dart';
import '../../../../pages/base/base_page.dart';
import '../../../../pages/hero_client_page/hero_user_main.dart';
import '../../../../pages/heropage/hero_main.dart';

class NavBar extends StatelessWidget {
  final BoxConstraints constraints;
  final bool isMenuOpen;
  final GlobalKey menuButtonKey;
  final VoidCallback onHamburgerToggle;
  final Widget profileSection;
  final PageType pageType;

  const NavBar({
    Key? key,
    required this.constraints,
    required this.isMenuOpen,
    required this.menuButtonKey,
    required this.onHamburgerToggle,
    required this.profileSection,
    required this.pageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
    constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth;
    final authState = context.watch<AuthenticationBloc>().state;
    final showHamburger = authState is AuthenticationAuthenticated &&
        (authState.authenticatedFrom == 'login_user' || authState.authenticatedFrom == 'login_client' || authState.authenticatedFrom == 'login_token');
    final blocState = context.read<MRekan1CrudBloc>().state;
    final mjnsclientId = blocState.record?.mjnsclientId;
    final hasJenisClient = mjnsclientId != null;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: SizedBox(
        width: maxWidth,
        child: Row(
          children: [
            // Logo
            // Logo JPS (selalu tampil, tidak bergantung pada authState)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  final authState = context.read<AuthenticationBloc>().state;

                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (authState is AuthenticationAuthenticated) {
                      final from = authState.authenticatedFrom;
                      final custType = authState.user.custType;

                      if (from == "login_user") {
                        context.read<HomeBloc>().add(HeroPageActiveEvent());
                      } else if (from == "login_client") {
                        context.read<HomeBloc>().add(HeroUserPageActiveEvent());
                      } else if (from == "login_token") {
                        if (custType == "C") {
                          context.read<HomeBloc>().add(HeroUserPageActiveEvent());
                        } else {
                          context.read<HomeBloc>().add(HeroPageActiveEvent());
                        }
                      } else {
                        context.read<HomeBloc>().add(HeroPageActiveEvent()); // fallback
                      }

                    }
                    else if (authState is AuthenticationGoogleUserAuthenticated) {
                      context.read<HomeBloc>().add(HeroPageActiveEvent());
                    }
                    else {
                      // Kalau belum login
                      context.read<HomeBloc>().add(HeroUserPageActiveEvent());
                    }
                  });
                },
                child: isMobile &&
                    (pageType == PageType.home ||
                        pageType == PageType.hero ||
                        pageType == PageType.herouser)
                    ? Image.asset(
                  'assets/images/JPS.png',
                  height: 60.0,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
                )
                    : isMobile
                    ? const Icon(Icons.home, size: 46, color: Color(0xFF79AB43))
                    : Image.asset(
                  'assets/images/JPS.png',
                  height: 60.0,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
                ),

              ),
            ),
            const Spacer(),
            // Profile Section (dari luar di-pass sebagai widget)
            // if (_shouldShowProfileSection(authState)) profileSection,
           if (showHamburger)
             profileSection,


            const SizedBox(width: 16),

            // Hamburger Menu Icon
            if (showHamburger)
              Container(
                key: menuButtonKey,
                decoration: BoxDecoration(
                  color: isMenuOpen
                      ? const Color(0xFF79AB43).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: AnimatedRotation(
                    turns: isMenuOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      isMenuOpen ? Icons.close : Icons.menu,
                      color: const Color(0xFF79AB43),
                      size: 24,
                    ),
                  ),
                  onPressed: onHamburgerToggle,
                  tooltip: isMenuOpen ? 'Close menu' : 'Open navigation menu',
                  splashRadius: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _shouldShowProfileSection(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      final from = state.authenticatedFrom;
      final custType = state.user.custType;

      if (from == 'login_client') return true;
      if (from == 'login_token' && custType == 'C') return true;
    }
    return false;
  }

  bool get isMobile => constraints.maxWidth < 768;


}
