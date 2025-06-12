import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/models/user/user_token_model.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';

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
        username: event.username,
        password: event.password,
      );

      AppData.user = user;

      UserToken userToken = UserToken(
        id: user.id,
        token: user.token,
      );    

      if (!AppData.kIsWeb) {
        await userRepository.persistToken(userToken: userToken);
      }
      
      /*
      if (user.requiresPinVerification) {
        emit(LoginRequiresPinVerification(user: user));
      }
      else {
        emit(LoginPreAuthenticate());      
        authenticationBloc.add(LoggedIn(user: user));  
      }          
      */

      emit(LoginPreAuthenticate());  
      authenticationBloc.add(LoggedIn(user: user));  

      emit(LoginPostAuthenticate());            
    } catch (error) {      
      emit(LoginFailure(error: error.toString()));
    }
  }

  /*
  Future<void> _onPinVerified(
      PinVerified event, Emitter<LoginState> emit) async {
    emit(LoginPreAuthenticate());
    authenticationBloc.add(LoggedIn(user: event.user));
  }
  */

}
