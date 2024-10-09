import 'package:internet_application/features/user/data/models/file_model.dart';
import 'package:internet_application/features/user/data/models/user_model.dart';

import '../../domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {
  const GroupModel(
      {required super.groupId,
      required super.name,
      required super.description,
      required super.isPublic,
      required super.allowedExtensionFileTypes,
      required super.members,
      required super.administratorId,
      required super.maxMemberCount,
      required super.administratorName,
      required super.maxAllowedFileSizeInMb,
      required super.maxFilesCount,
      required super.createAt,
      required super.updateAt,
      required super.admin,
      required super.files});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      groupId: json['groupId'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      isPublic: json['is_public'],
      allowedExtensionFileTypes: json['allowed_extension_file_types'].toString(),
      members: json['members'] != null
          ? List<UserModel>.from(
              json['members'].map((member) => UserModel.fromJson(member)),
            )
          : [],
      administratorId: json['administrator-id'].toString(),
      maxMemberCount: json['max_members_count'].toString(),
      administratorName: json['administrator'].toString(),
      maxAllowedFileSizeInMb: json['max_allowed_file_size_in_mb'].toString(),
      maxFilesCount: json['max_files_count'].toString(),
      createAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updateAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      admin: json['admin'] != null ? UserModel.fromJson(json['admin']) : null,
      files: json['files'] != null
          ? List<FileModel>.from(
              json['files'].map((file) => FileModel.fromJson(file)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'name': name,
      'description': description,
      'is_public': isPublic,
      'allowed_extension_file_types': allowedExtensionFileTypes,
      'administrator_id': administratorId,
      'max_members_count': maxMemberCount,
      'administrator': administratorName,
      'max_allowed_file_size_in_mb': maxAllowedFileSizeInMb,
      'max_files_count': maxFilesCount,
      'created_at': createAt?.toIso8601String(),
      'update_at': updateAt?.toIso8601String(),

    };
  }

  static List<GroupModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GroupModel.fromJson(json)).toList();
  }
}
