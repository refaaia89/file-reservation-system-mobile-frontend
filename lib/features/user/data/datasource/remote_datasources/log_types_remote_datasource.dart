import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/models/log_types_model.dart';

abstract class LogTypesRemoteDataSources {
  Future<Either<String, Unit>> createNewLogType({required LogTypesModel logTypesModel});

  Future<Either<String, Unit>> deleteLogType({required String logTypeId});

  Future<Either<String, List<LogTypesModel>>> getAllLogTypes({required int page, required int pageSize});

  Future<Either<String, LogTypesModel>> getLogType({required String logTypeId});

  Future<Either<String, Unit>> updateCurrentLogType({required LogTypesModel logTypesModel, required String logTypeId});
}
