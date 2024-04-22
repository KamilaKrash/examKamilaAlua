import 'package:application/screens/login/auth_bloc/auth_bloc.dart';
import 'package:application/firebase_options.dart';
import 'package:application/screens/error/error_view_widget.dart';
import 'package:application/screens/home/home_screen.dart';
import 'package:application/screens/login/screens/login_screen.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_bloc.dart';
import 'package:application/screens/subviews/overlay_animation_widget.dart';
import 'package:application/services/firebase_auth/auth.dart';
import 'package:application/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create:(context) => AuthBloc(firebaseAuthService: FirebaseAuthService(FirebaseAuth.instance)),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ], 
      child: const MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckAuth(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: const Color.fromARGB(255, 10, 10, 10).withOpacity(0.9),
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        return const Center(
          child: SpinKitFoldingCube(
            size: 50,
            color: Colors.blue,
          ),
        );
      },
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Flutter Exam Project',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home:  BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case AuthInitial:
              case AuthLoading:
                return const Material(
                  color: Colors.white,
                  child: Center(
                    child:  Text(
                      "Загружается...",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'NotoSans'
                      ),
                    )
                  )
                );
              case Authenticated:
                return const HomeScreen();
              case Unauthenticated:
              case AuthError:
                return const LoginScreen();
              default:
                return const ErrorViewWidget();
            }
          },
        )
      ),
    );
  }
}