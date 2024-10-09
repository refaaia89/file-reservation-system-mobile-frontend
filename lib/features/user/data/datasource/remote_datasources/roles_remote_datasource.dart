import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/models/roles_%20model.dart';

abstract class RolesRemoteDataSources{
  Future<Either<String, Unit>> createNewRole({required RolesModel rolesModel});

  Future<Either<String, Unit>> deleteRole({required String roleId});

  Future<Either<String, List<RolesModel>>> getAllRoles({required int page, required int pageSize});

  Future<Either<String, RolesModel>> getRole({required String roleId});

  Future<Either<String, Unit>> updateCurrentRole({required RolesModel rolesModel, required String roleId});
}