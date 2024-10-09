
import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/models/logs_model.dart';

abstract class LogsRemoteDataSources{
  Future<Either<String, List<LogsModel>>> getAllLogs({required int page, required int pageSize});

  Future<Either<String, LogsModel>> getLog({required String logId});
}