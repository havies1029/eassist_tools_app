import 'package:eassist_tools_app/pages/splash/loading_client_page.dart';
import 'package:eassist_tools_app/pages/splash/loading_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/popup_dialog_login.dart';

import '../../blocs/gen_profile/mrekan1crud_bloc.dart';
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

      if (state.user.custType == "C") {
        debugPrint("User is a client, Load Mrekan state");
        BlocProvider.of<MRekan1CrudBloc>(context).add(MRekan1CrudLihatEvent());
      } else {
        debugPrint("User is not a client, staying on HeroMain");
      }


      WidgetsBinding.instance.addPostFrameCallback((_) {
        final authState = context.read<AuthenticationBloc>().state;
        Widget targetPage = const LoadingUserPage(); // Default fallback

        if (authState is AuthenticationAuthenticated) {
          final from = authState.authenticatedFrom;
          final custType = authState.user.custType;

          if (from == "login_user") {
            targetPage = const LoadingUserPage();
          } else if (from == "login_client") {
            targetPage = const LoadingClientPage();
          } else if (from == "login_token") {
            targetPage = (custType == "C")
                ? const LoadingClientPage()
                : const LoadingUserPage();
          }
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => targetPage),
        );
      });

    }
  }
}