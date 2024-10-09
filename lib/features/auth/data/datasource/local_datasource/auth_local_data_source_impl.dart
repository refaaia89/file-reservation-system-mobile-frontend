import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/strings/cached.dart';
import '../../../../user/data/models/user_model.dart';
import 'auth_local_datasource.dart';

class AuthLocalDataSourcesImpl implements AuthLocalDataSources {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachedUser({required UserModel userModel}) async {
    final userModelToJson = userModel.toJson();
    await sharedPreferences.setString(CACHED_USER, json.encode(userModelToJson));

    return Future.value(unit);
  }

  @override
  UserModel? getCachedUser() {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      final decodeJsonData = json.decode(jsonString);
      UserModel jsonToUserModel = UserModel.fromJson(decodeJsonData);
      return jsonToUserModel;
    }
    return null;
  }

  @override
  Future<Unit> deleteCachedUser() async {
    await sharedPreferences.remove(CACHED_USER);
    return Future.value(unit);
  }

  @override
  Future<Unit> cachedToken({required String token}) async {
    sharedPreferences.setString(CACHED_TOKEN, token);

    return Future.value(unit);
  }

  @override
  Future<Unit> deleteCachedToken() async {
    await sharedPreferences.remove(CACHED_TOKEN);
    return Future.value(unit);
  }

  @override
  String? getCachedToken() {
    final jsonString = sharedPreferences.getString(CACHED_TOKEN);
    if (jsonString != null) {
      return jsonString;
    } else {
      return null;
    }
  }
}
