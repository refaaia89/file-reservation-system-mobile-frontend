import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/repositories/log_types_repository.dart';

class DeleteLogTypeUseCase {
  final LogTypesRepository repository;

  DeleteLogTypeUseCase(this.repository);

  Future<Either<String, Unit>> call({required String logTypeId}) async {
    return await repository.deleteLogType(logTypeId: logTypeId);
  }
}
