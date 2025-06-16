import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' show pi;

import 'package:shared_preferences/shared_preferences.dart';    // ← import SharedPreferences
import '../../repositories/user/user_repository.dart';
import '../../widgets/section/homepage/hero_section_heropage.dart';
import '../../widgets/components/action/action_section.dart';
import '../../widgets/components/carousel/carousel_section.dart';
import '../../widgets/section/homeclientpage/client_section.dart';
import '../../widgets/components/feature/feature_section.dart';
import '../../widgets/components/floating_button/floating_buttons.dart';
import '../../widgets/components/footer/footer_section.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import '../../widgets/section/testimoni/testimonial_section.dart';

// **Pastikan method showLoginDialog mengembalikan Future<void>**
//    (di CustomPopupsLoginUser)
import 'package:eassist_tools_app/widgets/account/login/login_gmail/popup_dialog_login.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../hero_client_page/hero_user_main.dart';
import 'hero_page.dart';
class DummyUserRepository extends UserRepository {
  // Override semua method yang dibutuhkan dengan return dummy data atau kosong
}

class HeroMain extends StatefulWidget {
  const HeroMain({super.key});

  @override
  State<HeroMain> createState() => _HeroMainState();
}

class _HeroMainState extends State<HeroMain> {

  bool _sudahTerdaftarSebagaiClient = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [

        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            debugPrint("AuthenticationBloc state: $state");
            if (state is AuthenticationUnauthenticated) {
              debugPrint("AuthenticationUnauthenticated");

              CustomPopupsLoginUser.showLoginUserDialog(context);
            }
            // else if (state is AuthenticationRequireLoginClient) {
            //   debugPrint("AuthenticationRequireLoginClient");
            //
            //   CustomPopupsLoginUser.showLoginClientDialog(context);
            //   // if (state.requiredFrom == "bloc_email_verification") {
            //   //
            //   //   debugPrint(
            //   //       "sudah terdaftar di client, dialihkan ke form login client");
            //   //
            //   //   //??? kalau perlu kasih popup / notifikasi ke user terkait hal diatas.
            //   //
            //   //   CustomPopupsLoginUser.showLoginClientDialog(context);
            //   //
            //   // } else {
            //   //   CustomPopupsLoginUser.showLoginClientDialog(context);
            //   // }
            // }
            else if (state is AuthenticationRequireLoginClient) {
              debugPrint("AuthenticationRequireLoginClient");
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
                await Future.delayed(const Duration(milliseconds: 100)); // beri waktu popup menutup
              }

              if (state.requiredFrom == "bloc_email_verification") {
                debugPrint("sudah terdaftar di client, dialihkan ke form login client");

                // Update flag
                setState(() {
                  _sudahTerdaftarSebagaiClient = true;
                });

                // Delay agar tidak seperti 'pindah halaman'
                await Future.delayed(const Duration(milliseconds: 150));
                CustomPopupsLoginUser.showLoginClientDialog(context);
              } else {
                CustomPopupsLoginUser.showLoginClientDialog(context);
              }
            }
            else if (state is AuthenticationForgotPassword) {
              debugPrint("AuthenticationForgotPassword");
              CustomPopupsLoginUser.showForgotPasswordDialog(context);
            }
            else if (state is AuthenticationRequireRegisterClient) {
              debugPrint("AuthenticationRequireRegisterClient");
              CustomPopupsLoginUser.showRegisterClientDialog(context);
            }
            else if (state is AuthenticationRequirePinHPVerification) {
              debugPrint("AuthenticationRequirePinVerification");
              // Navigator.of(context).pop();
              CustomPopupsLoginUser.showRequestOTPHPDialog(context, state.hpno);
            }
            else if (state is AuthenticationRequirePinEmailVerification) {
              debugPrint("AuthenticationRequirePinEmailVerification");
              // Navigator.of(context).pop();
              CustomPopupsLoginUser.showRequestOTPEmailDialog(context, state.email);
            }
            // else if (state is AuthenticationUserAuthenticated){
            //   debugPrint("AuthenticationUserAuthenticated");
            //
            //   // Navigator.of(context, rootNavigator: true).maybePop();
            //   //
            //   // Navigator.pushReplacement(
            //   //   context,
            //   //   MaterialPageRoute(builder: (_) => HeroUserMain()),
            //   // );
            //   Navigator.of(context).pop();
            // }
            else if (state is AuthenticationPhonePinVerified) {
              debugPrint("AuthenticationPhonePinVerified");
              // Navigator.of(context).pop();

              debugPrint("Log out user");
              // force login user
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            }
            else if (state is AuthenticationGoogleUserAuthenticated) {
              debugPrint("AuthenticationGoogleUserAuthenticated");
              // Navigator.of(context).pop();
            }
            else if (state is AuthenticationLoading) {
              debugPrint("AuthenticationLoading");
            }
            else if (state is AuthenticationPreCheckHasToken) {
              debugPrint("AuthenticationPreCheckHasToken");
            }
            else if (state is AuthenticationPostCheckHasToken) {
              debugPrint("AuthenticationPostCheckHasToken");
            } else if (state is AuthenticationAuthenticated) {
              debugPrint("AuthenticationAuthenticated");

              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }

              // Navigasi aman menggunakan Future.microtask
              Future.microtask(() {
                if (state.authenticatedFrom == "login_user") {
                  debugPrint("Navigate to HeroMain");
                  context.go('/hero');
                } else if (state.authenticatedFrom == "login_client") {
                  debugPrint("Navigate to HeroUserMain");
                  context.go('/hero_user');
                }
              });
            }
          },
        ),


      ],
      child: MaterialApp(
        title: 'JPS Insurance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF79AB43),
          scaffoldBackgroundColor: const Color(0xFFD5F4B4),
          fontFamily: 'Satoshi-Regular',
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 16.0,
            ),
            titleLarge: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF79AB43),
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: const HeroPage(),
      ),
    );
  }
}
//
// // Ubah HeroPage jadi StatefulWidget
// class HeroPage extends StatefulWidget {
//   const HeroPage({super.key});
//
//   @override
//   State<HeroPage> createState() => _HeroPageState();
// }
//
// class _HeroPageState extends State<HeroPage> {
//   static const String _kShownLoginDialogKey = 'hasShownLoginDialog';
//
//   @override
//   void initState() {
//     super.initState();
//     _checkAndShowLoginDialog();
//   }
//
//   /// Cek SharedPreferences; jika belum pernah tampil, maka tampilkan dialog
//   Future<void> _checkAndShowLoginDialog() async {
//     final prefs = await SharedPreferences.getInstance();
//     final hasShown = prefs.getBool(_kShownLoginDialogKey) ?? false;
//
//     // if (!hasShown) {
//     //   // Tampilkan dialog setelah frame pertama dirender,
//     //   // lalu simpan flag hanya setelah dialog ditutup oleh user.
//     //   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     //     await CustomPopupsLoginUser.showLoginDialog(context);
//     //     // Baru setelah user menutup popup, set supaya tidak muncul lagi
//     //     await prefs.setBool(_kShownLoginDialogKey, true);
//     //   });
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final bool isMobile = constraints.maxWidth < 768;
//           return Stack(
//             children: [
//               // Layer 1: Background (Image untuk non-mobile, hijau untuk mobile)
//               Positioned.fill(
//                 child: isMobile
//                     ? Container(
//                   color: const Color(0xFF79AB43),
//                 )
//                     : Image.asset(
//                   'assets/images/bg-home.jpg',
//                   fit: BoxFit.cover,
//                   alignment: const Alignment(0, 3),
//                   cacheWidth: 1440,
//                   cacheHeight: 800,
//                 ),
//               ),
//
//               // Layer 2: Konten scrollable
//               Positioned.fill(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.only(top: 88), // ruang untuk navbar
//                   child: Column(
//                     children: [
//                       if (isMobile)
//                       // ─── Mobile: Hero + Floating dalam Stack ─────────────────
//                         Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             HeroSection(constraints: constraints),
//                             FloatingButtons(constraints: constraints),
//                           ],
//                         )
//                       else
//                       // ─── Desktop: tampil berurutan biasa ─────────────────────
//                         Column(
//                           children: [
//                             HeroSection(constraints: constraints),
//                             FloatingButtons(constraints: constraints),
//                           ],
//                         ),
//                       // HeroSection(constraints: constraints),
//                       // FloatingButtons(constraints: constraints),
//                       ActionSection(constraints: constraints),
//                       CarouselSection(constraints: constraints),
//                       FeatureSection(constraints: constraints),
//                       TestimonialSection(constraints: constraints),
//                       ClientSection(constraints: constraints),
//                       FooterSection(constraints: constraints),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Layer 3: Navbar overlay di atas semua
//               const _FixedNavbarOverlay(),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _FixedNavbarOverlay extends StatelessWidget {
//   const _FixedNavbarOverlay();
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 0,
//       left: 0,
//       right: 0,
//       child: Stack(
//         clipBehavior: Clip.none, // agar pop-up bisa muncul di luar batas
//         children: [
//           Material(
//             color: Colors.transparent,
//             elevation: 20,
//             child: NavbarWidget(
//               hideProfile: true,
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
