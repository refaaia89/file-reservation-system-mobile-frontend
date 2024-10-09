import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/logs_entity.dart';
import 'package:internet_application/features/user/domain/repositories/logs_repository.dart';

class GetLogUseCase {
  final LogsRepository repository;

  GetLogUseCase(this.repository);

  Future<Either<String, LogsEntity>> call({required String logId}) async {
    return await repository.getLog(logId: logId);
  }
}
