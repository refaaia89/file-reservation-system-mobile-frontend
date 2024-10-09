import 'package:dartz/dartz.dart';

import '../../repositories/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository repository;

  DeleteUserUseCase(this.repository);

  Future<Either<String, Unit>> call({required String userId}) async {
    return await repository.deleteUser(userId: userId);
  }
}
