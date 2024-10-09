import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/logs_entity.dart';
import 'package:internet_application/features/user/domain/repositories/logs_repository.dart';

class GetAllLogsUseCase {
  final LogsRepository repository;

  GetAllLogsUseCase(this.repository);

  Future<Either<String, List<LogsEntity>>> call({required int page,required int pageSize}) async {
    return await repository.getAllLogs(page: page, pageSize: pageSize);
  }
}
