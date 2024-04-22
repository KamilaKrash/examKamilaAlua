part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginLoading extends LoginState {}

class LoginSignIn extends LoginState {}

class LoginSignUp extends LoginState {}
