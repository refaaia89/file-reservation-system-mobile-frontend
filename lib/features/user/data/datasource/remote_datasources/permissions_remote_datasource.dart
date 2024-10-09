import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/models/permissions_model.dart';

abstract class PermissionsRemoteDataSources{
  Future<Either<String, Unit>> createNewPermission({required PermissionsModel permissionsModel});

  Future<Either<String, Unit>> deletePermission({required String permissionId});

  Future<Either<String, List<PermissionsModel>>> getAllPermissions({required int page, required int pageSize});

  Future<Either<String, PermissionsModel>> getPermission({required String permissionId});

  Future<Either<String, Unit>> updateCurrentPermission({required PermissionsModel permissionsModel, required String permissionId});

}