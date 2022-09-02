// ignore_for_file: constant_identifier_names

part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  fetch_loaded,
  logout_loaded,
  logout_loading,
  app_setting_loaded,
  change_password_loading,
  change_password_loaded,
  error,
}

class ProfileState extends Equatable {
  final InfoResponse user;
  final LogoutResponse logout;
  final AppSettingResponse appSetting;
  final ChangePasswordResponse changePassword;
  final ProfileStatus status;
  final Failure failure;
  const ProfileState(
      {required this.user,
      required this.logout,
      required this.appSetting,
      required this.changePassword,
      required this.status,
      required this.failure});

  factory ProfileState.initial() {
    return ProfileState(
      user: InfoResponse(),
      logout: LogoutResponse(),
      appSetting: AppSettingResponse(),
      changePassword: ChangePasswordResponse(),
      status: ProfileStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object> get props =>
      [user, logout, appSetting, changePassword, status, failure];

  ProfileState copyWith({
    InfoResponse? user,
    LogoutResponse? logout,
    AppSettingResponse? appSetting,
    ChangePasswordResponse? changePassword,
    ProfileStatus? status,
    Failure? failure,
  }) {
    return ProfileState(
      user: user ?? this.user,
      logout: logout ?? this.logout,
      appSetting: appSetting ?? this.appSetting,
      changePassword: changePassword ?? this.changePassword,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
