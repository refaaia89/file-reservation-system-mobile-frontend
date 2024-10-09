import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/reports_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/reports_link_container.dart';
import 'package:internet_application/features/user/data/models/reports_model.dart';

import '../../../../../core/network/base_api_client.dart';

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource{
  final AuthLocalDataSources authLocalDataSources;

  ReportsRemoteDataSourceImpl({required this.authLocalDataSources});
  @override
  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByFileIdReports({required String fileId}) async{
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: ReportsLinkContainer.getAllCheckProcessByFileIdReports+fileId,
        converter: (value) {
          List<ReportsModel> reports = ReportsModel.fromJsonList(value['data']);
          return reports;
        });
  }

  @override
  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByGroupIdReports({required String groupId}) async{
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: ReportsLinkContainer.getAllCheckProcessByGroupIdReports+groupId,
        converter: (value) {
          List<ReportsModel> reports = ReportsModel.fromJsonList(value['data']);
          return reports;
        });
  }

  @override
  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByIsCheckedOutAtTimeIsFalse() async{
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: ReportsLinkContainer.getAllCheckProcessByIsCheckedOutAtTimeIsFalse,
        converter: (value) {
          List<ReportsModel> reports = ReportsModel.fromJsonList(value['data']);
          return reports;
        });
  }

  @override
  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByIsCheckedOutAtTimeIsTrued() async{
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: ReportsLinkContainer.getAllCheckProcessByIsCheckedOutAtTimeIsTrued,
        converter: (value) {
          List<ReportsModel> reports = ReportsModel.fromJsonList(value['data']);
          return reports;
        });
  }

  @override
  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByUserIdReports({required String userId}) async{
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: ReportsLinkContainer.getAllCheckProcessByUserIdReports+userId,
        converter: (value) {
          List<ReportsModel> reports = ReportsModel.fromJsonList(value['data']);
          return reports;
        });
  }

  @override
  Future<Either<String, List<ReportsModel>>> getAllCheckProcessReports() async{
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: ReportsLinkContainer.getAllCheckProcessReports,
        converter: (value) {
          List<ReportsModel> reports = ReportsModel.fromJsonList(value['data']);
          return reports;
        });
  }
}