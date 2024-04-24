import 'package:dartz/dartz.dart';
import 'package:promina_task/Features/login/data/models/error_message.dart';
import 'package:promina_task/Features/login/data/models/succes_model.dart';

abstract class LoginRepo{
  Future<Either<ErrorMessage,SuccessModel>>login(String username,String password);
}
