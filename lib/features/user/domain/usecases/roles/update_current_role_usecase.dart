import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/roles_entity.dart';
import 'package:internet_application/features/user/domain/repositories/roles_repository.dart';

class UpdateCurrentRoleUseCase {
  final RolesRepository repository;

  UpdateCurrentRoleUseCase(this.repository);

  Future<Either<String, Unit>> call({required RolesEntity rolesEntity,required String roleId}) async {
    return await repository.updateCurrentRole(rolesEntity: rolesEntity, roleId: roleId);
  }
}
