import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/log_types_entity.dart';
import 'package:internet_application/features/user/domain/repositories/log_types_repository.dart';

class GetLogTypeUseCase {
  final LogTypesRepository repository;

  GetLogTypeUseCase(this.repository);

  Future<Either<String, LogTypesEntity>> call({required String logTypeId}) async {
    return await repository.getLogType(logTypeId: logTypeId);
  }
}
