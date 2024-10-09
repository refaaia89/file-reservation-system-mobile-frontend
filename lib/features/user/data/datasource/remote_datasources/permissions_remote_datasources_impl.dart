import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/permissions_remote_datasource.dart';

import '../../../../../core/network/base_api_client.dart';
import '../../models/permissions_model.dart';
import '../permissions_link_container.dart';

class PermissionsRemoteDataSourceImpl implements PermissionsRemoteDataSources {
  final AuthLocalDataSources authLocalDataSources;

  PermissionsRemoteDataSourceImpl({required this.authLocalDataSources});

  @override
  Future<Either<String, Unit>> createNewPermission({required PermissionsModel permissionsModel}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.post(
        token: token,
        url: PermissionsLinkContainer.createNewPermission,
        body: permissionsModel.toJson(),
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> deletePermission({required String permissionId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.delete(
        token: token,
        url: PermissionsLinkContainer.deletePermission + permissionId,
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, List<PermissionsModel>>> getAllPermissions({required int page, required int pageSize}) async {
    Map<String, dynamic> formData = {
      'page': page,
      'pageSize': pageSize,
    };
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: PermissionsLinkContainer.getAllPermissions,
        queryParameters: formData,
        converter: (value) {
          List<PermissionsModel> permissions = PermissionsModel.fromJsonList(value['data']);
          return permissions;
        });
  }

  @override
  Future<Either<String, PermissionsModel>> getPermission({required String permissionId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: PermissionsLinkContainer.getPermission + permissionId,
        converter: (value) {
          return PermissionsModel.fromJson(value['data']);
        });
  }

  @override
  Future<Either<String, Unit>> updateCurrentPermission({required PermissionsModel permissionsModel, required String permissionId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.put(
        token: token,
        url: PermissionsLinkContainer.updateCurrentPermission + permissionId,
        body: permissionsModel.toJson(),
        converter: (value) {
          return unit;
        });
  }
}
