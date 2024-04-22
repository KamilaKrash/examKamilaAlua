import 'package:application/screens/login/auth_bloc/auth_bloc.dart';
import 'package:application/screens/login/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailFocus = FocusNode();
  final passFocus  = FocusNode();

  final _formKey   = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passController  = TextEditingController();

  bool _hidePass = true;

  final LoginBloc loginBloc = LoginBloc();

  @override
  void dispose() {
    emailFocus.dispose();
    passFocus.dispose();

    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  void fieldFocusChanged(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 252),
      body: BlocProvider(
        create: (context) => loginBloc,
        child: BlocBuilder<LoginBloc,LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                )
              );
            } else if (state is LoginSignIn) {
              return Align(
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2.0, 
                            offset: const Offset(0, 1),
                          )
                        ],
                        color: Colors.white
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          const Text(
                            'Вход в аккаунт',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 9, 9, 9),
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 12),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  autocorrect: false,
                                  controller: emailController,
                                  focusNode: emailFocus,
                                  onFieldSubmitted: (_) {
                                    fieldFocusChanged(context, emailFocus, passFocus);
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty == true) {
                                      return 'Введите email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    alignLabelWithHint: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 4)
                                  ),
                                ),
                
                                const SizedBox(height: 10),
                
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  autocorrect: false,
                                  controller: passController,
                                  focusNode: passFocus,
                                  onFieldSubmitted: (term) {
                                    passFocus.unfocus();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Введите пароль';
                                    }
                                    return null;
                                  },
                                  obscureText: _hidePass,
                                  decoration: InputDecoration(
                                    labelText: 'Пароль',
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _hidePass = !_hidePass;
                                        });
                                      },
                                      icon: Icon(
                                        _hidePass ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                
                                const SizedBox(height: 16.0),

                                Button(
                                  text:'Войти',
                                  action: () {
                                    FocusScope.of(context).unfocus();
                                    context.read<AuthBloc>().add(
                                      LoginEvent(
                                        email: emailController.text, 
                                        password: passController.text, 
                                        context: context
                                      )
                                    );
                                  },
                                  backgroundColor: const Color.fromARGB(255, 63, 169, 255),
                                ),
                

                                const SizedBox(height: 10),

                                const Text(
                                  "Если нету аккаунта, зарегистрируйтесь",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 66, 65, 65),
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Divider(
                                  thickness: 2,
                                  height: 0,
                                ),

                                const SizedBox(height: 6),

                                Button(
                                  text:'Регистрация',
                                  action: () {
                                    loginBloc.add(LoginSignUpEvent());
                                    emailController.clear();
                                    passController.clear();
                                  },
                                  backgroundColor: const Color.fromARGB(255, 192, 50, 216),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2.0, 
                            offset: const Offset(0, 1),
                          )
                        ],
                        color: Colors.white
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          const Text(
                            'Регистрация',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 9, 9, 9),
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 12),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  autocorrect: false,
                                  controller: emailController,
                                  focusNode: emailFocus,
                                  onFieldSubmitted: (_) {
                                    fieldFocusChanged(context, emailFocus, passFocus);
                                  },
                                  validator: (value) {
                                    if (value?.isEmpty == true) {
                                      return 'Введите email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    alignLabelWithHint: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 4)
                                  ),
                                ),
                
                                const SizedBox(height: 10),
                
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  autocorrect: false,
                                  controller: passController,
                                  focusNode: passFocus,
                                  onFieldSubmitted: (term) {
                                    passFocus.unfocus();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Введите пароль';
                                    }
                                    return null;
                                  },
                                  obscureText: _hidePass,
                                  decoration: InputDecoration(
                                    labelText: 'Пароль',
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _hidePass = !_hidePass;
                                        });
                                      },
                                      icon: Icon(
                                        _hidePass ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                
                                const SizedBox(height: 16.0),

                                Button(
                                  text:'Зарегистрироваться',
                                  action: () {
                                    FocusScope.of(context).unfocus();
                                    context.read<AuthBloc>().add(
                                      SignUpEvent(
                                        email: emailController.text, 
                                        password: passController.text, 
                                        context: context
                                      )
                                    );
                                  },
                                  backgroundColor: Colors.purple,
                                ),
                

                                const SizedBox(height: 10),

                                const Text(
                                  "Есть аккаунт? Войдите",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 66, 65, 65),
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Divider(
                                  thickness: 2,
                                  height: 0,
                                ),

                                const SizedBox(height: 6),

                                Button(
                                  text:'Войти',
                                  action: () {
                                    loginBloc.add(LoginSignInEvent());
                                    emailController.clear();
                                    passController.clear();
                                  },
                                  backgroundColor: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      )
    );
  }
}