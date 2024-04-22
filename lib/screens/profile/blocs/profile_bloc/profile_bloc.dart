import 'package:application/screens/profile/blocs/profile_bloc/profile_event.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_repo.dart';
import 'package:application/screens/profile/blocs/profile_bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  ProfileRepo profileRepo = ProfileRepo();

  ProfileBloc() : super(ProfileLoading()) {
    on<LoadUser>(
      (event, emit) async {
        try {
          emit(ProfileLoading());
          await Future.delayed(const Duration(seconds: 1));
          final user = await profileRepo.getUser();
          emit(ProfileLoaded(user: user));
        } catch (e) {
          emit(ProfileError(error: e.toString()));
        }
      },
    );

    on<UpdateProfile>(
      (event, emit) async {
        try {
          emit(ProfileLoading());

          await profileRepo.updateUser(
            user: event.user
          );

          final user = await profileRepo.getUser();

          await Future.delayed(const Duration(seconds: 2));
          
          emit(ProfileLoaded(user: user));
        } catch (e) {
          emit(ProfileError(error: e.toString()));
        }
      },
    );
  }
}
