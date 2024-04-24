import 'package:promina_task/Features/login/data/models/user_model.dart';

class SuccessModel {
  final UserModel user;
  final String token;

  SuccessModel({required this.user, required this.token});
  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
        user: UserModel.fromJson(json['user']), token: json['token']);
  }
}
