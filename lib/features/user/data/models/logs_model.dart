import 'dart:math';

import 'package:internet_application/features/user/domain/entities/logs_entity.dart';

class LogsModel extends LogsEntity{
  const LogsModel({required super.logId, required super.name});

  factory LogsModel.fromJson(Map<String, dynamic> json) {
    return LogsModel(
      logId: json['logId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logId': logId,
      'name': name,
    };
  }

  static List<LogsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LogsModel.fromJson(json)).toList();
  }
}