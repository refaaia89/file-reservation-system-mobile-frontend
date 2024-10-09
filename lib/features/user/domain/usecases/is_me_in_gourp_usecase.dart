import 'package:dartz/dartz.dart';

import '../repositories/group_repository.dart';

class IsMeInGroupUseCase {
  final GroupRepository repository;

  IsMeInGroupUseCase(this.repository);

  Future<Either<String, bool>> call({required String groupId}) async {
    return await repository.isMeInGroup(groupId: groupId);
  }
}
