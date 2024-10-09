import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:internet_application/core/network/base_api_client.dart';
import 'package:internet_application/features/auth/data/datasource/auth_link_container.dart';
import 'package:internet_application/features/auth/data/datasource/remote_datasource/auth_remote_datasource.dart';
import 'package:internet_application/features/auth/data/models/auth_model.dart';

import '../../../../user/data/models/user_model.dart';
import '../local_datasource/auth_local_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthLocalDataSources authLocalDataSources;

  AuthRemoteDataSourceImpl({required this.authLocalDataSources});

  @override
  Future<Either<String, UserModel>> login({required String email, required String password}) async {
    return await BaseApiClient.post(
        url: AuthLinkContainer.login,
        body: {"email": email, "password": password},
        converter: (value) {
          authLocalDataSources.cachedToken(token: value['data']['token']);
          return UserModel.fromJson(value['data']);
        });
  }

  @override
  Future<Either<String, UserModel>> signUp({required AuthModel authModel}) async {
    final data = authModel.toJson();
    return await BaseApiClient.post(
        url: AuthLinkContainer.signup,
        body: data,
        converter: (value) {
          authLocalDataSources.cachedToken(token: value['data']['token']);
          return UserModel.fromJson(value['data']);
        });
  }

  @override
  Future<Either<String, Unit>> logOut() async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.post(
        token: token,
        url: AuthLinkContainer.logout,
        converter: (value) {
          authLocalDataSources.deleteCachedToken();
          return unit;
        });
  }
}
