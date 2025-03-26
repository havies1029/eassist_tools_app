import 'dart:async';

import 'package:eassist_tools_app/common/app_data.dart';
import 'package:equatable/equatable.dart';

import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:eassist_tools_app/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUnauthenticated()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    debugPrint("_onAppStarted");

    emit(AuthenticationPreCheckHasToken());
    bool hasToken = AppData.kIsWeb ? false : await userRepository.hasToken();
    emit(AuthenticationPostCheckHasToken());

    //debugPrint("hasToken ?");
    if (hasToken) {
      emit(AuthenticationAuthenticated());
      //debugPrint("hasToken ? yes -> ${AppData.userToken}");
    } else {
      //debugPrint("hasToken ? no");
      emit(AuthenticationUnauthenticated());
      //debugPrint("hasToken ? no -> proceed");
    }
  }

  Future<void> _onLoggedIn(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    if (!AppData.kIsWeb) {
      await userRepository.persistToken(user: event.user);
    }

    AppData.user = event.user;

    emit(AuthenticationAuthenticated());
  }

  Future<void> _onLoggedOut(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    if (!AppData.kIsWeb) {
      await userRepository.deleteToken(id: 0);
      //userRepository.dropTableUser();
    }
    emit(AuthenticationUnauthenticated());
  }
}
