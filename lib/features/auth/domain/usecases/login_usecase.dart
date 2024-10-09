import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, Unit>> call({required String email, required String password}) async {
    return await repository.login(email: email, password: password);
  }
}
