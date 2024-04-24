import 'package:dartz/dartz.dart';
import 'package:promina_task/Features/login/data/models/error_message.dart';
import 'package:promina_task/Features/login/data/models/succes_model.dart';
import 'package:promina_task/Features/login/data/repo/login_repo.dart';
import 'package:promina_task/core/network/api_constant.dart';
import 'package:promina_task/core/network/api_consumer.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiConsumer apiConsumer;
  LoginRepoImpl({required this.apiConsumer});
  @override
  Future<Either<ErrorMessage, SuccessModel>> login(
      String username, String password) async {
    try {
      final response = await apiConsumer.post(ApiConstant.login, body: {
        "email": username,
        "password": password,
      });
      final user = SuccessModel.fromJson(response);
      return Right(user);
    } catch (error) {
  /// ErrorMessage.fromJson(error as Map<String,dynamic>);
      return Left(ErrorMessage.fromJson(error as Map<String,dynamic>));
    }
  }
}
