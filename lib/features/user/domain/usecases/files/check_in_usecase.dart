import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';

class CheckInUseCase {
  final FilesRepository repository;

  CheckInUseCase(this.repository);

  Future<Either<String, Unit>> call({required List<String> listFileId}) async {
    return await repository.checkIn(listFileId: listFileId);
  }
}
