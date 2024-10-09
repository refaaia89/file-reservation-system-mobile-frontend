import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/group_entity.dart';
import 'package:internet_application/features/user/domain/repositories/group_repository.dart';

class CreateNewGroupUseCase {
  final GroupRepository repository;

  CreateNewGroupUseCase(this.repository);

  Future<Either<String, Unit>> call({required GroupEntity groupEntity}) async {
    return await repository.createNewGroup(groupEntity: groupEntity);
  }
}
