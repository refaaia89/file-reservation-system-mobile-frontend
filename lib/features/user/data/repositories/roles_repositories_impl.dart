import 'package:dartz/dartz.dart';
import 'package:internet_application/core/network/network_info.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/roles_remote_datasource.dart';
import 'package:internet_application/features/user/data/models/roles_%20model.dart';
import 'package:internet_application/features/user/domain/entities/roles_entity.dart';
import 'package:internet_application/features/user/domain/repositories/roles_repository.dart';

class RolesRepositoriesImpl extends RolesRepository {
  final RolesRemoteDataSources rolesRemoteDataSources;
  final NetworkInfo networkInfo;

  RolesRepositoriesImpl({required this.rolesRemoteDataSources, required this.networkInfo});

  @override
  Future<Either<String, Unit>> createNewRole({required RolesEntity rolesEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        RolesModel rolesModel = RolesModel(
          roleId: rolesEntity.roleId,
          name: rolesEntity.name,
          createAt: rolesEntity.createAt,
          updateAt: rolesEntity.updateAt,
        );

        final result = await rolesRemoteDataSources.createNewRole(rolesModel: rolesModel);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> deleteRole({required String roleId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await rolesRemoteDataSources.deleteRole(roleId: roleId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, List<RolesEntity>>> getAllRoles({required int page, required int pageSize}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await rolesRemoteDataSources.getAllRoles(page: page, pageSize: pageSize);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<RolesEntity> rolesEntityList = [];
          rolesEntityList = r
              .map((rolesModel) => RolesEntity(
                    roleId: rolesModel.roleId,
                    name: rolesModel.name,
                    createAt: rolesModel.createAt,
                    updateAt: rolesModel.updateAt,
                  ))
              .toList();
          return Right(rolesEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, RolesEntity>> getRole({required String roleId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await rolesRemoteDataSources.getRole(roleId: roleId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (rolesModel) {
          RolesEntity rolesEntity = RolesEntity(
            roleId: rolesModel.roleId,
            name: rolesModel.name,
            createAt: rolesModel.createAt,
            updateAt: rolesModel.updateAt,
          );
          return Right(rolesEntity);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> updateCurrentRole({required RolesEntity rolesEntity, required String roleId}) async {
    if (await networkInfo.isConnected) {
      try {
        RolesModel rolesModel = RolesModel(
          roleId: rolesEntity.roleId,
          name: rolesEntity.name,
          createAt: rolesEntity.createAt,
          updateAt: rolesEntity.updateAt,
        );

        final result = await rolesRemoteDataSources.updateCurrentRole(rolesModel: rolesModel, roleId: roleId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }
}
