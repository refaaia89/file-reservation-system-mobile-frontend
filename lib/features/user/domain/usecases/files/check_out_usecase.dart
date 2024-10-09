import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';

class CheckOutUseCase {
  final FilesRepository repository;

  CheckOutUseCase(this.repository);

  Future<Either<String, Unit>> call({required List<String> listFileId}) async {
    return await repository.checkOut(listFileId: listFileId);
  }
}
