import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/logs_entity.dart';
import 'package:internet_application/features/user/domain/repositories/logs_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasource/remote_datasources/logs_remote_datasource.dart';

class LogsRepositoriesImpl extends LogsRepository {
  final LogsRemoteDataSources logsRemoteDataSources;
  final NetworkInfo networkInfo;

  LogsRepositoriesImpl({required this.logsRemoteDataSources, required this.networkInfo});

  @override
  Future<Either<String, List<LogsEntity>>> getAllLogs({required int page, required int pageSize}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await logsRemoteDataSources.getAllLogs(page: page, pageSize: pageSize);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<LogsEntity> logsEntityList = [];
          logsEntityList = r
              .map((logsModel) => LogsEntity(
                    logId: logsModel.logId,
                    name: logsModel.name,
                  ))
              .toList();
          return Right(logsEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, LogsEntity>> getLog({required String logId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await logsRemoteDataSources.getLog(logId: logId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (logsModel) {
          LogsEntity logsEntity = LogsEntity(
            logId: logsModel.logId,
            name: logsModel.name,
          );
          return Right(logsEntity);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }
}
