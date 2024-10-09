import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/user_entity.dart';

import '../../repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<Either<String, List<UserEntity>>> call({required int page,required int pageSize}) async {
    return await repository.getAllUsers(page: page,pageSize: pageSize);
  }
}
