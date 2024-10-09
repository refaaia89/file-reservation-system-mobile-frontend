import 'package:internet_application/features/user/data/models/file_model.dart';
import 'package:internet_application/features/user/data/models/user_model.dart';
import 'package:internet_application/features/user/domain/entities/reports_entity.dart';

class ReportsModel extends ReportsEntity {
  const ReportsModel({
    required super.checkProcessId,
    required super.checkedInAt,
    required super.checkedOutAt,
    required super.userEntity,
    required super.fileEntity,
    required super.createdAt,
    required super.updatedAt,
    required super.checkedOutAtTime,
  });

  factory ReportsModel.fromJson(Map<String, dynamic> json) {
    return ReportsModel(
      checkProcessId: json['checkProcessId'].toString(),
      checkedInAt: json['checkedInAt']!=null? DateTime.parse(json['checkedInAt']):null,
      checkedOutAt:  json['checkedOutAt']!=null? DateTime.parse(json['checkedOutAt']):null,
      userEntity: UserModel.fromJson(json['user'] ),
      fileEntity: FileModel.fromJson(json['file']),
      createdAt:  json['created_at']!=null? DateTime.parse(json['created_at']):null,
      updatedAt:  json['updated_at']!=null? DateTime.parse(json['updated_at']):null,
      checkedOutAtTime:  json['checkedOutAtTime']??json['checkedOutAtTime'],
    );
  }

  static List<ReportsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReportsModel.fromJson(json)).toList();
  }
}
