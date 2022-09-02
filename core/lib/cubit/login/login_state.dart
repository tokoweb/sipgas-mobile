part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String username;
  final String password;
  final String role;
  final LoginStatus status;
  final Failure failure;

  bool get isFormValid => username.isNotEmpty && password.isNotEmpty;

  const LoginState({
    required this.username,
    required this.password,
    required this.role,
    required this.status,
    required this.failure,
  });

  factory LoginState.initial() {
    return LoginState(
        username: '',
        password: '',
        role: '',
        status: LoginStatus.initial,
        failure: Failure());
  }

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [username, password, role, status, failure];

  LoginState copyWith({
    String? username,
    String? password,
    String? role,
    LoginStatus? status,
    Failure? failure,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
