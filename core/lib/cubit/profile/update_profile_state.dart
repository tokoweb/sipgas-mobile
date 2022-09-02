part of 'update_profile_cubit.dart';

enum UpdateProfileStatus { initial, submitting, success, error }

class UpdateProfileState extends Equatable {
  final UpdateProfileStatus status;
  final Failure failure;

  const UpdateProfileState({required this.status, required this.failure});

  factory UpdateProfileState.initial() {
    return UpdateProfileState(
        status: UpdateProfileStatus.initial, failure: Failure());
  }

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [status, failure];

  UpdateProfileState copyWith({
    UpdateProfileStatus? status,
    Failure? failure,
  }) {
    return UpdateProfileState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
