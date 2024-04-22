part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class LoggedIn extends AuthEvent {} 

class CheckAuth extends AuthEvent {
  final BuildContext context;
  const CheckAuth({required this.context});
} 

class LoggedOut extends AuthEvent {
  final BuildContext context;
  const LoggedOut({required this.context});
}

class LoginEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password, required this.context});
}

class SignUpEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;
  const SignUpEvent({required this.email, required this.password, required this.context});
}

class DeleteAccountEvent extends AuthEvent {
  final BuildContext context;
  const DeleteAccountEvent({required this.context});
}
