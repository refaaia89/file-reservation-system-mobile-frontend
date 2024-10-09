import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/data/models/auth_model.dart';

import '../../../../user/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String, UserModel>> signUp({required AuthModel authModel});

  Future<Either<String, UserModel>> login({required String email, required String password});

  Future<Either<String, Unit>> logOut();
}
