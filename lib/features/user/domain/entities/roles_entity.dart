import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RolesEntity extends Equatable {
  final String roleId;
  final String name;
  final DateTime? createAt;
  final DateTime? updateAt;

  const RolesEntity({
    required this.roleId,
    required this.name,
    required this.createAt,
    required this.updateAt,
  });

  @override
  List<Object?> get props => [roleId,name,createAt,updateAt];
}
