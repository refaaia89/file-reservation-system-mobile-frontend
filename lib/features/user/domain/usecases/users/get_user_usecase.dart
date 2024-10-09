import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/user_entity.dart';

import '../../repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<Either<String, UserEntity>> call({required String userId}) async {
    return await repository.getUser(userId: userId);
  }
}
