import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/group_entity.dart';
import 'package:internet_application/features/user/domain/repositories/group_repository.dart';

class GetAllGroupsUseCase {
  final GroupRepository repository;

  GetAllGroupsUseCase(this.repository);

  Future<Either<String, List<GroupEntity>>> call({required int page,required int pageSize}) async {
    return await repository.getAllGroups(page: page,pageSize: pageSize);
  }
}
