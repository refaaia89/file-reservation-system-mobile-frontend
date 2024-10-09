import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository repository;

  LogOutUseCase(this.repository);

  Future<Either<String, Unit>> call() async {
    return await repository.logOut();
  }
}
