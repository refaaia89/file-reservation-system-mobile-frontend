import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/permissions_entity.dart';
import 'package:internet_application/features/user/domain/repositories/permissions_repository.dart';

class UpdateCurrentPermissionUseCase {
  final PermissionsRepository repository;

  UpdateCurrentPermissionUseCase(this.repository);

  Future<Either<String, Unit>> call({required PermissionsEntity permissionsEntity, required String permissionId}) async {
    return await repository.updateCurrentPermission(permissionsEntity: permissionsEntity, permissionId: permissionId);
  }
}
