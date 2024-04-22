import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';



class LoginBloc extends Bloc<LoginViewEvent, LoginState> {

  LoginBloc() : super(LoginSignIn()) {
    on<LoginSignInEvent> ((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginSignIn());
    });

    on<LoginSignUpEvent> ((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginSignUp());
    });
  }
}