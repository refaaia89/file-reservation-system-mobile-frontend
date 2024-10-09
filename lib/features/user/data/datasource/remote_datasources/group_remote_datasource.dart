import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/models/group_model.dart';

import '../../../domain/entities/user_entity.dart';

abstract class GroupRemoteDataSources {
  Future<Either<String, List<GroupModel>>> getAllGroups({required int page, required int pageSize});

  Future<Either<String, GroupModel>> getGroup({required String groupId});

  Future<Either<String, Unit>> createNewGroup({required GroupModel groupModel});

  Future<Either<String, Unit>> updateCurrentGroup({required GroupModel groupModel, required String groupId});

  Future<Either<String, Unit>> deleteGroup({required String groupId});

  Future<Either<String, Unit>> joinGroup({required String groupId, required List<String> listUserId});

  Future<Either<String, Unit>> leaveGroup({required String groupId, required List<String> listUserId});

  Future<Either<String, Unit>> addMembersToGroup({required String userId, required String groupId});

  Future<Either<String, String>> downloadFile({required String nameFile, required String groupId});

  Future<Either<String, UserEntity>> getMyAccount();

  Future<Either<String, bool>> isMeInGroup({required String groupId});

  Future<Either<String, Unit>> removeUserFromGroup({required String userId, required String groupId});

  Future<Either<String, Unit>> searchGroup({required String userId, required String groupId});

  Future<Either<String, Unit>> searchUser({required String userId, required String groupId});
}
