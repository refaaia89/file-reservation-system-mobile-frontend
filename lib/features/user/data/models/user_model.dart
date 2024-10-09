import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.id,
      required super.userName,
      required super.email,
      required super.createAt,
      required super.updateAt,
      required super.role,
      super.token,
      super.refreshToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'].toString(),
      userName: json['username'].toString(),
      email: json['email'].toString(),
      token: json['token'] ?? "",
      refreshToken: json['refresh_token'] ?? "",
      role: json['role'].toString(),
      createAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updateAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": id,
      "username": userName,
      "token": token ?? "",
      "refresh_token": refreshToken ?? "",
      "email": email,
      "role": role,
      'created_at': createAt?.toIso8601String(),
      'updated_at': updateAt?.toIso8601String(),
    };
  }

  static List<UserModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  }
}
