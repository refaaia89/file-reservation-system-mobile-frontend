import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';

import '../entities/group_entity.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<String, List<UserEntity>>> getAllUsers({required int page, required int pageSize});

  Future<Either<String, UserEntity>> getUser({required String userId});

  Future<Either<String, Unit>> createNewUser({required AuthEntity authEntity, required String roleId});

  Future<Either<String, Unit>> updateCurrentUser({required AuthEntity authEntity, required String roleId, required String userId});

  Future<Either<String, Unit>> deleteUser({required String userId});
}
