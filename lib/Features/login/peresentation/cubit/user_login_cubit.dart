import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/Features/login/data/models/error_message.dart';
import 'package:promina_task/Features/login/data/models/succes_model.dart';
import 'package:promina_task/Features/login/data/repo/login_repo.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit({required this.loginRepo}) : super(UserLoginInitial());
  LoginRepo loginRepo;
  Future<void> userLogin(String userName, String password) async {
    emit(UserLoginIsLoading());
    try {
      Either<ErrorMessage, SuccessModel> response =
          await loginRepo.login(userName, password);
      emit(response.fold((l) => UserLoginIsError(errorMessage: l),
          (r) => UserLoginIsSuccess(successModel: r)));
    } catch (error) {
      emit(UserLoginIsError(errorMessage:ErrorMessage(errormessage: error.toString())));
    }
  }
}
