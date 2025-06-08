import 'package:eassist_tools_app/pages/splash/splash_page.dart';
import 'package:eassist_tools_app/widgets/dialog/PopUp/confirmation_dialog.dart';
import 'package:eassist_tools_app/widgets/profile/profile_individu/profile_individu_main_page.dart';
import 'package:eassist_tools_app/widgets/register/register_gmail/Popup.dart';
import 'package:eassist_tools_app/widgets/dialog/reset_password/reset_password_page.dart';
import 'package:eassist_tools_app/widgets/section/navbar/components/hamburger_dropdown_content.dart';
import 'package:eassist_tools_app/widgets/section/navbar/components/nav_bar.dart';
import 'package:eassist_tools_app/widgets/section/navbar/components/profile_dropdown_content.dart';
import 'package:eassist_tools_app/widgets/section/navbar/components/profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/profile/rekanbank_bloc.dart';
import '../../../blocs/profile/rekancontact_bloc.dart';
import '../../../blocs/profile/rekangeneral_bloc.dart';
import '../../../blocs/profile/rekanpajak_bloc.dart';
import '../../../blocs/profile/rekanpic_bloc.dart';
import '../../../blocs/profile/rekanpiccrud_bloc.dart';
import '../../../blocs/profile/rekanpiclist_bloc.dart';
import '../../../pages/about_jps/about_main.dart';
import '../../../pages/article_page/article_main.dart';
import '../../../pages/asset/active_asset_main.dart';
import '../../../pages/asset/find_insurance_main.dart';
import '../../../pages/hero_client_page/hero_user_main.dart';
import '../../../pages/heropage/hero_main.dart';
import '../../../pages/profile/rekanbank_form.dart';
import '../../../pages/profile/rekanpic_form.dart';
import '../../../pages/profile/rekanpiccrud_form.dart';
import '../../../pages/profile/rekanpiccrud_main.dart';
import '../../../pages/profile/rekanpiclist_list.dart';
import '../../../pages/profile/rekanpiclist_list_widget.dart';
import '../../dialog/PopUp/success_popup.dart';
import '../../dialog/forget_password/ForgetPasswordPage.dart';
import '../../login/login_client/login_client_dialog.dart';
import '../../profile/profile_perusahaan/profile_main_page.dart';
import '../../../pages/profile/rekancontact_form.dart';
import '../../../pages/profile/rekangeneral_form.dart';
import '../../../pages/profile/rekanpajak_form.dart';
import '../../../pages/testimony_page/testimony_main.dart';
import '../../../pages/customer_service/cs_main.dart';
import '../../../repositories/user/user_repository.dart';
// import '../../login/login_client/popup_client.dart';
import '../../login/login_gmail/Popup.dart';
import '../../register/register_client/popup_client.dart';



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
    if (_isMenuOpen) {
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
        onToggleProfileMenu: _toggleProfileMenu,
      ),
    );
  }


  void _handleProfileMenuTap(String menu) async {
    final dummyUserRepository = DummyUserRepository();

    switch (menu) {
      case 'Profil':
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              width: 1300,
              child: ProfileMainPage(
                userid: 123, // ganti sesuai session
                userRepository: dummyUserRepository,
              ),
            ),
          ),
        );
        break;

      case 'Reset Password':
      // await CustomPopups.showRegisterDialog(context);
        break;

      case 'Logout':
      // Tambahkan kode logout di sini
        break;
    }

    // Tutup menu dropdown setelah aksi selesai
    _closeProfileMenu();
  }

  Future<void> _handleMenuTap(String title) async {
    final dummyUserRepository = DummyUserRepository();
    if (title == 'Splash Screen') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SplashPage()),
      );
    }else if (title == 'Tentang JPS') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutMain()),
      );
    }else if (title == 'Home Page') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HeroMain()),
      );
    }else if (title == 'Hero User Page') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HeroUserMain()),
      );
    }else if (title == 'About JPS') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutMain()),
      );
    }else if (title == 'Customer Service') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CSMain()),
      );
    }else if (title == 'Article Page') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ArticleMain()),
      );
    }else if (title == 'Testimoni') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TestimonyMain()),
      );
    }else if (title == 'Find Insurance') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FindInsuranceMain()),
      );
    }else if (title == 'Rekan Contact') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanContactBloc>(context),
              child: const RekanContactFormPage(
                viewMode: 'tambah',    // atau 'ubah'
                recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }else if (title == 'Rekan General') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanGeneralBloc>(context),
              child: const RekanGeneralFormPage(
                viewMode: 'tambah',    // atau 'ubah'
                recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }else if (title == 'Rekan Pajak') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanPajakBloc>(context),
              child: const RekanPajakFormPage(
                viewMode: 'tambah',    // atau 'ubah'
                recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }
    else if (title == 'Rekan Bank') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanBankBloc>(context),
              child: const RekanBankFormPage(
                viewMode: 'tambah',    // atau 'ubah'
                recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }else if (title == 'Rekan Pic Form') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanPicBloc>(context),
              child: const RekanPicFormPage(
                viewMode: 'tambah',    // atau 'ubah'
                recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }
    else if (title == 'Rekan Pic Crud Form') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanPicCrudBloc>(context),
              child: const RekanPicCrudFormPage(
                viewMode: 'tambah',    // atau 'ubah'
                recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }else if (title == 'Rekan Pic Crud Main') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanPicCrudBloc>(context),
              child: const RekanPicCrudMainPage(
                viewMode: 'tambah',    // atau 'ubah'
                recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }else if (title == 'Rekan Pic List List') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanPajakBloc>(context),
              child: const RekanPicListPage(// kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }else if (title == 'Rekan Pic List List Widget') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanPicListBloc>(context),
              child: const RekanPicListListWidget(searchText: '',
                // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider.value(
              value: BlocProvider.of<RekanPajakBloc>(context),
              child: const RekanPajakFormPage(
                viewMode: 'tambah',    // atau 'ubah'
                recordId: '',          // kalau 'ubah', ganti dengan ID yang relevan
              ),
            );
          },
        ),
      );
    }else if (title == 'Login Gmail') {
      await CustomPopupsLoginUser.showLoginDialog(context);
    }else if (title == 'Login Client') {
      // Jika ingin push ke halaman baru:
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (_) => const LoginClientPage()),
      // );

      // Atau, jika kamu ingin menampilkannya sebagai dialog:
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (_) => const LoginClientPage(),
      );
    }else if (title == 'Register Client') {
      await CustomPopupsClient.showRegisterDialog(context);
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
      // Jika ingin push ke halaman baru:
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (_) => const ForgetPasswordPage()),
      // );

      // Atau, jika kamu ingin menampilkannya sebagai dialog:
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (_) => const ForgetPasswordPage(),
      );
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
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            width: 1200,
            child: ProfileIndividuMainPage(
              userid: 123,
              userRepository: dummyUserRepository,
            ),
          ),
        ),
      );
    } else if (title == 'Profile Perusahaan') {
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
              userRepository: dummyUserRepository,
            ),
          ),
        ),
      );
    } else if (title == 'Dialog Confirmation') {
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (_) => ConfirmationDialog(
          onConfirm: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const HeroUserPage())); },
        ),
      );
    }else if (title == 'Active Asset') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ActiveAssetMain()),
      );
    }
  }
}
