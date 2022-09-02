import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/domain/usecase/usecase.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';
import 'package:data/other/failure_model.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart' as dio;

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UseCase useCase;
  final SharedPref sharedPref;
  UpdateProfileCubit({required this.useCase, required this.sharedPref})
      : super(UpdateProfileState.initial());

  void updateProfileProcess(String name, String email, String username,
      String phone, dio.MultipartFile avatar) async {
    emit(state.copyWith(status: UpdateProfileStatus.submitting));

    try {
      var result =
          await useCase.postUpdateProfile(name, email, username, phone, avatar);

      // sharedPref.setTokenUser(dataResult.access_token);
      if (result.name != null) {
        print("hugaiua");
        sharedPref.setPrefLogin(1);
        sharedPref.setUserData(result.toJson());
        emit(state.copyWith(status: UpdateProfileStatus.success));
      } else {
        print("error");
        emit(state.copyWith(
            failure: Failure(message: "Gagal"),
            status: UpdateProfileStatus.error));
      }
    } catch (err) {
      print("error");
      emit(state.copyWith(
          failure:
              Failure(message: "Terjadi kesalahan, coba beberapa saat lagi"),
          status: UpdateProfileStatus.error));
    }
  }

  void updateProfileWithoutImageProcess(
      String name, String email, String username, String phone) async {
    emit(state.copyWith(status: UpdateProfileStatus.submitting));
    print("Email : " + email + " -- Phone: " + phone);
    try {
      var result = await useCase.postUpdateProfileWithoutImage(
          name, email, username, phone);
      // sharedPref.setTokenUser(dataResult.access_token);
      if (result.name != null) {
        print("hugaiua");
        sharedPref.setPrefLogin(1);
        sharedPref.setUserData(result.toJson());
        emit(state.copyWith(status: UpdateProfileStatus.success));
      } else {
        print("error");
        emit(state.copyWith(
            failure: Failure(message: "Gagal"),
            status: UpdateProfileStatus.error));
      }
    } catch (err) {
      print("error");
      emit(state.copyWith(
          failure:
              Failure(message: "Terjadi kesalahan, coba beberapa saat lagi"),
          status: UpdateProfileStatus.error));
    }
  }
}
