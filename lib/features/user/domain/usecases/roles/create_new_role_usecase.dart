import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/roles_entity.dart';
import 'package:internet_application/features/user/domain/repositories/roles_repository.dart';

class CreateNewRoleUseCase {
  final RolesRepository repository;

  CreateNewRoleUseCase(this.repository);

  Future<Either<String, Unit>> call({required RolesEntity rolesEntity}) async {
    return await repository.createNewRole(rolesEntity: rolesEntity);
  }
}
