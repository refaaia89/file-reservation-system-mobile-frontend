import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/roles_entity.dart';
import 'package:internet_application/features/user/domain/repositories/roles_repository.dart';

class GetRoleUseCase {
  final RolesRepository repository;

  GetRoleUseCase(this.repository);

  Future<Either<String, RolesEntity>> call({required String roleId}) async {
    return await repository.getRole(roleId: roleId);
  }
}
