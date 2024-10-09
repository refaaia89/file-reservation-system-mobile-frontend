import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/log_types_entity.dart';

abstract class LogTypesRepository {
  Future<Either<String, Unit>> createNewLogType({required LogTypesEntity logTypesEntity});

  Future<Either<String, Unit>> deleteLogType({required String logTypeId});

  Future<Either<String, List<LogTypesEntity>>> getAllLogTypes({required int page, required int pageSize});

  Future<Either<String, LogTypesEntity>> getLogType({required String logTypeId});

  Future<Either<String, Unit>> updateCurrentLogType({required LogTypesEntity logTypesEntity, required String logTypeId});
}
