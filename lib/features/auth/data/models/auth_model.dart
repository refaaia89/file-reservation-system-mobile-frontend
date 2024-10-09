import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.userName,
    required super.email,
    required super.password,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(userName: json['user_name'], email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      "username": userName,
      "email": email,
      "password": password,
    };
  }
}
