import 'package:dartz/dartz.dart';

import '../../repositories/group_repository.dart';


class LeaveGroupUseCase {
  final GroupRepository repository;

  LeaveGroupUseCase(this.repository);

  Future<Either<String, Unit>> call({required String groupId,required List<String>listUserId}) async {
    return await repository.leaveGroup(groupId: groupId, listUserId: listUserId);
  }
}
