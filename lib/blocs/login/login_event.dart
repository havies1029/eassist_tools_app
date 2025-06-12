part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final bool rememberMe;

  const LoginButtonPressed({required this.username, required this.password, required this.rememberMe});

  @override
  List<Object> get props => [username, password, rememberMe];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password, rememberMe: $rememberMe}';
}
