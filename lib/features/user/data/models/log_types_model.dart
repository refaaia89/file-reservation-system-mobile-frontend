import 'package:internet_application/features/user/domain/entities/log_types_entity.dart';

class LogTypesModel extends LogTypesEntity {
  const LogTypesModel({
    required super.logTypeId,
    required super.name,
    required super.createAt,
    required super.updateAt,
  });
  factory LogTypesModel.fromJson(Map<String, dynamic> json) {
    return LogTypesModel(
      logTypeId: json['logTypeId'],
      name: json['name'],
      createAt:json['created_at']!=null? DateTime.parse(json['created_at']):null,
      updateAt: json['updated_at']!=null?DateTime.parse(json['updated_at']):null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logTypeId': logTypeId,
      'name': name,
      'created_at': createAt?.toIso8601String(),
      'updated_at': updateAt?.toIso8601String(),
    };
  }

  static List<LogTypesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LogTypesModel.fromJson(json)).toList();
  }
}
