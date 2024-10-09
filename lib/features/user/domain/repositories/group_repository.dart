import 'package:dartz/dartz.dart';

import '../entities/group_entity.dart';
import '../entities/user_entity.dart';

abstract class GroupRepository {
  Future<Either<String, List<GroupEntity>>> getAllGroups({required int page, required int pageSize});

  Future<Either<String, GroupEntity>> getGroup({required String groupId});

  Future<Either<String, Unit>> createNewGroup({required GroupEntity groupEntity});

  Future<Either<String, Unit>> updateCurrentGroup({required GroupEntity groupEntity, required String groupId});

  Future<Either<String, Unit>> deleteGroup({required String groupId});

  Future<Either<String, Unit>> joinGroup({required String groupId, required List<String> listUserId});

  Future<Either<String, Unit>> leaveGroup({required String groupId, required List<String> listUserId});

  Future<Either<String, Unit>> addMembersToGroup({required String userId, required String groupId});

  Future<Either<String, String>> downloadFile({required String groupId, required String nameFile});

  Future<Either<String, UserEntity>> getMyAccount();

  Future<Either<String, bool>> isMeInGroup({required String groupId});

  Future<Either<String, Unit>> removeUserFromGroup({required String userId, required String groupId});

  Future<Either<String, Unit>> searchGroup({required String userId, required String groupId});

  Future<Either<String, Unit>> searchUser({required String userId, required String groupId});
}
