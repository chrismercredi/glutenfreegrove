part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

final class ProfileUpdated extends ProfileState {
  final bool isUpdated;

  const ProfileUpdated(this.isUpdated);

  @override
  List<Object> get props => [isUpdated];
}

final class ProfileDeleted extends ProfileState {}

final class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
