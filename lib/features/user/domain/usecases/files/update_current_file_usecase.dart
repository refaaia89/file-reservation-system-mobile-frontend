import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';

class UpdateCurrentFileUseCase {
  final FilesRepository repository;

  UpdateCurrentFileUseCase(this.repository);

  Future<Either<String, Unit>> call({required FileEntity fileEntity,required String groupId ,required String fileId}) async {
    return await repository.updateCurrentFile(fileEntity: fileEntity, groupId: groupId, fileId: fileId);
  }
}
