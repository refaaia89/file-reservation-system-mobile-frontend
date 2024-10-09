import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';

class GetAllFilesUseCase {
  final FilesRepository repository;

  GetAllFilesUseCase(this.repository);

  Future<Either<String, List<FileEntity>>> call({required int page,required int pageSize}) async {
    return await repository.getAllFiles(page: page, pageSize: pageSize);
  }
}
