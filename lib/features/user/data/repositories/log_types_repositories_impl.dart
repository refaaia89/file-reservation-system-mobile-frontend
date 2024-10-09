import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/log_types_remote_datasource.dart';
import 'package:internet_application/features/user/data/models/log_types_model.dart';
import 'package:internet_application/features/user/domain/entities/log_types_entity.dart';
import 'package:internet_application/features/user/domain/repositories/log_types_repository.dart';

import '../../../../core/network/network_info.dart';

class LogTypesRepositoriesImpl extends LogTypesRepository {
  final LogTypesRemoteDataSources logTypesRemoteDataSources;
  final NetworkInfo networkInfo;

  LogTypesRepositoriesImpl({required this.logTypesRemoteDataSources, required this.networkInfo});

  @override
  Future<Either<String, Unit>> createNewLogType({required LogTypesEntity logTypesEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        LogTypesModel logTypesModel = LogTypesModel(
          logTypeId: logTypesEntity.logTypeId,
          name: logTypesEntity.name,
          createAt: logTypesEntity.createAt,
          updateAt: logTypesEntity.updateAt,
        );

        final result = await logTypesRemoteDataSources.createNewLogType(logTypesModel: logTypesModel);
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
  Future<Either<String, Unit>> deleteLogType({required String logTypeId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await logTypesRemoteDataSources.deleteLogType(logTypeId: logTypeId);
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
  Future<Either<String, List<LogTypesEntity>>> getAllLogTypes({required int page, required int pageSize}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await logTypesRemoteDataSources.getAllLogTypes(page: page, pageSize: pageSize);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<LogTypesEntity> logTypesEntityList = [];
          logTypesEntityList = r
              .map((logTypeModel) => LogTypesEntity(
                    logTypeId: logTypeModel.logTypeId,
                    name: logTypeModel.name,
                    createAt: logTypeModel.createAt,
                    updateAt: logTypeModel.updateAt,
                  ))
              .toList();
          return Right(logTypesEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, LogTypesEntity>> getLogType({required String logTypeId})async {
    if (await networkInfo.isConnected) {
      try {
        final result = await logTypesRemoteDataSources.getLogType(logTypeId: logTypeId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (logTypeModel) {
          LogTypesEntity logTypesEntity = LogTypesEntity(
            logTypeId: logTypeModel.logTypeId,
            name: logTypeModel.name,
            createAt: logTypeModel.createAt,
            updateAt: logTypeModel.updateAt,
          );
          return Right(logTypesEntity);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> updateCurrentLogType({required LogTypesEntity logTypesEntity, required String logTypeId}) async {
    if (await networkInfo.isConnected) {
      try {
        LogTypesModel logTypesModel = LogTypesModel(
          logTypeId: logTypesEntity.logTypeId,
          name: logTypesEntity.name,
          createAt: logTypesEntity.createAt,
          updateAt: logTypesEntity.updateAt,
        );

        final result = await logTypesRemoteDataSources.updateCurrentLogType(logTypesModel: logTypesModel, logTypeId: logTypeId);
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
