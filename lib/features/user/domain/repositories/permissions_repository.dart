import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/permissions_entity.dart';

abstract class PermissionsRepository {
  Future<Either<String, Unit>> createNewPermission({required PermissionsEntity permissionsEntity});

  Future<Either<String, Unit>> deletePermission({required String permissionId});

  Future<Either<String, List<PermissionsEntity>>> getAllPermissions({required int page, required int pageSize});

  Future<Either<String, PermissionsEntity>> getPermission({required String permissionId});

  Future<Either<String, Unit>> updateCurrentPermission({required PermissionsEntity permissionsEntity, required String permissionId});
}
