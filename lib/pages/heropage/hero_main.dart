import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/pages/heropage/hero_page.dart';
import 'package:eassist_tools_app/widgets/login/login_gmail/popup_dialog_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HeroMain extends StatefulWidget {
  const HeroMain({super.key});

  @override
  State<HeroMain> createState() => HeroMainState();
}

class HeroMainState extends State<HeroMain> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            debugPrint("AuthenticationBloc state: $state");
            if (state is AuthenticationUnauthenticated) {
              debugPrint("AuthenticationUnauthenticated");

              CustomPopupsLoginUser.showLoginUserDialog(context);
            }
            else if (state is AuthenticationRequireLoginClient) {
              debugPrint("AuthenticationUnauthenticated");

              CustomPopupsLoginUser.showLoginClientDialog(context);
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
              Navigator.of(context).pop();
              CustomPopupsLoginUser.showRequestOTPHPDialog(context, state.hpno);
            }
            else if (state is AuthenticationRequirePinEmailVerification) {
              debugPrint("AuthenticationRequirePinEmailVerification");
              Navigator.of(context).pop();
              CustomPopupsLoginUser.showRequestOTPEmailDialog(context, state.email); 
            }
            else if (state is AuthenticationUserAuthenticated){
              debugPrint("AuthenticationUserAuthenticated");
              Navigator.of(context).pop();
            }
            else if (state is AuthenticationPhonePinVerified) {
              debugPrint("AuthenticationPhonePinVerified");
              Navigator.of(context).pop();
              
              debugPrint("Log out user");
              // force login user
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            }
            else if (state is AuthenticationGoogleUserAuthenticated) {
              debugPrint("AuthenticationGoogleUserAuthenticated");
              Navigator.of(context).pop();
            }
            else if (state is AuthenticationLoading) {
              debugPrint("AuthenticationLoading");
            }
            else if (state is AuthenticationPreCheckHasToken) {
              debugPrint("AuthenticationPreCheckHasToken");
            }
            else if (state is AuthenticationPostCheckHasToken) {
              debugPrint("AuthenticationPostCheckHasToken");
            }
            else if (state is AuthenticationAuthenticated) {
              debugPrint("AuthenticationAuthenticated");
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

// Ubah HeroPage jadi StatefulWidget

