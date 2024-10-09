import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';

import '../../repositories/user_repository.dart';

class UpdateCurrentUserUseCase {
  final UserRepository repository;

  UpdateCurrentUserUseCase(this.repository);

  Future<Either<String, Unit>> call({required AuthEntity authEntity,required String roleId,required String userId}) async {
    return await repository.updateCurrentUser(authEntity: authEntity, roleId: roleId,userId: userId);
  }
}
