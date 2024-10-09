import 'package:internet_application/features/user/domain/entities/permissions_entity.dart';

class PermissionsModel extends PermissionsEntity {
  const PermissionsModel({
    required super.permissionId,
    required super.name,
    required super.description,
    required super.createdAt,
    required super.updatedAt,
  });


  factory PermissionsModel.fromJson(Map<String, dynamic> json) {
    return PermissionsModel(
      permissionId: json['permissionId'],
      name: json['name'],
      description: json['description'],
      createdAt:json['created_at']!=null? DateTime.parse(json['created_at']):null,
      updatedAt: json['updated_at']!=null?DateTime.parse(json['updated_at']):null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permissionId': permissionId,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  static List<PermissionsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PermissionsModel.fromJson(json)).toList();
  }
}
