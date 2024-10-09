import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';

class CreateNewFileUseCase {
  final FilesRepository repository;

  CreateNewFileUseCase(this.repository);

  Future<Either<String, Unit>> call({required FileEntity fileEntity, required String groupId}) async {
    return await repository.createNewFile(fileEntity: fileEntity, groupId: groupId);
  }
}
