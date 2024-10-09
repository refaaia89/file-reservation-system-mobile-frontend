import 'package:internet_application/features/user/domain/entities/roles_entity.dart';

class RolesModel extends RolesEntity {
  const RolesModel({
    required super.roleId,
    required super.name,
    required super.createAt,
    required super.updateAt,
  });


  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      roleId: json['roleId'],
      name: json['name'],
      createAt:json['created_at']!=null? DateTime.parse(json['created_at']):null,
      updateAt:json['updated_at']!=null? DateTime.parse(json['updated_at']):null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'name': name,
      'created_at': createAt?.toIso8601String(),
      'updated_at': updateAt?.toIso8601String(),
    };
  }

  static List<RolesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => RolesModel.fromJson(json)).toList();
  }
}
