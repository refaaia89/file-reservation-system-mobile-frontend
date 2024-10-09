import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/log_types_entity.dart';
import 'package:internet_application/features/user/domain/repositories/log_types_repository.dart';

class GetAllLogTypesUseCase {
  final LogTypesRepository repository;

  GetAllLogTypesUseCase(this.repository);

  Future<Either<String, List<LogTypesEntity>>> call({required int page,required int pageSize}) async {
    return await repository.getAllLogTypes(page: page, pageSize: pageSize);
  }
}
