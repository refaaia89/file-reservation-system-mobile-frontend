import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/models/auth_model.dart';
import 'package:internet_application/features/user/data/models/user_model.dart';

import '../../../domain/entities/group_entity.dart';
import '../../../domain/entities/user_entity.dart';

abstract class UserRemoteDataSources {
  Future<Either<String, List<UserModel>>> getAllUsers({required int page, required int pageSize});

  Future<Either<String, UserModel>> getUser({required String userId});

  Future<Either<String, Unit>> createNewUser({required AuthModel authModel, required String roleId});

  Future<Either<String, Unit>> updateCurrentUser({required AuthModel authModel, required String roleId, required String userId});

  Future<Either<String, Unit>> deleteUser({required String userId});
}
