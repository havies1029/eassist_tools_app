import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/login/change_password_bloc.dart';
import 'package:eassist_tools_app/blocs/networkconnection/network_bloc.dart';
import 'package:eassist_tools_app/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:eassist_tools_app/blocs/progressindicator/progressindicator_bloc.dart';
import 'package:eassist_tools_app/blocs/simuleei/simuleeicrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simuleei/simuleeilist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulgit/simulgitcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simulmv/simulmvcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simulmv/simulmvlist_bloc.dart';
import 'package:eassist_tools_app/blocs/simulpar/simulparcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/simulpar/simulparlist_bloc.dart';
import 'package:eassist_tools_app/blocs/takeimage/takeimage_cubit.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/common/loading_indicator.dart';
import 'package:eassist_tools_app/pages/home/home_page.dart';
import 'package:eassist_tools_app/pages/login/login_page.dart';
import 'package:eassist_tools_app/pages/splash/splash_page.dart';
import 'package:eassist_tools_app/repositories/login/change_password_repository.dart';
import 'package:eassist_tools_app/repositories/simuleei/simuleeicrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulgit/simulgitcrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulmv/simulmvcrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulpar/simulparcrud_repository.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

Future<void> main() async {
  
  final userRepository = UserRepository();
  AppData.kIsWeb = kIsWeb;
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(
      userRepository: userRepository,
      key: null,
    ),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  const App({required super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangePasswordBloc>(
          create: (context) =>
              ChangePasswordBloc(repository: ChangePasswordRepository())),
        BlocProvider<TakeImageCubit>(
          create: (context) => TakeImageCubit(),
        ),        
        BlocProvider<ProgressIndicatorBloc>(
          create: (context) => ProgressIndicatorBloc()),
        BlocProvider<NetworkBloc>(
          create: (context) => NetworkBloc()..add(NetworkObserve())), 
        BlocProvider<OnBoardMenuCariBloc>(
          create: (context) => OnBoardMenuCariBloc()),   
        BlocProvider<SimulmvListBloc>(
          create: (context) => SimulmvListBloc()),      
        BlocProvider<SimulmvCrudBloc>(
          create: (context) =>
              SimulmvCrudBloc(repository: SimulmvCrudRepository())), 
        BlocProvider<SimulparListBloc>(
          create: (context) => SimulparListBloc()),      
        BlocProvider<SimulparCrudBloc>(
          create: (context) =>
              SimulparCrudBloc(repository: SimulparCrudRepository())),
        BlocProvider<SimuleeiListBloc>(
          create: (context) => SimuleeiListBloc()),   
        BlocProvider<SimuleeiCrudBloc>(
          create: (context) =>
              SimuleeiCrudBloc(repository: SimuleeiCrudRepository())), 
        BlocProvider<SimulgitCrudBloc>(
          create: (context) =>
              SimulgitCrudBloc(repository: SimulgitCrudRepository())),
                                  
             
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculator JPS',
        theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.light,

        routes: const {},

        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              debugPrint("AuthenticationUninitialized #10");
        
              return const SplashPage();
            }
        
            if (state is AuthenticationAuthenticated) {
              debugPrint("AuthenticationAuthenticated #20");
        
              return HomePage(
                userRepository: userRepository,
                userid: 0,
                key: null,
              );
               
            }
        
            if (state is AuthenticationUnauthenticated) {
              debugPrint("AuthenticationUnauthenticated #30");
              return LoginPage(
                userRepository: userRepository,
              );
            }
        
            if (AppData.kIsWeb) {
              return LoginPage(
                userRepository: userRepository,
              );
            } else {
              return const LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
