import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/log_types_entity.dart';
import 'package:internet_application/features/user/domain/repositories/log_types_repository.dart';

class CreateNewLogTypeUseCase {
  final LogTypesRepository repository;

  CreateNewLogTypeUseCase(this.repository);

  Future<Either<String, Unit>> call({required LogTypesEntity logTypesEntity}) async {
    return await repository.createNewLogType(logTypesEntity: logTypesEntity);
  }
}
