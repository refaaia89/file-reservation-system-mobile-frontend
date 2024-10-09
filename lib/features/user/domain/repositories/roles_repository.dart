import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/roles_entity.dart';

abstract class RolesRepository {
  Future<Either<String, Unit>> createNewRole({required RolesEntity rolesEntity});

  Future<Either<String, Unit>> deleteRole({required String roleId});

  Future<Either<String, List<RolesEntity>>> getAllRoles({required int page, required int pageSize});

  Future<Either<String, RolesEntity>> getRole({required String roleId});

  Future<Either<String, Unit>> updateCurrentRole({required RolesEntity rolesEntity, required String roleId});
}
