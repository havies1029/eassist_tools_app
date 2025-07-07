import 'package:eassist_tools_app/widgets/account/login/login_gmail/popup_dialog_login.dart';
import 'package:eassist_tools_app/widgets/account/profile/profile_main_page.dart';
import 'package:eassist_tools_app/widgets/account/register/register_gmail/Popup.dart';
import 'package:eassist_tools_app/widgets/dialog/popup/logout_popup.dart';
import 'package:eassist_tools_app/widgets/dialog/reset_password/reset_password_dialog.dart';
import 'package:eassist_tools_app/widgets/components/navbar/components/hamburger_dropdown_content.dart';
import 'package:eassist_tools_app/widgets/components/navbar/components/nav_bar.dart';
import 'package:eassist_tools_app/widgets/components/navbar/components/profile_dropdown_content.dart';
import 'package:eassist_tools_app/widgets/components/navbar/components/profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
// import 'package:js/js_util.dart' as homeBloc;
import '../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../pages/about_jps/about_main.dart';
import '../../../pages/active_assets/active_assets_main.dart';
import '../../../pages/article_page/article_main.dart';
import '../../../pages/base/base_container.dart';
import '../../../pages/base/base_page.dart';
import '../../../pages/customer_service/cs_main.dart';
import '../../../pages/find_insurance/find_insurance_main.dart';
import '../../../pages/hero_client_page/hero_user_main.dart';
import '../../../pages/heropage/hero_main.dart';
import '../../../pages/summary_polis_assets/assets_management_main.dart';
import '../../../pages/testimony_page/testimony_main.dart';
import '../../../pages/user_jps/user_jps_main.dart';
import '../../../pages/user_non_jps/user_non_jps_main.dart';
import '../../dialog/PopUp/success_popup.dart';
import '../../../repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dialog/popup/status_popup.dart';
import 'package:flutter/src/widgets/navigator.dart';


class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

class NavbarWidget extends StatefulWidget {
  final BoxConstraints constraints;
  final bool hideProfile;
  final PageType pageType;
  const NavbarWidget({super.key, required this.constraints, this.hideProfile = false, required this.pageType});



  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  int _expandedMenuIndex = -1;
  bool _isMenuOpen = false;
  bool _isProfileMenuOpen = false;
  final GlobalKey _menuButtonKey = GlobalKey();
  final GlobalKey _profileButtonKey = GlobalKey();

  // Overlay entries untuk dropdown menus
  OverlayEntry? _menuOverlayEntry;
  OverlayEntry? _profileOverlayEntry;

  @override
  void dispose() {
    _removeOverlays();
    super.dispose();
  }

  void _removeOverlays() {
    _menuOverlayEntry?.remove();
    _menuOverlayEntry = null;
    _profileOverlayEntry?.remove();
    _profileOverlayEntry = null;
  }

  void _toggleHamburgerMenu() {
    if (_menuOverlayEntry != null && _isMenuOpen) {
      _closeHamburgerMenu();
    } else {
      _openHamburgerMenu();
    }
  }

  void _toggleProfileMenu() {
    if (_isProfileMenuOpen) {
      _closeProfileMenu();
    } else {
      _openProfileMenu();
    }
  }

  void _openHamburgerMenu() {
    if (_isProfileMenuOpen) {
      _closeProfileMenu();
    }

    setState(() => _isMenuOpen = true);

    final RenderBox? renderBox = _menuButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _menuOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Barrier untuk menutup menu ketika tap di luar
          Positioned.fill(
            child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (_) {
                if (_isMenuOpen) _closeHamburgerMenu();
              },
              child: const SizedBox.expand(),
            ),
          ),
          // Menu dropdown
          Positioned(
            top: offset.dy + size.height + 8,
            right: MediaQuery.of(context).size.width - offset.dx - size.width,
            child: Material(
              elevation: 16,
              borderRadius: BorderRadius.circular(12),
              shadowColor: Colors.black.withOpacity(0.2),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 340,
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: HamburgerDropdownContent(
                  onClose: _closeHamburgerMenu,
                  onMenuTap: (title) => _handleMenuTap(context, title),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_menuOverlayEntry!);
  }

  void _openProfileMenu() {
    if (_isMenuOpen) {
      _closeHamburgerMenu();
    }

    setState(() => _isProfileMenuOpen = true);

    final RenderBox? renderBox = _profileButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _profileOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 🔽 INI YANG PENTING: Tap luar = tutup dropdown
          Positioned.fill(
            child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (_) {
                if (_isProfileMenuOpen) _closeProfileMenu();
              },
              child: const SizedBox.expand(),
            ),
          ),
          // 🔽 Ini dropdown-nya
          Positioned(
            top: offset.dy + size.height + 8,
            right: MediaQuery.of(context).size.width - offset.dx - size.width,
            child: Material(
              elevation: 16,
              borderRadius: BorderRadius.circular(12),
              shadowColor: Colors.black.withOpacity(0.2),
              child: ProfileDropdownContent(
                onClose: _closeProfileMenu,
                onMenuTap: _handleProfileMenuTap,
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_profileOverlayEntry!);
  }

  void _closeHamburgerMenu() {
    if (_isMenuOpen) {
      setState(() => _isMenuOpen = false);
      _menuOverlayEntry?.remove();
      _menuOverlayEntry = null;
    }
  }

  void _closeProfileMenu() {
    if (_isProfileMenuOpen) {
      setState(() => _isProfileMenuOpen = false);
      _profileOverlayEntry?.remove();
      _profileOverlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavBar(
      constraints: widget.constraints,
      isMenuOpen: _isMenuOpen,
      menuButtonKey: _menuButtonKey,
      onHamburgerToggle: _toggleHamburgerMenu,
      pageType: widget.pageType, // ✅ tambahkan ini
      profileSection: widget.hideProfile
          ? const SizedBox.shrink()
          : ProfileSection(
        profileButtonKey: _profileButtonKey,
        isProfileMenuOpen: _isProfileMenuOpen,
        onToggleProfileMenu: _toggleProfileMenu,
      ),
    );
  }



  void _handleProfileMenuTap(String menu) async {
    final dummyUserRepository = DummyUserRepository();

    switch (menu) {
      case 'Profil':
        final blocState = context.read<MRekan1CrudBloc>().state;
        final mjnsclientId = blocState.record?.mjnsclientId.toString();
        debugPrint('Nilai mjnsclientId: $mjnsclientId');
        // final mrekan1Id = blocState.record?.mrekan1Id ?? 0; // ganti kalau field user ID kamu berbeda
        _closeProfileMenu();
        if (mjnsclientId == "10" || mjnsclientId == "20") {
          await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              final isMobile = MediaQuery.of(context).size.width < 600; // definisi mobile
              final screenSize = MediaQuery.of(context).size;

              return Dialog(
                insetPadding: isMobile
                    ? EdgeInsets.zero // ❗ hapus padding supaya full
                    : const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isMobile ? 0 : 16.13),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isMobile ? 0 : 16.13),
                  child: SizedBox(
                    width: isMobile ? screenSize.width : 1300,
                    height: isMobile ? screenSize.height : null,
                    child: ProfileMainPage(
                      userid: 123,
                      selectedChoice: mjnsclientId == "10" ? 'Individual' : 'Perusahaan',
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data profil tidak tersedia.")),
          );
        }
        break;


      case 'Reset Password':
        showDialog(
          context: context,
          barrierColor: Colors.black54,
          builder: (_) => const ResetPasswordPage(),
        );
        break;

      case 'Logout':
        showDialog(
          context: context,
          barrierColor: Colors.black54,
          builder: (_) => const LogoutPopup(),
        );
        break;

    }

    // Tutup menu dropdown setelah aksi selesai
    _closeProfileMenu();
  }

  Future<void> _handleMenuTap(BuildContext context, String title) async {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final dummyUserRepository = DummyUserRepository();

    void closeDrawerAndRun(VoidCallback action) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
        action();
      });
    }

    switch (title) {
      case 'Splash Screen':
        context.go('/splash');
        // context.push('/splash'); //pindah ke atas page lain
        break;

      case 'Tentang JPS':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(AboutPageActiveEvent());
        });
        break;

      case 'Home Page':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(HeroPageActiveEvent());
        });
        // context.go('/hero');
        break;

      case 'Hero User Page':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(HeroUserPageActiveEvent());
        });
        // context.go('/hero_user');
        break;

      case 'About JPS':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(AboutPageActiveEvent());
        });
        // context.go('/about');
        break;

      case 'Customer Service':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(CsPageActiveEvent());
        });
        // context.go('/cs');
        break;

      case 'Article Page':
      case 'Artikel Asuransi':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(ArticlePageActiveEvent());
        });
        // context.go('/article');
        break;

      case 'Testimoni':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(TestimonyPageActiveEvent());
        });
        // context.go('/testimony');
        break;

      case 'Find Insurance':
      case 'Cari Asuransi':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(FindInsurancePageActiveEvent());
        });
        // context.go('/find_insurance');
        break;

      case 'Rekan Contact':
      // Navigator.push(...BlocProvider...)
        context.go('/rekancontact');
        break;

      case 'Rekan General':
        context.go('/rekangeneral');
        break;

      case 'Rekan Pajak':
      case 'Rekan General V2':
        context.go('/rekanpajak');
        break;

      case 'Rekan Bank':
        context.go('/rekanbank');
        break;

      case 'Rekan Pic Form':
        context.go('/rekanpic');
        break;

      case 'Rekan Pic Crud Form':
        context.go('/rekanpiccrud');
        break;

      case 'Rekan Pic Crud Main':
        context.go('/rekanpiccrud_main');
        break;

      case 'Rekan Pic List List':
        context.go('/rekanpiclist');
        break;

      case 'Rekan Pic List List Widget':
        context.go('/rekanpiclist_widget');
        break;

      case 'Test Profile':
        context.go('/test_profile');
        break;

      case 'Management Asset':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(AssetsManagementPageActiveEvent());
        });
        // context.go('/assets_management');
        break;

      case 'Active Asset':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(ActiveAssetsPageActiveEvent());
        });
        // context.go('/active_assets');
        break;

      case 'User JPS':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(UserJPSPageActiveEvent());
        });
        // context.go('/user_jps');
        break;

      case 'User Non JPS':
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<HomeBloc>().add(UserNonJPSPageActiveEvent());
        });
        // context.go('/user_non_jps');
        break;

      case 'Lapor Claim':
        StatusPopupHelper.show(context);
        break;

      case 'Login Client':
        await CustomPopupsLoginUser.showLoginClientDialog(context);
        break;

      case 'Register Client':
        await CustomPopupsLoginUser.showRegisterClientDialog(context);
        break;

      case 'Register Gmail':
        await CustomPopupsRegisterUser.showRegisterDialog(context);
        break;

      case 'Reset Password Page':
      // Navigator.of(context).push(MaterialPageRoute(...))
        showDialog(
          context: context,
          barrierColor: Colors.black54,
          builder: (_) => const ResetPasswordPage(),
        );
        break;

      case 'Forget Password Page':
        await CustomPopupsLoginUser.showForgotPasswordDialog(context);
        break;

      case 'Popup Succeed':
      // Navigator.of(context).push(...)
        showDialog(
          context: context,
          barrierColor: Colors.black54,
          builder: (_) => PopupSuceedPage(
            message: 'Tampilan isi popup sesuai parameter',
            onOk: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HeroUserPage()),
              );
            },
          ),
        );
        break;

      case 'Profile Individu':
        showDialog(
          context: context,
          builder: (context) {
            final isMobile = MediaQuery.of(context).size.width < 600;
            final screenSize = MediaQuery.of(context).size;

            return Dialog(
              insetPadding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isMobile ? 0 : 20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isMobile ? 0 : 20.0),
                child: SizedBox(
                  width: isMobile ? screenSize.width : 1200,
                  height: isMobile ? screenSize.height : null,
                  child: ProfileMainPage(
                    userid: 123,
                    selectedChoice: 'Individual',
                  ),
                ),
              ),
            );
          },
        );
        break;

      case 'Profile Perusahaan':
        showDialog(
          context: context,
          builder: (context) {
            final isMobile = MediaQuery.of(context).size.width < 600;
            final screenSize = MediaQuery.of(context).size;

            return Dialog(
              insetPadding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isMobile ? 0 : 20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isMobile ? 0 : 20.0),
                child: SizedBox(
                  width: isMobile ? screenSize.width : 1200,
                  height: isMobile ? screenSize.height : null,
                  child: ProfileMainPage(
                    userid: 123,
                    selectedChoice: 'Perusahaan',
                  ),
                ),
              ),
            );
          },
        );
        break;

      case 'Status Popup':
        showDialog(
          context: context,
          barrierColor: Colors.black54,
          builder: (_) => const StatusPopup(),
        );
        break;

    // case 'Logout':
    // case 'Popup Logout':
    //   LogoutPopupHelper.show(
    //     context,
    //     onConfirm: () {
    //       context.read<AuthenticationBloc>().add(LoggedOut());
    //     },
    //     onCancel: () {
    //       // Opsional: lakukan sesuatu jika dibatalkan
    //     },
    //   );
    //   break;

      default:
        debugPrint('[MenuTap] Unknown title: $title');
    }
  }
}
