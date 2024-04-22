part of 'login_bloc.dart';

@immutable
abstract class LoginViewEvent {
  const LoginViewEvent();
}

class LoginSignInEvent extends LoginViewEvent {}

class LoginSignUpEvent extends LoginViewEvent {}