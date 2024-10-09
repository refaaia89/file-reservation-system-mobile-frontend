import 'package:equatable/equatable.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';

import '../../../../core/configt/enums/enums.dart';
import 'user_entity.dart';

class GroupEntity extends Equatable {
  final String groupId;
  final String name;
  final String description;
  final bool isPublic;
  final String? allowedExtensionFileTypes;
  final String administratorId;
  final String administratorName;
  final String maxAllowedFileSizeInMb;
  final String maxFilesCount;
  final String maxMemberCount;
  final DateTime? createAt;
  final DateTime? updateAt;
  final UserEntity? admin;
  final List<UserEntity> members;
  final List<FileEntity> files;

  const GroupEntity({
    required this.groupId,
    required this.name,
    required this.description,
    required this.isPublic,
    required this.allowedExtensionFileTypes,
    required this.members,
    required this.administratorId,
    required this.maxMemberCount,
    required this.administratorName,
    required this.maxAllowedFileSizeInMb,
    required this.maxFilesCount,
    required this.createAt,
    required this.updateAt,
    required this.admin,
    required this.files,
  });

  @override
  List<Object?> get props => [
        groupId,
        name,
        description,
        isPublic,
        allowedExtensionFileTypes,
        members,
        administratorId,
        administratorName,
        maxMemberCount,
        maxAllowedFileSizeInMb,
        maxFilesCount,
        createAt,
        updateAt,
        admin,
        files
      ];
}
