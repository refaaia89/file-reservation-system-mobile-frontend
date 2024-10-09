import 'package:dartz/dartz.dart';

import '../../repositories/group_repository.dart';

class DeleteGroupUseCase {
  final GroupRepository repository;

  DeleteGroupUseCase(this.repository);

  Future<Either<String, Unit>> call({required String groupId}) async {
    return await repository.deleteGroup(groupId: groupId);
  }
}
