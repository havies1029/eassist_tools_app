import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    //on<PinVerified>(_onPinVerified);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    emit(LoginLoading());

    try {
      final user = await userRepository.authenticate(
        email: event.email,
        password: event.password,
      );

      AppData.user = user;
      AppData.userToken = user.token!;

      emit(LoginPreAuthenticate());

      // Simpan password jika rememberMe true
      if (event.rememberMe) {
        userRepository.persistToken(userToken: user.token ?? "");
      }

      authenticationBloc.add(LoggedIn(user: user));

      emit(LoginPostAuthenticate());
    } catch (error) {
      emit(LoginFailure(error: "username atau password salah"));
    }
  }
}
