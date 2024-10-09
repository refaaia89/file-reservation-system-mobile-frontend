import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/log_types_entity.dart';
import 'package:internet_application/features/user/domain/repositories/log_types_repository.dart';

class UpdateCurrentLogTypeUseCase {
  final LogTypesRepository repository;

  UpdateCurrentLogTypeUseCase(this.repository);

  Future<Either<String, Unit>> call({required LogTypesEntity logTypesEntity, required String logTypeId}) async {
    return await repository.updateCurrentLogType(logTypesEntity: logTypesEntity, logTypeId: logTypeId);
  }
}
