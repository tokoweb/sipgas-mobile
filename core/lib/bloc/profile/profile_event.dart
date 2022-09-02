part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LogoutEvent extends ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class FetchAppSettingEvent extends ProfileEvent {}

class ChangePasswordEvent extends ProfileEvent {
  final String? currentPassword;
  final String? newPassword;
  final String? confirmPassword;
  const ChangePasswordEvent(
      {required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});

  @override
  // TODO: implement props
  List<Object> get props => [currentPassword!, newPassword!, confirmPassword!];
}
