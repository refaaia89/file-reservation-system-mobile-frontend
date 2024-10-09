import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/roles_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/roles_link_container.dart';
import 'package:internet_application/features/user/data/models/roles_%20model.dart';

import '../../../../../core/network/base_api_client.dart';

class RolesRemoteDataSourcesImpl implements RolesRemoteDataSources {
  final AuthLocalDataSources authLocalDataSources;

  RolesRemoteDataSourcesImpl({required this.authLocalDataSources});

  @override
  Future<Either<String, Unit>> createNewRole({required RolesModel rolesModel}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.post(
        token: token,
        url: RolesLinkContainer.createNewRole,
        body: rolesModel.toJson(),
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> deleteRole({required String roleId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.delete(
        token: token,
        url: RolesLinkContainer.deleteRole + roleId,
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, List<RolesModel>>> getAllRoles({required int page, required int pageSize}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    Map<String, dynamic> formData = {
      'page': page,
      'pageSize': pageSize,
    };
    return await BaseApiClient.get(
        token: token,
        url: RolesLinkContainer.getAllRoles,
        queryParameters: formData,
        converter: (value) {
          List<RolesModel> roles = RolesModel.fromJsonList(value['data']);
          return roles;
        });
  }

  @override
  Future<Either<String, RolesModel>> getRole({required String roleId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: RolesLinkContainer.getRole + roleId,
        converter: (value) {
          return RolesModel.fromJson(value['data']);
        });
  }

  @override
  Future<Either<String, Unit>> updateCurrentRole({required RolesModel rolesModel, required String roleId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.put(
        token: token,
        url: RolesLinkContainer.updateCurrentRole + roleId,
        body: rolesModel.toJson(),
        converter: (value) {
          return unit;
        });
  }
}
