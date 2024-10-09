import 'package:dartz/dartz.dart';

import '../../repositories/group_repository.dart';


class JoinGroupUseCase {
  final GroupRepository repository;

  JoinGroupUseCase(this.repository);

  Future<Either<String, Unit>> call({required String groupId ,required List<String> listUserId}) async {
    return await repository.joinGroup(groupId: groupId,listUserId:listUserId);
  }
}
