import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/auth/data/models/auth_model.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/user_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/user_link_container.dart';
import 'package:internet_application/features/user/data/models/user_model.dart';

import '../../../../../core/network/base_api_client.dart';

class UserRemoteDataSourcesImpl implements UserRemoteDataSources {
  final AuthLocalDataSources authLocalDataSources;

  UserRemoteDataSourcesImpl({required this.authLocalDataSources});

  @override
  Future<Either<String, List<UserModel>>> getAllUsers({required int page, required int pageSize}) async {
    Map<String, dynamic> formData = {
      'page': page,
      'pageSize': pageSize,
    };
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: UserLinkContainer.getAllUsers,
        queryParameters: formData,
        converter: (value) {
          List<UserModel> users = UserModel.fromJsonList(value['data']);
          return users;
        });
  }

  @override
  Future<Either<String, UserModel>> getUser({required String userId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.get(
        token: token,
        url: UserLinkContainer.getUser + userId,
        converter: (value) {
          return UserModel.fromJson(value['data']);
        });
  }

  @override
  Future<Either<String, Unit>> createNewUser({
    required AuthModel authModel,
    required String roleId,
  }) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    Map<String, dynamic> formData = authModel.toJson();
    formData['role_id'] = roleId;
    return await BaseApiClient.post(
      token: token,
      url: UserLinkContainer.createNewUser,
      body: formData,
      converter: (value) {},
    );
  }

  @override
  Future<Either<String, Unit>> updateCurrentUser({
    required AuthModel authModel,
    required String roleId,
    required String userId,
  }) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    Map<String, dynamic> formData = authModel.toJson();
    formData['role_id'] = roleId;
    return await BaseApiClient.put(
      token: token,
      url: UserLinkContainer.updateCurrentUser + userId,
      body: formData,
      converter: (value) {},
    );
  }

  @override
  Future<Either<String, Unit>> deleteUser({required String userId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.delete(
      token: token,
      url: UserLinkContainer.deleteUser + userId,
      converter: (value) {},
    );
  }
}
