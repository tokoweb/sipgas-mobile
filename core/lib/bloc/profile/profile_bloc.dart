import 'package:bloc/bloc.dart';
import 'package:core/domain/usecase/usecase.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';

import 'package:equatable/equatable.dart';
import 'package:data/other/failure_model.dart';
import 'package:data/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UseCase useCase;
  final SharedPref sharedPref;
  ProfileBloc({required this.useCase, required this.sharedPref})
      : super(ProfileState.initial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchProfileEvent) {
      yield* _mapFetchProfilToState();
    } else if (event is LogoutEvent) {
      yield* _mapLogoutToState();
    } else if (event is FetchAppSettingEvent) {
      yield* _mapFetchAppSettingToState();
    } else if (event is ChangePasswordEvent) {
      yield* _mapChangePasswordToState(event);
    }
  }

  Stream<ProfileState> _mapFetchProfilToState() async* {
    yield state.copyWith(user: InfoResponse(), status: ProfileStatus.loading);
    try {
      final userResponse = await useCase.getInfoProfile();
      yield state.copyWith(
          user: userResponse, status: ProfileStatus.fetch_loaded);
    } catch (e) {
      String json = await sharedPref.getUserData();
      SubLoginResponse data = SubLoginResponse.fromJson(json);
      var dataProfile = InfoResponse(
        name: data.name,
        username: data.username,
        email: data.email,
        phone: data.phone,
        avatarUrl: data.avatarUrl,
      );
      yield state.copyWith(
          user: dataProfile,
          failure:
              Failure(message: "Terjadi kesalahan, coba beberapa saat lagi"));
    }
  }

  Stream<ProfileState> _mapLogoutToState() async* {
    yield state.copyWith(
        logout: LogoutResponse(), status: ProfileStatus.logout_loading);
    try {
      var result = await useCase.postLogout();

      if (result.message != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        yield state.copyWith(
            logout: LogoutResponse(), status: ProfileStatus.logout_loaded);
      } else {
        yield state.copyWith(
            user: InfoResponse(),
            status: ProfileStatus.error,
            failure: Failure());
      }
    } catch (err) {
      yield state.copyWith(
          status: ProfileStatus.error,
          failure:
              Failure(message: "Terjadi kesalahan, coba beberapa saat lagi"));
    }
  }

  Stream<ProfileState> _mapFetchAppSettingToState() async* {
    yield state.copyWith(
        appSetting: AppSettingResponse(), status: ProfileStatus.loading);
    print("Hit Profile");

    try {
      final appSetting = await useCase.getAppSetting();
      yield state.copyWith(
          appSetting: appSetting, status: ProfileStatus.app_setting_loaded);
    } catch (e) {
      print("master" + e.toString());
      yield state.copyWith(
          status: ProfileStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<ProfileState> _mapChangePasswordToState(
      ChangePasswordEvent event) async* {
    yield state.copyWith(
        changePassword: ChangePasswordResponse(),
        status: ProfileStatus.change_password_loading);
    try {
      var result = await useCase.postChangePassword(
          event.currentPassword.toString(),
          event.newPassword.toString(),
          event.confirmPassword.toString());
      // sharedPref.setTokenUser(dataResult.access_token);
      if (result.message != null) {
        yield state.copyWith(
            changePassword: result,
            status: ProfileStatus.change_password_loaded);
      } else {
        yield state.copyWith(
            changePassword: ChangePasswordResponse(),
            status: ProfileStatus.error,
            failure: Failure(message: "Password lama anda salah"));
      }
    } catch (err) {
      yield state.copyWith(
          status: ProfileStatus.error,
          failure: Failure(message: err.toString()));
    }
  }
}
