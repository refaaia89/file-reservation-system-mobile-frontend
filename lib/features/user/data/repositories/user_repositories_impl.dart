import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/models/auth_model.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/remote_datasources/user_remote_datasource.dart';

class UserRepositoriesImpl implements UserRepository {
  final UserRemoteDataSources userRemoteDataSources;
  final NetworkInfo networkInfo;

  UserRepositoriesImpl({required this.userRemoteDataSources, required this.networkInfo});

  @override
  Future<Either<String, List<UserEntity>>> getAllUsers({required int page, required int pageSize}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await userRemoteDataSources.getAllUsers(page: page, pageSize: pageSize);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<UserEntity> userEntityList = [];
          userEntityList = r
              .map((userModel) => UserEntity(
                    id: userModel.id,
                    email: userModel.email,
                    userName: userModel.userName,
                    role: userModel.role,
                  ))
              .toList();
          return Right(userEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, UserEntity>> getUser({required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await userRemoteDataSources.getUser(userId: userId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (userModel) {
          UserEntity userEntity = UserEntity(
            id: userModel.id,
            email: userModel.email,
            userName: userModel.userName,
            role: userModel.role,
          );
          return Right(userEntity);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> createNewUser({required AuthEntity authEntity, required String roleId}) async {
    if (await networkInfo.isConnected) {
      try {
        AuthModel authModel = AuthModel(userName: authEntity.userName, email: authEntity.email, password: authEntity.password);
        final result = await userRemoteDataSources.createNewUser(authModel: authModel, roleId: roleId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> updateCurrentUser({required AuthEntity authEntity, required String roleId, required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        AuthModel authModel = AuthModel(userName: authEntity.userName, email: authEntity.email, password: authEntity.password);
        final result = await userRemoteDataSources.updateCurrentUser(authModel: authModel, roleId: roleId, userId: userId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> deleteUser({required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await userRemoteDataSources.deleteUser(userId: userId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }
}
