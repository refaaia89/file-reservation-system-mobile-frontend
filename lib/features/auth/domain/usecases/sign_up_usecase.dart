import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';

import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<String, Unit>> call({required AuthEntity authEntity}) {
    return repository.signup(authEntity: authEntity);
  }
}
