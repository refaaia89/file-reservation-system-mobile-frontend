import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';

class DeleteFileUseCase {
  final FilesRepository repository;

  DeleteFileUseCase(this.repository);

  Future<Either<String, Unit>> call({required String fileId }) async {
    return await repository.deleteFile(fileId: fileId);
  }
}
