import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/models/auth_model.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';
import 'package:internet_application/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/network/network_info.dart';
import '../datasource/local_datasource/auth_local_datasource.dart';
import '../datasource/remote_datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSources localDataSources;
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.localDataSources, required this.authRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<String, Unit>> login({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authRemoteDataSource.login(email: email, password: password);
        return result.fold((l) {
          return Left(l);
        }, (r) {
          localDataSources.cachedUser(userModel: r);
          localDataSources.cachedToken(token: r.token!);
          return const Right(unit);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> signup({required AuthEntity authEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await authRemoteDataSource.signUp(authModel: AuthModel(userName: authEntity.userName, email: authEntity.email, password: authEntity.password));
        return result.fold((l) {
          return Left(l);
        }, (r) {
          localDataSources.cachedUser(userModel: r);
          return const Right(unit);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authRemoteDataSource.logOut();
        return result.fold((l) {
          return Left(l);
        }, (r) {
          localDataSources.deleteCachedToken();
          return const Right(unit);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }
}
