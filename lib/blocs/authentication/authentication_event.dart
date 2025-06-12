part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final User user;

  const LoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

class LoggedOut extends AuthenticationEvent {}

class RequireLoginClient extends AuthenticationEvent {}

class RequireLoginUser extends AuthenticationEvent {}

class RequirePinEmailVerification extends AuthenticationEvent {
  final String email;

  const RequirePinEmailVerification({required this.email});

  @override
  List<Object> get props => [email];
}


class FailedVerifyPinEmail extends AuthenticationEvent {}

class RequirePinHPVerification extends AuthenticationEvent {
  final String hpno;

  const RequirePinHPVerification({required this.hpno});

  @override
  List<Object> get props => [hpno];
}

class ForgotPasword extends AuthenticationEvent {
  final String email;

  const ForgotPasword({required this.email});

  @override
  List<Object> get props => [email];
}

class UserAuthenticated extends AuthenticationEvent {
  final User user;

  const UserAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class GoogleUserAuthenticated extends AuthenticationEvent {
  final GoogleSignInAccount user;

  const GoogleUserAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class RequireRegisterClient extends AuthenticationEvent {}

class PhonePinVerified extends AuthenticationEvent {}