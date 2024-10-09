import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/repositories/permissions_repository.dart';

class DeletePermissionUseCase {
  final PermissionsRepository repository;

  DeletePermissionUseCase(this.repository);

  Future<Either<String, Unit>> call({required String permissionId}) async {
    return await repository.deletePermission(permissionId: permissionId);
  }
}
