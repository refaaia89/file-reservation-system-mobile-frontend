import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<String, Unit>> signup({required AuthEntity authEntity});

  Future<Either<String, Unit>> login({
    required String email,
    required String password,
  });

  Future<Either<String, Unit>> logOut();
}
