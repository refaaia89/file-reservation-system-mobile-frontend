import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/reports_remote_datasource.dart';
import 'package:internet_application/features/user/domain/entities/reports_entity.dart';
import 'package:internet_application/features/user/domain/repositories/reports_repository.dart';

import '../../../../core/network/network_info.dart';

class ReportsRepositoriesImpl extends ReportsRepository {
  final ReportsRemoteDataSource reportsRemoteDataSource;
  final NetworkInfo networkInfo;

  ReportsRepositoriesImpl({required this.reportsRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByFileIdReports({required String fileId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await reportsRemoteDataSource.getAllCheckProcessByFileIdReports(fileId: fileId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<ReportsEntity> reportsEntityList = [];
          reportsEntityList = r
              .map((reportsModel) => ReportsEntity(
                    checkProcessId: reportsModel.checkProcessId,
                    checkedInAt: reportsModel.checkedInAt,
                    checkedOutAt: reportsModel.checkedOutAt,
                    userEntity: reportsModel.userEntity,
                    fileEntity: reportsModel.fileEntity,
                    createdAt: reportsModel.createdAt,
                    updatedAt: reportsModel.updatedAt,
                    checkedOutAtTime: reportsModel.checkedOutAtTime,
                  ))
              .toList();
          return Right(reportsEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByGroupIdReports({required String groupId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await reportsRemoteDataSource.getAllCheckProcessByGroupIdReports(groupId: groupId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<ReportsEntity> reportsEntityList = [];
          reportsEntityList = r
              .map((reportsModel) => ReportsEntity(
            checkProcessId: reportsModel.checkProcessId,
            checkedInAt: reportsModel.checkedInAt,
            checkedOutAt: reportsModel.checkedOutAt,
            userEntity: reportsModel.userEntity,
            fileEntity: reportsModel.fileEntity,
            createdAt: reportsModel.createdAt,
            updatedAt: reportsModel.updatedAt,
            checkedOutAtTime: reportsModel.checkedOutAtTime,
          ))
              .toList();
          return Right(reportsEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByIsCheckedOutAtTimeIsFalse() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await reportsRemoteDataSource.getAllCheckProcessByIsCheckedOutAtTimeIsFalse();
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<ReportsEntity> reportsEntityList = [];
          reportsEntityList = r
              .map((reportsModel) => ReportsEntity(
            checkProcessId: reportsModel.checkProcessId,
            checkedInAt: reportsModel.checkedInAt,
            checkedOutAt: reportsModel.checkedOutAt,
            userEntity: reportsModel.userEntity,
            fileEntity: reportsModel.fileEntity,
            createdAt: reportsModel.createdAt,
            updatedAt: reportsModel.updatedAt,
            checkedOutAtTime: reportsModel.checkedOutAtTime,
          ))
              .toList();
          return Right(reportsEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByIsCheckedOutAtTimeIsTrued() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await reportsRemoteDataSource.getAllCheckProcessByIsCheckedOutAtTimeIsTrued();
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<ReportsEntity> reportsEntityList = [];
          reportsEntityList = r
              .map((reportsModel) => ReportsEntity(
            checkProcessId: reportsModel.checkProcessId,
            checkedInAt: reportsModel.checkedInAt,
            checkedOutAt: reportsModel.checkedOutAt,
            userEntity: reportsModel.userEntity,
            fileEntity: reportsModel.fileEntity,
            createdAt: reportsModel.createdAt,
            updatedAt: reportsModel.updatedAt,
            checkedOutAtTime: reportsModel.checkedOutAtTime,
          ))
              .toList();
          return Right(reportsEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByUserIdReports({required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await reportsRemoteDataSource.getAllCheckProcessByUserIdReports(userId: userId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<ReportsEntity> reportsEntityList = [];
          reportsEntityList = r
              .map((reportsModel) => ReportsEntity(
            checkProcessId: reportsModel.checkProcessId,
            checkedInAt: reportsModel.checkedInAt,
            checkedOutAt: reportsModel.checkedOutAt,
            userEntity: reportsModel.userEntity,
            fileEntity: reportsModel.fileEntity,
            createdAt: reportsModel.createdAt,
            updatedAt: reportsModel.updatedAt,
            checkedOutAtTime: reportsModel.checkedOutAtTime,
          ))
              .toList();
          return Right(reportsEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }
  @override
  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessReports() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await reportsRemoteDataSource.getAllCheckProcessReports();
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<ReportsEntity> reportsEntityList = [];
          reportsEntityList = r
              .map((reportsModel) => ReportsEntity(
            checkProcessId: reportsModel.checkProcessId,
            checkedInAt: reportsModel.checkedInAt,
            checkedOutAt: reportsModel.checkedOutAt,
            userEntity: reportsModel.userEntity,
            fileEntity: reportsModel.fileEntity,
            createdAt: reportsModel.createdAt,
            updatedAt: reportsModel.updatedAt,
            checkedOutAtTime: reportsModel.checkedOutAtTime,
          ))
              .toList();
          return Right(reportsEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }
}
