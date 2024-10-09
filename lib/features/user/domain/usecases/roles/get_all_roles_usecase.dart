import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/roles_entity.dart';
import 'package:internet_application/features/user/domain/repositories/roles_repository.dart';

class GetAllRolesUseCase {
  final RolesRepository repository;

  GetAllRolesUseCase(this.repository);

  Future<Either<String, List<RolesEntity>>> call({required int page,required int pageSize}) async {
    return await repository.getAllRoles(page: page, pageSize: pageSize);
  }
}
