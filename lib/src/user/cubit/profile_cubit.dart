import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit({required this.repository}) : super(ProfileInitial());

  // Fetch profile by ID
  Future<void> fetchProfile(String id) async {
    try {
      emit(ProfileLoading());
      final profile = await repository.getProfile(id);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Update profile
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      emit(ProfileLoading());
      final updatedProfile = await repository.updateProfile(profile);
      emit(ProfileUpdated(updatedProfile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Create profile
  Future<void> createProfile(ProfileModel profile) async {
    try {
      emit(ProfileLoading());
      final newProfile = await repository.createProfile(profile);
      emit(ProfileLoaded(newProfile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Delete profile
  Future<void> deleteProfile(String id) async {
    try {
      emit(ProfileLoading());
      await repository.deleteProfile(id);
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      emit(ProfileLoading());
      await repository.deleteUser(id);
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
