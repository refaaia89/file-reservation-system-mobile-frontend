import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/group_entity.dart';
import 'package:internet_application/features/user/domain/repositories/group_repository.dart';

class UpdateCurrentGroupUseCase {
  final GroupRepository repository;

  UpdateCurrentGroupUseCase(this.repository);

  Future<Either<String, Unit>> call({required GroupEntity groupEntity,required String groupId}) async {
    return await repository.updateCurrentGroup(groupEntity: groupEntity, groupId: groupId);
  }
}
