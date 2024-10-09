import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/data/datasource/logs_link_container.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/logs_remote_datasource.dart';
import 'package:internet_application/features/user/data/models/logs_model.dart';

import '../../../../../core/network/base_api_client.dart';

class LogsRemoteDataSourcesImpl implements LogsRemoteDataSources {
  final AuthLocalDataSources authLocalDataSources;

  LogsRemoteDataSourcesImpl({required this.authLocalDataSources});

  @override
  Future<Either<String, List<LogsModel>>> getAllLogs({required int page, required int pageSize}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    Map<String, dynamic> formData = {
      'page': page,
      'pageSize': pageSize,
    };
    return await BaseApiClient.get(
        token: token,
        url: LogsLinkContainer.getAllLogs,
        queryParameters: formData,
        converter: (value) {
          List<LogsModel> logTypes = LogsModel.fromJsonList(value['data']);
          return logTypes;
        });
  }

  @override
  Future<Either<String, LogsModel>> getLog({required String logId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: LogsLinkContainer.getLog + logId,
        converter: (value) {
          return LogsModel.fromJson(value['data']);
        });
  }
}
