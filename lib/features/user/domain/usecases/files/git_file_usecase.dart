import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';

class GetFileUseCase {
  final FilesRepository repository;

  GetFileUseCase(this.repository);

  Future<Either<String, FileEntity>> call({required String fileId}) async {
    return await repository.getFile(fileId:fileId);
  }
}
