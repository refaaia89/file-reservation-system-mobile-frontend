import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String userName;
  final DateTime? createAt;
  final DateTime? updateAt;
  final String role;
  final String? token;
  final String? refreshToken;

  const UserEntity(
      {required this.id, required this.email, required this.userName, this.createAt, this.updateAt, required this.role, this.token, this.refreshToken});

  @override
  List<Object> get props => [id, userName, email, role];
}
