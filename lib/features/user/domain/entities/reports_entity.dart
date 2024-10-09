import 'package:equatable/equatable.dart';
import 'package:internet_application/features/user/data/datasource/files_link_container.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';
import 'package:internet_application/features/user/domain/entities/user_entity.dart';

class ReportsEntity extends Equatable {
  final String checkProcessId;
  final DateTime? checkedInAt;
  final DateTime? checkedOutAt;
  final UserEntity userEntity;
  final FileEntity fileEntity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? checkedOutAtTime;

  const ReportsEntity({
    required this.checkProcessId,
    required this.checkedInAt,
    required this.checkedOutAt,
    required this.userEntity,
    required this.fileEntity,
    required this.createdAt,
    required this.updatedAt,
    required this.checkedOutAtTime,
  });

  @override
  List<Object?> get props => [
        checkProcessId,
        checkedInAt,
        checkedOutAt,
        userEntity,
        fileEntity,
        createdAt,
        updatedAt,
        FilesLinkContainer.checkOut,
      ];
}
