import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/repositories/roles_repository.dart';

class DeleteRoleUseCase {
  final RolesRepository repository;

 DeleteRoleUseCase(this.repository);

  Future<Either<String, Unit>> call({required String roleId}) async {
    return await repository.deleteRole(roleId: roleId);
  }
}
