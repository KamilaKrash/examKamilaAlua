import 'package:application/services/firebase_auth/auth.dart';
import 'package:application/services/storage/storage.dart';
import 'package:application/services/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService firebaseAuthService;

  AuthBloc({required this.firebaseAuthService}) : super(AuthInitial()) {
    on<CheckAuth>((event, emit) async {
      try {
        emit(AuthLoading());
        
        final String? userString = await StorageService.getString(key: "useremailpass");
        
        if (userString?.isNotEmpty == true) { 
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      } catch (e) {
        final BuildContext context = event.context;
        if (context.mounted) {
          Utils.showSnackBar(event.context, e.toString());  
        }
        emit(Unauthenticated());
      }
    });

    // * Login
    on<LoginEvent>((event, emit) async {
      try {
        event.context.loaderOverlay.show();
        await firebaseAuthService.loginWithEmail(
          email: event.email, 
          password: event.password, 
          context: event.context
        ).then(
          (isLogged) {
            if (isLogged) {
              emit(Authenticated());
            }
          }
        );
      } catch (e) {
        final BuildContext context = event.context;
        if (context.mounted) {
          Utils.showSnackBar(event.context, e.toString());  
        }
        emit(Unauthenticated());
      } finally {
        event.context.loaderOverlay.hide();
      }
    });

    on<SignUpEvent> ((event, emit) async {
      try {
        event.context.loaderOverlay.show();

        await firebaseAuthService.signUpWithEmail(
          email: event.email, 
          password: event.password, 
          context: event.context
        ).then(
          (isLogged) {
            if (isLogged) {
              emit(Authenticated());
            }
          }
        );
      } catch (e) {
        final BuildContext context = event.context;
        if (context.mounted) {
          Utils.showSnackBar(event.context, e.toString());  
        }
        emit(Unauthenticated());
      } finally {
        event.context.loaderOverlay.hide();
      }
    });
    


    // * LogOut
    on<LoggedOut>((event, emit) async {
      try {
        event.context.loaderOverlay.show();
        final context = event.context;

        
        await StorageService.remove(key: 'user');
        await StorageService.remove(key: 'image');
        await StorageService.remove(key: 'useremailpass');
        
        if (context.mounted) {
          final isSignOutted = await firebaseAuthService.signOut(event.context);  
          if (isSignOutted) {
            Navigator.of(context);
            emit(Unauthenticated());    
          }
        }
      } catch (e) {
        final BuildContext context = event.context;
        if (context.mounted) {
          Utils.showSnackBar(event.context, e.toString());  
        }
      } finally {
        event.context.loaderOverlay.hide();
      }
    });

    on<DeleteAccountEvent>((event, emit) async {
      await firebaseAuthService.deleteAccount().then(
        (value) {
          if (value) {
            add(LoggedOut(context: event.context));
          }
        }
      );
    });
  }
}