class UserModel {
  final int id;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.emailVerifiedAt,
      required this.createdAt,
      required this.updatedAt});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
