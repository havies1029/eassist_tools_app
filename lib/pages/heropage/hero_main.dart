import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/popup_dialog_login.dart';

import 'hero_page.dart';

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
          listener: _handleAuthenticationState,
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
            bodyMedium: TextStyle(fontSize: 16.0),
            titleLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
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

  Future<void> _handleAuthenticationState(
      BuildContext context, AuthenticationState state) async {
    debugPrint("AuthenticationBloc state: $state");

    if (state is AuthenticationUnauthenticated) {
       await CustomPopupsLoginUser.showLoginUserDialog(context);
    } else if (state is AuthenticationRequireLoginClient) {
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
        await Future.delayed(const Duration(milliseconds: 100));
      }

      if (state.requiredFrom == "bloc_email_verification") {
        setState(() => _sudahTerdaftarSebagaiClient = true);
        await Future.delayed(const Duration(milliseconds: 150));
      }

      CustomPopupsLoginUser.showLoginClientDialog(context);
    } else if (state is AuthenticationForgotPassword) {
      CustomPopupsLoginUser.showForgotPasswordDialog(context);
    } else if (state is AuthenticationRequireRegisterClient) {
      CustomPopupsLoginUser.showRegisterClientDialog(context);
    } else if (state is AuthenticationRequirePinHPVerification) {
      CustomPopupsLoginUser.showRequestOTPHPDialog(context, state.hpno);
    } else if (state is AuthenticationRequirePinEmailVerification) {
      CustomPopupsLoginUser.showRequestOTPEmailDialog(context, state.email);
    } else if (state is AuthenticationPhonePinVerified) {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    } else if (state is AuthenticationAuthenticated) {
      // if (Navigator.of(context).canPop()) {
      //   // Navigator.of(context).pop();
      //   context.go('/hero_user');
      // }


      Future.microtask(() {
        if (state.authenticatedFrom == "login_user") {
          context.go('/hero');
        } else if (state.authenticatedFrom == "login_client") {
          context.go('/loading_hero_user');
        }
        else if (state.authenticatedFrom == "login_token") {
          context.go('/loading_hero_user');
        }
        else {
          // Fallback kalau tidak terdeteksi
          context.go('/hero');
        }
      });
    }
  }
}