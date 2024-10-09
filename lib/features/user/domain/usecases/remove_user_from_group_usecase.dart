import 'package:dartz/dartz.dart';

import '../repositories/group_repository.dart';

class RemoveUserFromGroupUseCase {
  final GroupRepository repository;

  RemoveUserFromGroupUseCase(this.repository);

  Future<Either<String, Unit>> call({required String userId, required String groupId}) async {
    return await repository.removeUserFromGroup(userId: userId, groupId: groupId);
  }
}
