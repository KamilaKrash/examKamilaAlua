import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:application/screens/login/auth_bloc/auth_bloc.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_bloc.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_event.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_state.dart';
import 'package:application/screens/profile/models/user.dart';
import 'package:application/screens/profile/screens/edit_page.dart';
import 'package:application/screens/subviews/shimmer_widget.dart';
import 'package:application/services/storage/storage.dart';
import 'package:application/services/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

part 'build_user.dart';
part "profile_row_item.dart";
part "shimmer_profile_widget.dart";
part "photo_widget.dart";


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Профиль',
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: ListView(
          children: [
            SizedBox(
              height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                child: BlocSelector<ProfileBloc, ProfileState, ProfileState>(
                  selector: (state) => state,
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const ShimmerProfileWidget();
                    } else if (state is ProfileLoaded) {
                      return BuildUser(user: state.user);
                    } else if (state is ProfileError) {
                      return Center(
                        child: Text(state.error.toString()),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog.adaptive(
                      title: const Text("Удаление аккаунта"),
                      content: const Text("Вы действительно хотите удалить аккаунт?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop('delete');
                          },
                          child: const Text('Да'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Нет'),
                        ),
                      ],
                    );
                }).then(
                  (value) {
                    if (value != null && value == "delete") {
                      context.read<AuthBloc>().add(DeleteAccountEvent(context: context));
                    }
                  }
                );
              },
              child: const ProfileRowItem(
                color: Colors.red,
                iconData: Icons.delete,
                isHeader: true,
                text: 'Удалить аккаунт',
              ),
            ),

            GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog.adaptive(
                        title: const Text("Выход из аккаунта"),
                        content: const Text("Вы действительно хотите выйти?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              context.read<AuthBloc>().add(LoggedOut(context: context));
                              Navigator.pop(context);
                            },
                            child: const Text('Да'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Нет'),
                          ),
                        ],
                      );
                    });
              },
              child: const ProfileRowItem(
                color: Colors.red,
                isFooter: true,
                iconData: Icons.logout,
                text: "Выйти из аккаунта",
              ),
            ),
          ],
        ),
      ),
    );
  }
} 