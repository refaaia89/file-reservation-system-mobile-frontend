import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/logs_entity.dart';

abstract class LogsRepository {
  Future<Either<String, List<LogsEntity>>> getAllLogs({required int page, required int pageSize});

  Future<Either<String, LogsEntity>> getLog({required String logId});
}
