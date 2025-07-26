import 'dart:async';

import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  bool isSwitchingToClient = false;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUnauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<RequirePinEmailVerification>(_onRequirePinEmailVerification);
    on<RequireLoginClient>((event, emit) {
      emit(AuthenticationRequireLoginClient(
          requiredFrom: event.requiredFrom, errorMsg: event.errorMsg));
    });
    on<ForgotPasword>((event, emit) {
      emit(AuthenticationForgotPassword());
    });
    on<RequireLoginUser>((event, emit) {
      emit(AuthenticationUnauthenticated());
    });
    on<UserAuthenticated>(_onUserAuthenticated);
    on<RequireRegisterClient>((event, emit) {
      emit(AuthenticationRequireRegisterClient());
    });
    on<RequirePinHPVerification>((event, emit) {
      emit(AuthenticationRequirePinHPVerification(hpno: event.hpno));
    });
    on<PhonePinVerified>((event, emit) {
      emit(AuthenticationPhonePinVerified());
    });
    on<GoogleUserAuthenticated>((event, emit) {
      debugPrint("_onLoggedIn dari Form Login Google");
      emit(AuthenticationGoogleUserAuthenticated(user: event.user));
    });
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthenticationState> emit) async {
    debugPrint("_onAppStarted");

    // ⛔ Cegah jika sedang dalam proses OTP
    if (AppData.isInOtpProcess) {
      debugPrint("⛔ Lewati _onAppStarted karena sedang dalam proses OTP");
      return;
    }

    emit(AuthenticationPreCheckHasToken());
    String token = await userRepository.getToken();
    emit(AuthenticationPostCheckHasToken());

    debugPrint("hasToken ?");
    if (token.isNotEmpty) {
      final user = await userRepository.getUserByToken(token);

      AppData.user = user;
      AppData.userToken = token;

      emit(AuthenticationAuthenticated(
          user: user, authenticatedFrom: "login_token"));
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }


  Future<void> _onLoggedIn(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    debugPrint("_onLoggedIn dari Form Login Client");

    emit(AuthenticationLoading());

    // 🧼 Bersihin lastPageType supaya gak restore halaman lama
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastPageType');

    // Emit ke state authenticated
    emit(AuthenticationAuthenticated(
      user: event.user,
      authenticatedFrom: "login_client",
    ));
  }


  Future<void> _onLoggedOut(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());

    // Hapus token login
    await userRepository.deleteToken(id: 0);

    // ❗ RESET STACK DAN LAST PAGE
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastPageType');

    // ❗ Akses dan reset HomeBloc
    event.homeBloc.resetStack();

    emit(AuthenticationUnauthenticated());
  }


  Future<void> _onRequirePinEmailVerification(
      RequirePinEmailVerification event,
      Emitter<AuthenticationState> emit) async {
    debugPrint("✅ emit AuthenticationRequirePinEmailVerification (no loading)");
    emit(AuthenticationRequirePinEmailVerification(email: event.email));
  }


  Future<void> _onUserAuthenticated(
      UserAuthenticated event, Emitter<AuthenticationState> emit) async {
    debugPrint("_onLoggedIn dari Form Login User");

    emit(AuthenticationLoading());

    //emit(AuthenticationUserAuthenticated(user: event.user));

    emit(AuthenticationAuthenticated(
        user: event.user, authenticatedFrom: "login_user"));
  }
}
