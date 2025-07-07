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
    print("🔵 LoginBloc: Event LoginButtonPressed diterima");
    emit(LoginInitial());
    emit(LoginLoading());

    try {
      print("🔄 LoginBloc: Memanggil userRepository.authenticate()...");
      final user = await userRepository.authenticate(
        email: event.email,
        password: event.password,
      );

      print("✅ LoginBloc: Autentikasi sukses. User: ${user.email}");
      AppData.user = user;
      AppData.userToken = user.token!;
      print("🗝️ Token disimpan ke AppData.userToken = ${user.token}");

      emit(LoginPreAuthenticate());

      if (event.rememberMe) {
        print("💾 Remember me aktif. Menyimpan token ke SharedPreferences...");
        userRepository.persistToken(userToken: user.token ?? "");
      }

      print("🚀 Mengirim event LoggedIn ke AuthenticationBloc...");
      authenticationBloc.add(LoggedIn(user: user));

      emit(LoginPostAuthenticate());
      print("🎉 LoginBloc: Emit LoginPostAuthenticate()");
    } catch (error) {
      print("❌ LoginBloc: Login gagal. Error: $error");
      emit(LoginFailure(error: "username atau password salah"));
    }
  }
}
