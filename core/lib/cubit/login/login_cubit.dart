// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:core/domain/usecase/usecase.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';
import 'package:data/other/failure_model.dart';
import 'package:equatable/equatable.dart';
import 'package:services/internal_service/check_connection.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UseCase useCase;
  final SharedPref sharedPref;
  LoginCubit({
    required this.useCase,
    required this.sharedPref,
  }) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(username: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void loginProcess(String username, String password, String role) async {
    bool isOnline = await ConnectionStatus.hasNetwork();
    emit(state.copyWith(status: LoginStatus.submitting));
    if (isOnline) {
      try {
        print("USERNAME : " + username);
        var result = await useCase.postloginProcess(username, password, role);

        // sharedPref.setTokenUser(dataResult.access_token);
        if (result.user != null) {
          print("hugaiua");
          result.user!.roleName = result.user!.roleData!.name!;
          result.user!.roleData = null;

          sharedPref.setPrefLogin(1);
          sharedPref.setTokenUser(result.accessToken!);
          sharedPref.setUserData(result.user!.toJson());
          sharedPref.setRoleUser(result.user!.roleName!);
          sharedPref.setUserId(result.user!.id!.toString());
          emit(state.copyWith(status: LoginStatus.success));
        } else {
          print("error1");
          emit(state.copyWith(
              failure: Failure(
                  message: "Username atau password yang anda masukkan salah"),
              status: LoginStatus.error));
          // if (result.message != null) {
          //   emit(state.copyWith(
          //       failure: Failure(message: result.message!),
          //       status: LoginStatus.error));
          // }
        }
      } on Failure catch (err) {
        print("error2");
        emit(state.copyWith(failure: err, status: LoginStatus.error));
      }
    } else {
      emit(state.copyWith(
          failure: Failure(message: "Jaringan anda sedang bermasalah"),
          status: LoginStatus.error));
    }
  }
}
