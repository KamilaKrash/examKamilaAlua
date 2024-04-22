
import 'package:application/screens/profile/models/user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required this.user});
  final User? user;
}

class ProfileError extends ProfileState {
  const ProfileError({required this.error});
  final Object? error;
}