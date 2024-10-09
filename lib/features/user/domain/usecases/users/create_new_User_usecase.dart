import 'package:dartz/dartz.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';

import '../../repositories/user_repository.dart';

class CreateNewUserUseCase {
  final UserRepository repository;

  CreateNewUserUseCase(this.repository);

  Future<Either<String, Unit>> call({required AuthEntity authEntity,required String roleId}) async {
    return await repository.createNewUser(authEntity: authEntity, roleId: roleId);
  }
}
