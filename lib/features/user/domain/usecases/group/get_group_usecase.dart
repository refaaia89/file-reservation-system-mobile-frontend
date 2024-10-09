import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/group_entity.dart';
import 'package:internet_application/features/user/domain/repositories/group_repository.dart';

class GetGroupUseCase {
  final GroupRepository repository;

  GetGroupUseCase(this.repository);

  Future<Either<String, GroupEntity>> call({required String groupId}) async {
    return await repository.getGroup(groupId: groupId);
  }
}
