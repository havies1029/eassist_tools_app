part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;
  AuthenticationAuthenticated({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationUserAuthenticated extends AuthenticationState {
  final User user;
  AuthenticationUserAuthenticated({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationGoogleUserAuthenticated extends AuthenticationState {
  final GoogleSignInAccount user;
  AuthenticationGoogleUserAuthenticated({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationPreCheckHasToken extends AuthenticationState {}
class AuthenticationPostCheckHasToken extends AuthenticationState {}
class AuthenticationRequirePinEmailVerification extends AuthenticationState {
  final String email;

  AuthenticationRequirePinEmailVerification({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthenticationRequireLoginClient extends AuthenticationState {}

class AuthenticationRequirePinHPVerification extends AuthenticationState {
  final String hpno;

  AuthenticationRequirePinHPVerification({required this.hpno});

  @override
  List<Object> get props => [hpno];
}


class AuthenticationForgotPassword extends AuthenticationState {}
class AuthenticationRequireRegisterClient extends AuthenticationState {}
class AuthenticationPhonePinVerified  extends AuthenticationState {}