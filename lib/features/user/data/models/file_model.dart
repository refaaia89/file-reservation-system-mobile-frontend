import 'package:dio/dio.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';

class FileModel extends FileEntity {
//   const FileModel(
//       {required super.fileId,
//       required super.name,
//       required super.isCheckedIn,
//       required super.file,
//       required super.owner,
//       required super.ownerId,
//       required super.checkedInUntilTime,
//       required super.createAt,
//       required super.updateAt,
//         required super.group,required this
//       });
//   factory FileModel.fromJson(Map<String, dynamic> json) {
//       return FileModel(
//           group: json['group']??json['group'].toString(),
//           fileId: json['fileId'].toString(),
//           name: json['name'].toString(),
//           isCheckedIn: json['is_checked_in'],
//           file: json['file'],
//           owner: json['owner'].toString(),
//           ownerId: json['owner_id'].toString(),
//           checkedInUntilTime: json['checked_in_until_time']!=null?DateTime.parse(json['checked_in_until_time']):null,
//           createAt:json['created_at']!=null? DateTime.parse(json['created_at']):null,
//           updateAt: json['updated_at']!=null?DateTime.parse(json['updated_at']):null,
//       );
//   }
//
//   Future<Map<String, dynamic>> toJson()async {
//       return {
//           'fileId': fileId,
//           'name': name,
//           'is_checked_in': isCheckedIn,
//           'file':  await MultipartFile.fromFile(file!.path, filename: file!.path.split('/').last),
//           'owner': owner,
//           'owner_id': ownerId,
//           'checked_in_until_time': checkedInUntilTime?.toIso8601String(),
//           'created_at': createAt?.toIso8601String(),
//           'updated_at': updateAt?.toIso8601String(),
//           'group': group,
//       };
// =======
  const FileModel({
    required super.fileId,
    required super.name,
    required super.isCheckedIn,
    required super.file,
    required super.owner,
    required super.ownerId,
    required super.checkedInUntilTime,
    required super.createAt,
    required super.updateAt,
    required super.updatedBy,
    required super.group,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      fileId: json['fileId'].toString(),
      name: json['name'].toString(),
      isCheckedIn: json['is_checked_in'],
      file: json['file'],
      owner: json['owner'].toString(),
      ownerId: json['owner_id'].toString(),
      checkedInUntilTime: json['checked_in_until_time'] != null ? DateTime.parse(json['checked_in_until_time']) : null,
      createAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updateAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      updatedBy: json['updated_by'] ?? -1, group:json['group']??json['group'].toString(),
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'fileId': fileId,
      'name': name,
      'is_checked_in': isCheckedIn,
      'file': await MultipartFile.fromFile(file!.path, filename: file!.path.split('/').last),
      'owner': owner,
      'owner_id': ownerId,
      'checked_in_until_time': checkedInUntilTime?.toIso8601String(),
      'created_at': createAt?.toIso8601String(),
      'updated_at': updateAt?.toIso8601String(),
      'updated_by': updatedBy,
      'group': group,
    };

  }

  static List<FileModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FileModel.fromJson(json)).toList();
  }
}
