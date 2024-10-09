import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/group_remote_datasource.dart';
import 'package:internet_application/features/user/data/models/group_model.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/entities/group_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/group_repository.dart';

class GroupRepositoriesImpl implements GroupRepository {
  final GroupRemoteDataSources groupRemoteDataSources;
  final NetworkInfo networkInfo;

  GroupRepositoriesImpl({required this.groupRemoteDataSources, required this.networkInfo});

  @override
  Future<Either<String, Unit>> addMembersToGroup({required String userId, required String groupId}) => addMembersToGroup(userId: userId, groupId: groupId);

  @override
  Future<Either<String, String>> downloadFile({required String nameFile, required String groupId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await groupRemoteDataSources.downloadFile(nameFile: nameFile, groupId: groupId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, UserEntity>> getMyAccount() => getMyAccount();

  @override
  Future<Either<String, bool>> isMeInGroup({required String groupId}) => isMeInGroup(groupId: groupId);

  @override
  Future<Either<String, Unit>> removeUserFromGroup({required String userId, required String groupId}) => removeUserFromGroup(userId: userId, groupId: groupId);

  @override
  Future<Either<String, Unit>> searchGroup({required String userId, required String groupId}) => searchGroup(userId: userId, groupId: groupId);

  @override
  Future<Either<String, Unit>> searchUser({required String userId, required String groupId}) => searchUser(userId: userId, groupId: groupId);

  @override
  Future<Either<String, List<GroupEntity>>> getAllGroups({required int page, required int pageSize}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await groupRemoteDataSources.getAllGroups(page: page, pageSize: pageSize);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<GroupEntity> groupEntityList = [];
          groupEntityList = r
              .map((groupModel) => GroupEntity(
                    groupId: groupModel.groupId,
                    name: groupModel.name,
                    description: groupModel.description,
                    isPublic: groupModel.isPublic,
                    allowedExtensionFileTypes: groupModel.allowedExtensionFileTypes,
                    members: groupModel.members,
                    administratorId: groupModel.administratorId,
                    maxMemberCount: groupModel.maxMemberCount,
                    administratorName: groupModel.administratorName,
                    maxAllowedFileSizeInMb: groupModel.maxAllowedFileSizeInMb,
                    maxFilesCount: groupModel.maxFilesCount,
                    createAt: groupModel.createAt,
                    updateAt: groupModel.updateAt,
                    admin: groupModel.admin,
                    files: groupModel.files,
                  ))
              .toList();
          return Right(groupEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, GroupEntity>> getGroup({required String groupId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await groupRemoteDataSources.getGroup(groupId: groupId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (groupModel) {
          List<FileEntity> fileEntityList = [];
          fileEntityList = groupModel.files
              .map((fileModel) => FileEntity(
                    group: fileModel.group,
                    fileId: fileModel.fileId,
                    name: fileModel.name,
                    isCheckedIn: fileModel.isCheckedIn,
                    file: fileModel.file,
                    ownerId: fileModel.ownerId,
                    owner: fileModel.owner,
                    checkedInUntilTime: fileModel.checkedInUntilTime,
                    createAt: fileModel.createAt,
                    updateAt: fileModel.updateAt,
                    updatedBy: fileModel.updatedBy,
                  ))
              .toList();
          List<UserEntity> userEntityList = [];
          userEntityList = groupModel.members
              .map((userModel) => UserEntity(
                    id: userModel.id,
                    email: userModel.email,
                    userName: userModel.userName,
                    role: userModel.role,
                  ))
              .toList();

          GroupEntity groupEntity = GroupEntity(
            groupId: groupModel.groupId,
            name: groupModel.name,
            description: groupModel.description,
            isPublic: groupModel.isPublic,
            allowedExtensionFileTypes: groupModel.allowedExtensionFileTypes,
            members: userEntityList,
            administratorId: groupModel.administratorId,
            maxMemberCount: groupModel.maxMemberCount,
            administratorName: groupModel.administratorName,
            maxAllowedFileSizeInMb: groupModel.maxAllowedFileSizeInMb,
            maxFilesCount: groupModel.maxFilesCount,
            createAt: groupModel.createAt,
            updateAt: groupModel.updateAt,
            admin: groupModel.admin,
            files: fileEntityList,
          );
          return Right(groupEntity);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> createNewGroup({required GroupEntity groupEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        GroupModel groupModel = GroupModel(
          groupId: groupEntity.groupId,
          name: groupEntity.name,
          description: groupEntity.description,
          isPublic: groupEntity.isPublic,
          allowedExtensionFileTypes: groupEntity.allowedExtensionFileTypes,
          members: groupEntity.members,
          administratorId: groupEntity.administratorId,
          maxMemberCount: groupEntity.maxMemberCount,
          administratorName: groupEntity.administratorName,
          maxAllowedFileSizeInMb: groupEntity.maxAllowedFileSizeInMb,
          maxFilesCount: groupEntity.maxFilesCount,
          createAt: groupEntity.createAt,
          updateAt: groupEntity.updateAt,
          admin: groupEntity.admin,
          files: groupEntity.files,
        );

        final result = await groupRemoteDataSources.createNewGroup(groupModel: groupModel);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> deleteGroup({required String groupId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await groupRemoteDataSources.deleteGroup(groupId: groupId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> joinGroup({required String groupId, required List<String> listUserId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await groupRemoteDataSources.joinGroup(groupId: groupId, listUserId: listUserId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> updateCurrentGroup({required GroupEntity groupEntity, required String groupId}) async {
    if (await networkInfo.isConnected) {
      try {
        GroupModel groupModel = GroupModel(
          groupId: groupEntity.groupId,
          name: groupEntity.name,
          description: groupEntity.description,
          isPublic: groupEntity.isPublic,
          allowedExtensionFileTypes: groupEntity.allowedExtensionFileTypes,
          members: groupEntity.members,
          administratorId: groupEntity.administratorId,
          maxMemberCount: groupEntity.maxMemberCount,
          administratorName: groupEntity.administratorName,
          maxAllowedFileSizeInMb: groupEntity.maxAllowedFileSizeInMb,
          maxFilesCount: groupEntity.maxFilesCount,
          createAt: groupEntity.createAt,
          updateAt: groupEntity.updateAt,
          admin: groupEntity.admin,
          files: groupEntity.files,
        );
        final result = await groupRemoteDataSources.updateCurrentGroup(groupModel: groupModel, groupId: groupId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> leaveGroup({required String groupId, required List<String> listUserId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await groupRemoteDataSources.leaveGroup(groupId: groupId, listUserId: listUserId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          return Right(r);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }
}
