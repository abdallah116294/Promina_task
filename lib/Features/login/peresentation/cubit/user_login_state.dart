part of 'user_login_cubit.dart';

sealed class UserLoginState extends Equatable {
  const UserLoginState();

  @override
  List<Object> get props => [];
}

final class UserLoginInitial extends UserLoginState {}

class UserLoginIsLoading extends UserLoginState {}

class UserLoginIsSuccess extends UserLoginState {
  final SuccessModel successModel;
  UserLoginIsSuccess({required this.successModel});
}

class UserLoginIsError extends UserLoginState {
  final ErrorMessage errorMessage;
  UserLoginIsError({required this.errorMessage});
}
