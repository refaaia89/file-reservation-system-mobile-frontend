import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/data/datasource/log_types_link_container.dart';
import 'package:internet_application/features/user/data/models/log_types_model.dart';

import '../../../../../core/network/base_api_client.dart';
import 'log_types_remote_datasource.dart';

class LogTypesRemoteDataSourceImpl implements LogTypesRemoteDataSources {
  final AuthLocalDataSources authLocalDataSources;

  LogTypesRemoteDataSourceImpl({required this.authLocalDataSources});

  @override
  Future<Either<String, Unit>> createNewLogType({required LogTypesModel logTypesModel}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.post(
        token: token,
        url: LogTypesLinkContainer.createNewLogType,
        body: logTypesModel.toJson(),
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> deleteLogType({required String logTypeId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.delete(
        token: token,
        url: LogTypesLinkContainer.deleteLogType + logTypeId,
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, List<LogTypesModel>>> getAllLogTypes({required int page, required int pageSize}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    Map<String, dynamic> formData = {
      'page': page,
      'pageSize': pageSize,
    };
    return await BaseApiClient.get(
        token: token,
        url: LogTypesLinkContainer.getAllLogTypes,
        queryParameters: formData,
        converter: (value) {
          List<LogTypesModel> logTypes = LogTypesModel.fromJsonList(value['data']);
          return logTypes;
        });
  }

  @override
  Future<Either<String, LogTypesModel>> getLogType({required String logTypeId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: LogTypesLinkContainer.getLogType + logTypeId,
        converter: (value) {
          return LogTypesModel.fromJson(value['data']);
        });
  }

  @override
  Future<Either<String, Unit>> updateCurrentLogType({required LogTypesModel logTypesModel, required String logTypeId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.put(
        token: token,
        url: LogTypesLinkContainer.updateCurrentLogType + logTypeId,
        body: logTypesModel.toJson(),
        converter: (value) {
          return unit;
        });
  }
}
