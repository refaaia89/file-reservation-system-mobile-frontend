import 'dart:io';

import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final String fileId;
  final String name;
  final DateTime? checkedInUntilTime;
  final bool isCheckedIn;
  final File? file;
  final String owner;
  final String ownerId;
  final String? group;
  final DateTime? createAt;
  final DateTime? updateAt;
  final int updatedBy;

  const FileEntity({
    required this.fileId,
    required this.name,
    required this.isCheckedIn,
    required this.file,
    required this.ownerId,
    required this.owner,
    required this.checkedInUntilTime,
    required this.createAt,
    required this.updateAt,
    required this.group,
    required this.updatedBy,
  });

  @override
  List<Object?> get props => [
        name,
        fileId,
        checkedInUntilTime,
        createAt,
        updateAt,
        file,
        owner,
        ownerId,
        updatedBy,
      ];
}
