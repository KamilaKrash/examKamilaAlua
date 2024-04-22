import 'package:application/screens/error/error_view_widget.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_bloc.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_event.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_state.dart';
import 'package:application/screens/profile/models/user.dart';
import 'package:application/screens/subviews/shimmer_widget.dart';
import 'package:application/services/utils/utils.dart';
import 'package:application/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();

  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadUser());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Редактирование'),
      ),
      body: BlocSelector<ProfileBloc, ProfileState, ProfileState>(
        selector: (state) => state,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const BuildShimmerEditProfile();
          } else if (state is ProfileLoaded) {
            final User? user = state.user;
            return BuildEdit(
              user: user,
              surnameController: surnameController,
              nameController: nameController,
            );
          } else if (state is ProfileError) {
            return ErrorViewWidget(
              message: state.error.toString(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class BuildEdit extends StatefulWidget {
  final User? user;
  final TextEditingController nameController;
  final TextEditingController surnameController;

  const BuildEdit({
    super.key,
    required this.user,
    required this.surnameController,
    required this.nameController,
  });

  @override
  State<BuildEdit> createState() => _BuildEditState();
}

class _BuildEditState extends State<BuildEdit> {
  late User? user;
  late TextEditingController nameController;
  late TextEditingController surnameController;

  String? name;
  String? surname;
  String? bdate;

  bool isNameChanged = false;
  bool isSurnameChanged = false;

  @override
  void initState() {
    user = widget.user;
    nameController = widget.nameController;
    surnameController = widget.surnameController;

    name = user?.name;
    surname = user?.surname;

    nameController.text = name ?? '';
    surnameController.text = surname ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(left:8,right:8,top: 8,bottom:80),
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Имя'.toUpperCase(), style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSans',
                      color: Colors.grey[600],
                    )),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле обязательно для заполнения';
                        }
                        return null;
                      },
                      decoration: InputDecorations(
                        hintText: 'Введите имя'
                      ).editDecoration,
                      onChanged: (value) {
                        if (value == user?.name) {
                          setState(() {
                            isNameChanged = false;
                          });
                        } else {
                          setState(() {
                            isNameChanged = true;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Text('Фамилия'.toUpperCase(),  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSans',
                      color: Colors.grey[600],
                    )),
                    const SizedBox(height: 10),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Поле обязательно для заполнения';
                          }
                          return null;
                        },
                        controller: surnameController,
                        decoration:
                            InputDecorations(hintText: 'Введите фамилию')
                                .editDecoration,
                        onChanged: (value) {
                          if (value == user?.surname) {
                            setState(() {
                              isSurnameChanged = false;
                            });
                          } else {
                            setState(() {
                              isSurnameChanged = true;
                            });
                          }
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: (
                    isNameChanged ||
                    isSurnameChanged
                  )
                      ? const Color(0xff282E4D)
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fixedSize: const Size(double.infinity, 40),
                ),
                onPressed: () async {
                  try {
                    if (nameController.text.isEmpty ||
                        surnameController.text.isEmpty
                     ) {
                      Utils.showSnackBar(context, "Заполните все поля");
                      return;
                    }
                    if (
                        isNameChanged ||
                        isSurnameChanged) {
                      context.read<ProfileBloc>().add(UpdateProfile(
                        user: User(
                          name: nameController.text,
                          surname: surnameController.text,
                        )));
                    }
                  } catch (e) {
                    Utils.showSnackBar(context, e.toString());
                  }
                },
                child: const Text(
                  'Сохранить',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class BuildShimmerEditProfile extends StatelessWidget {
  const BuildShimmerEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerWidget.rectangular(
                height: 15,
                width: 50,
              ),
              SizedBox(height: 10),
              ShimmerWidget.rectangular(height: 40),
              SizedBox(height: 20),
              ShimmerWidget.rectangular(
                height: 15,
                width: 80,
              ),
              SizedBox(height: 10),
              ShimmerWidget.rectangular(height: 40),
              SizedBox(height: 20),
              ShimmerWidget.rectangular(
                height: 15,
                width: 120,
              ),
              SizedBox(height: 10),
              ShimmerWidget.rectangular(height: 40),
              SizedBox(height: 20),
              ShimmerWidget.rectangular(
                height: 15,
                width: 50,
              ),
              SizedBox(height: 10),
              ShimmerWidget.rectangular(height: 40),
              SizedBox(height: 14),
              ShimmerWidget.rectangular(
                height: 15,
                width: 120,
              ),
              SizedBox(height: 10),
              ShimmerWidget.rectangular(height: 50),
            ],
          ),
        ),
      ],
    );
  } 
}