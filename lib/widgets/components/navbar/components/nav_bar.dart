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

class NavBar extends StatefulWidget {
  final BoxConstraints constraints;
  final bool isMenuOpen;
  final GlobalKey menuButtonKey;
  final VoidCallback onHamburgerToggle;
  final Widget profileSection;
  final PageType pageType;

  const NavBar({
    super.key,
    required this.constraints,
    required this.isMenuOpen,
    required this.menuButtonKey,
    required this.onHamburgerToggle,
    required this.profileSection,
    required this.pageType,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) =>
          previous is! AuthenticationAuthenticated &&
              current is AuthenticationAuthenticated,
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              debugPrint("✅ BlocListener triggered: user authenticated");
              context.read<MRekan1CrudBloc>().add(MRekan1CrudLihatEvent());
            }
          },
        ),
        BlocListener<MRekan1CrudBloc, MRekan1CrudState>(
          listenWhen: (prev, curr) => prev.isLoaded != curr.isLoaded,
          listener: (context, state) {
            if (state.isLoaded) {
              debugPrint("🎯 MRekan1CrudBloc loaded, triggering UI update");
              setState(() {}); // ✅ now valid inside StatefulWidget
            }
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final double maxWidth =
          widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth;
          final authState = context.watch<AuthenticationBloc>().state;

          final showHamburger = authState is AuthenticationAuthenticated &&
              (authState.authenticatedFrom == 'login_user' ||
                  authState.authenticatedFrom == 'login_client' ||
                  authState.authenticatedFrom == 'login_token');

          final blocState = context.read<MRekan1CrudBloc>().state;
          final mjnsclientId = blocState.record?.mjnsclientId;
          final hasJenisClient = mjnsclientId != null;

          return Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: SizedBox(
              width: maxWidth,
              child: Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        final authState = context.read<AuthenticationBloc>().state;

                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          if (authState is AuthenticationAuthenticated) {
                            final from = authState.authenticatedFrom;
                            final custType = authState.user.custType;

                            //   if (from == "login_user") {
                            //     context.read<HomeBloc>().add(HeroPageActiveEvent());
                            //   } else if (from == "login_client") {
                            //     context.read<HomeBloc>().add(HeroUserPageActiveEvent());
                            //   } else if (from == "login_token") {
                            //     if (custType == "C") {
                            //       context.read<HomeBloc>().add(HeroUserPageActiveEvent());
                            //     } else {
                            //       context.read<HomeBloc>().add(HeroPageActiveEvent());
                            //     }
                            //   } else {
                            //     context.read<HomeBloc>().add(HeroPageActiveEvent());
                            //   }
                            // } else if (authState is AuthenticationGoogleUserAuthenticated) {
                            //   context.read<HomeBloc>().add(HeroPageActiveEvent());
                            // } else {
                            //   context.read<HomeBloc>().add(HeroUserPageActiveEvent());
                            // }
                            context.read<HomeBloc>().add(PushPageEvent(PageType.home));
                            // context.read<HomeBloc>().add(HomePageActiveEvent());
                          }
                        });
                      },
                      child: isMobile &&
                          (widget.pageType == PageType.home)
                          ? Image.asset(
                        'assets/images/JPS.png',
                        height: 50.0,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                      )
                          : isMobile
                          ? Image.asset(
                        'assets/images/home_4.png',
                        height: 34,
                        color: const Color(0xFF79AB43),
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                      )
                          : Image.asset(
                        'assets/images/JPS.png',
                        height: 50.0,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (showHamburger) widget.profileSection,
                  SizedBox(width: isMobile ? 3 : 16),
                  if (showHamburger)
                    Container(
                      key: widget.menuButtonKey,
                      decoration: BoxDecoration(
                        color: widget.isMenuOpen
                            ? const Color(0xFF79AB43).withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: AnimatedRotation(
                          turns: widget.isMenuOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            widget.isMenuOpen ? Icons.close : Icons.menu,
                            color: const Color(0xFF79AB43),
                            size: 24,
                          ),
                        ),
                        onPressed: widget.onHamburgerToggle,
                        tooltip: widget.isMenuOpen ? 'Close menu' : 'Open navigation menu',
                        splashRadius: 24,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool get isMobile => widget.constraints.maxWidth < 768;

  bool _shouldShowProfileSection(AuthenticationState state) {
    if (state is AuthenticationAuthenticated) {
      final from = state.authenticatedFrom;
      final custType = state.user.custType;

      if (from == 'login_client') return true;
      if (from == 'login_token' && custType == 'C') return true;
    }
    return false;
  }

}
