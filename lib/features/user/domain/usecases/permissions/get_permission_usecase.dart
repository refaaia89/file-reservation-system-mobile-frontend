import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/permissions_entity.dart';
import 'package:internet_application/features/user/domain/repositories/permissions_repository.dart';

class GetPermissionUseCase {
  final PermissionsRepository repository;

  GetPermissionUseCase(this.repository);

  Future<Either<String, PermissionsEntity>> call({required String permissionId}) async {
    return await repository.getPermission(permissionId: permissionId);
  }
}
