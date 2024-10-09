import 'package:dartz/dartz.dart';
import 'package:internet_application/core/network/network_info.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/permissions_remote_datasource.dart';
import 'package:internet_application/features/user/data/models/permissions_model.dart';
import 'package:internet_application/features/user/domain/entities/permissions_entity.dart';
import 'package:internet_application/features/user/domain/repositories/permissions_repository.dart';

class PermissionsRepositoriesImpl extends PermissionsRepository {
  final PermissionsRemoteDataSources permissionsRemoteDataSources;
  final NetworkInfo networkInfo;

  PermissionsRepositoriesImpl({required this.permissionsRemoteDataSources, required this.networkInfo});

  @override
  Future<Either<String, Unit>> createNewPermission({required PermissionsEntity permissionsEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        PermissionsModel permissionsModel = PermissionsModel(
          permissionId: permissionsEntity.permissionId,
          name: permissionsEntity.name,
          description: permissionsEntity.description,
          createdAt: permissionsEntity.createdAt,
          updatedAt: permissionsEntity.updatedAt,
        );

        final result = await permissionsRemoteDataSources.createNewPermission(permissionsModel: permissionsModel);
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
  Future<Either<String, Unit>> deletePermission({required String permissionId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await permissionsRemoteDataSources.deletePermission(permissionId: permissionId);
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
  Future<Either<String, List<PermissionsEntity>>> getAllPermissions({required int page, required int pageSize}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await permissionsRemoteDataSources.getAllPermissions(page: page, pageSize: pageSize);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<PermissionsEntity> permissionsEntityList = [];
          permissionsEntityList = r
              .map((permissionsModel) => PermissionsEntity(
                    permissionId: permissionsModel.permissionId,
                    name: permissionsModel.name,
                    description: permissionsModel.description,
                    createdAt: permissionsModel.createdAt,
                    updatedAt: permissionsModel.updatedAt,
                  ))
              .toList();
          return Right(permissionsEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, PermissionsEntity>> getPermission({required String permissionId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await permissionsRemoteDataSources.getPermission(permissionId: permissionId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (permissionsModel) {
          PermissionsEntity permissionsEntity = PermissionsEntity(
            permissionId: permissionsModel.permissionId,
            name: permissionsModel.name,
            description: permissionsModel.description,
            createdAt: permissionsModel.createdAt,
            updatedAt: permissionsModel.updatedAt,
          );
          return Right(permissionsEntity);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> updateCurrentPermission({required PermissionsEntity permissionsEntity, required String permissionId}) async {
    if (await networkInfo.isConnected) {
      try {
        PermissionsModel permissionsModel = PermissionsModel(
          permissionId: permissionsEntity.permissionId,
          name: permissionsEntity.name,
          description: permissionsEntity.description,
          createdAt: permissionsEntity.createdAt,
          updatedAt: permissionsEntity.updatedAt,
        );

        final result = await permissionsRemoteDataSources.updateCurrentPermission(permissionsModel: permissionsModel, permissionId: permissionId);
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
