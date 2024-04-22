
import 'package:application/screens/profile/models/user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();
}

class LoadUser extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  const UpdateProfile({
    required this.user
  });
  final User user;
}
