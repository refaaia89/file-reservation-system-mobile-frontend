import 'package:dartz/dartz.dart';

import '../../../../user/data/models/user_model.dart';

abstract class AuthLocalDataSources {
  Future<Unit> cachedUser({required UserModel userModel});

  Future<Unit> cachedToken({required String token});

  UserModel? getCachedUser();

  String? getCachedToken();

  Future<Unit> deleteCachedUser();

  Future<Unit> deleteCachedToken();
}
