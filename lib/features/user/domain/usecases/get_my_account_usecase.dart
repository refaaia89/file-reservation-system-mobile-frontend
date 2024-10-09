import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../repositories/group_repository.dart';

class GetMyAccountUseCase {
  final GroupRepository repository;

  GetMyAccountUseCase(this.repository);

  Future<Either<String, UserEntity>> call() async {
    return await repository.getMyAccount();
  }
}
