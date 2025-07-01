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
import 'package:go_router/go_router.dart';
import '../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../../pages/hero_client_page/hero_user_main.dart';
import '../../dialog/PopUp/success_popup.dart';
import '../../../repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dialog/popup/status_popup.dart';



class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

class NavbarWidget extends StatefulWidget {
  final BoxConstraints constraints;
  final bool hideProfile;
  const NavbarWidget({super.key, required this.constraints, this.hideProfile = false,});

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
    if (_profileOverlayEntry != null && _isProfileMenuOpen) {
      _closeProfileMenu();
    } else {
      // Tambahan: pastikan hamburger ditutup dulu
      if (_isMenuOpen) _closeHamburgerMenu();
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
                  onMenuTap: _handleMenuTap,
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
      // Jika hideProfile true, kirim SizedBox.shrink() (widget kosong),
      // bukan null, karena NavBar mengharapkan Widget non-null
      profileSection: widget.hideProfile
          ? const SizedBox.shrink()
          : ProfileSection(
        profileButtonKey: _profileButtonKey,
        isProfileMenuOpen: _isProfileMenuOpen,
        onToggleProfileMenu: _toggleProfileMenu, // ini wajib toggle, bukan hanya open
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

  Future<void> _handleMenuTap(String title) async {
    final dummyUserRepository = DummyUserRepository();
    if (title == 'Splash Screen') {
      context.go('/splash');
      // context.push('/splash'); //pindah ke atas page lain
    }else if (title == 'Tentang JPS') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const AboutMain()),
      // );
      context.go('/about');
    }else if (title == 'Home Page') {
      context.go('/hero');
    }else if (title == 'Hero User Page') {
      context.go('/hero_user');
    }else if (title == 'About JPS') {
      context.go('/about');
    }else if (title == 'Customer Service') {
      context.go('/cs');
    }else if (title == 'Article Page') {
      context.go('/article');
    }else if (title == 'Artikel Asuransi') {
      context.go('/article');
    }else if (title == 'Testimoni') {
      context.go('/testimony');
    }else if (title == 'Find Insurance') {
      context.go('/find_insurance');
    }else if (title == 'Rekan Contact') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return BlocProvider.value(
      //         value: BlocProvider.of<RekanContactBloc>(context),
      //         child: const RekanContactFormPage(
      //           viewMode: 'tambah',    // atau 'ubah'
      //           recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
      //         ),
      //       );
      //     },
      //   ),
      // );
      context.go('/rekancontact');
    }else if (title == 'Rekan General') {
      context.go('/rekangeneral');
    }else if (title == 'Rekan Pajak') {
      context.go('/rekanpajak');
    }else if (title == 'Rekan Bank') {
      context.go('/rekanbank');
    }else if (title == 'Rekan Pic Form') {
      context.go('/rekanpic');
    }
    else if (title == 'Rekan Pic Crud Form') {
      context.go('/rekanpiccrud');
    }else if (title == 'Rekan Pic Crud Main') {
      context.go('/rekanpiccrud_main');
    }else if (title == 'Rekan Pic List List') {
      context.go('/rekanpiclist');
    }else if (title == 'Rekan Pic List List Widget') {
     context.go('/rekanpiclist_widget');
    }else if (title == 'Test Profile') {
      context.go('/test_profile');
    }
    //
    // else if (title == 'Rekan Pic List Main') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return BlocProvider.value(
    //           value: BlocProvider.of<RekanListBloc>(context),
    //           child: const RekanPicListMainPage(
    //             // kalau 'ubah', ganti dengan ID yang relevan
    //           ),
    //         );
    //       },
    //     ),
    //   );
    // }else if (title == 'Rekan Pic List Title Widget') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return BlocProvider.value(
    //           value: BlocProvider.of<RekanPajakBloc>(context),
    //           child: const RekanPicListTileWidget(isDefault: 123, mrekanpicId: '', picEmail: '', picHp: '', picNama: '',// kalau 'ubah', ganti dengan ID yang relevan
    //           ),
    //         );
    //       },
    //     ),
    //   );
    // }
    else if (title == 'Rekan General V2') {
      context.go('/rekanpajak');
    }else if (title == 'Management Asset') {
      context.go('/assets_management');
    }else if (title == 'Active Asset') {
      context.go('/active_assets');
    }else if (title == 'User JPS') {
      context.go('/user_jps');
    }else if (title == 'User Non JPS') {
      context.go('/user_non_jps');
    }else if (title == 'Cari Asuransi') {
      context.go('/find_insurance');
    }else if (title == 'Lapor Claim') {
      StatusPopupHelper.show(context);
    }else if (title == 'Login Client') {
      await CustomPopupsLoginUser.showLoginClientDialog(context);
    }else if (title == 'Register Client') {
      await CustomPopupsLoginUser.showRegisterClientDialog(context);
    }else if (title == 'Register Gmail') {
      await CustomPopupsRegisterUser.showRegisterDialog(context);
    }else if (title == 'Reset Password Page') {
      // Jika ingin push ke halaman baru:
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
      // );

      // Atau, jika kamu ingin menampilkannya sebagai dialog:
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (_) => const ResetPasswordPage(),
      );
    }else if (title == 'Forget Password Page') {
      await CustomPopupsLoginUser.showForgotPasswordDialog(context);
    }else if (title == 'Popup Succeed') {
      // Jika ingin push ke halaman baru:
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (_) => const PopupSuceedPage()),
      // );

      // Atau, jika kamu ingin menampilkannya sebagai dialog:
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (_) => PopupSuceedPage(
          message: 'Tampilan isi popup sesuai parameter',
          onOk: () {
            // navigasi ke halaman X
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HeroUserPage()));
          },
        ),
      );

    }else if (title == 'Profile Individu') {
      showDialog(
        context: context,
        builder: (context) {
          final isMobile = MediaQuery.of(context).size.width < 600;
          final screenSize = MediaQuery.of(context).size;

          return Dialog(
            insetPadding: isMobile
                ? EdgeInsets.zero
                : const EdgeInsets.all(32),
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
    } else if (title == 'Profile Perusahaan') {
      showDialog(
        context: context,
        builder: (context) {
          final isMobile = MediaQuery.of(context).size.width < 600;
          final screenSize = MediaQuery.of(context).size;

          return Dialog(
            insetPadding: isMobile
                ? EdgeInsets.zero
                : const EdgeInsets.all(32),
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

      // context.go('/rekanpajak1');
    // } else if (title == 'Dialog Confirmation') {
    //   showDialog(
    //     context: context,
    //     barrierColor: Colors.black54,
    //     builder: (_) => ConfirmationDialog(
    //       onConfirm: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const HeroUserPage())); },
    //     ),
    //   );
    // }
    }else if (title == 'Status Popup') {
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (_) => const StatusPopup(),
      );
    }
    // else if (title == 'Popup Logout') {
    //   LogoutPopupHelper.show(
    //     context,
    //     onConfirm: () {
    //       context.read<AuthenticationBloc>().add(LoggedOut());
    //     },
    //     onCancel: () {
    //       // Opsional: lakukan sesuatu jika dibatalkan
    //     },
    //   );
    // }else if (title == 'Logout') {
    //   LogoutPopupHelper.show(
    //     context,
    //     onConfirm: () {
    //       context.read<AuthenticationBloc>().add(LoggedOut());
    //     },
    //     onCancel: () {
    //       // Opsional: lakukan sesuatu jika dibatalkan
    //     },
    //   );
    // }

  }
}
