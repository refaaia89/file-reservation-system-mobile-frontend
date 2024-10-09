import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:internet_application/core/strings/api_end_point.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/data/datasource/group_link_container.dart';
import 'package:internet_application/features/user/data/datasource/user_link_container.dart';
import 'package:internet_application/features/user/data/models/group_model.dart';
import 'package:internet_application/features/user/domain/entities/user_entity.dart';

import '../../../../../core/network/base_api_client.dart';
import 'group_remote_datasource.dart';

class GroupRemoteDataSourcesImpl implements GroupRemoteDataSources {
  final AuthLocalDataSources authLocalDataSources;

  GroupRemoteDataSourcesImpl({required this.authLocalDataSources});

  @override
  Future<Either<String, Unit>> addMembersToGroup({required String userId, required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.post(
        token: token,
        url: UserLinkContainer.addMembersToGroup,
        body: {},
        converter: (value) {
          return null;
        });
  }

  @override
  Future<Either<String, String>> downloadFile({required String nameFile, required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    try {
      final result = await FileSaver.instance.saveFile(
          name: nameFile,
          link: LinkDetails(link: BASE_URL + GroupLinkContainer.downloadFile1 + groupId + GroupLinkContainer.downloadFile2 + nameFile, headers: {
            'Authorization': "Bearer $token",
          }));
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
    // return await BaseApiClient.downloadFile(
    //     token: token,
    //     url: GroupLinkContainer.downloadFile1 + groupId + GroupLinkContainer.downloadFile2 + nameFile,
    //     onReceiveProgress: showDownloadProgress,
    //     savePath: filePath);
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  @override
  Future<Either<String, UserEntity>> getMyAccount() async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.get(
        token: token,
        url: UserLinkContainer.getMyAccount,
        converter: (value) {
          return null;
        });
  }

  @override
  Future<Either<String, bool>> isMeInGroup({required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.get(
        token: token,
        url: UserLinkContainer.isMeInGroup,
        converter: (value) {
          return null;
        });
  }

  @override
  Future<Either<String, Unit>> removeUserFromGroup({required String userId, required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.post(
        token: token,
        url: UserLinkContainer.removeUserFromGroup,
        body: {},
        converter: (value) {
          return null;
        });
  }

  @override
  Future<Either<String, Unit>> searchGroup({required String userId, required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.get(
        token: token,
        url: UserLinkContainer.searchGroup,
        converter: (value) {
          return null;
        });
  }

  @override
  Future<Either<String, Unit>> searchUser({required String userId, required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.get(
        token: token,
        url: UserLinkContainer.searchUser,
        converter: (value) {
          return null;
        });
  }

  @override
  Future<Either<String, List<GroupModel>>> getAllGroups({required int page, required int pageSize}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    FormData formData = FormData.fromMap({
      'page': page,
      'pageSize': pageSize,
    });
    return await BaseApiClient.get(
        token: token,
        url: GroupLinkContainer.getAllGroups,
        body: formData,
        converter: (value) {
          List<GroupModel> groups = GroupModel.fromJsonList(value['data']);
          return groups;
        });
  }

  @override
  Future<Either<String, GroupModel>> getGroup({required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.get(
        token: token,
        url: GroupLinkContainer.getGroup + groupId,
        converter: (value) {
          return GroupModel.fromJson(value['data']);
        });
  }

  @override
  Future<Either<String, Unit>> createNewGroup({required GroupModel groupModel}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    Map<String, dynamic> formData = groupModel.toJson();
    return await BaseApiClient.post(
        token: token,
        url: GroupLinkContainer.createNewGroup,
        body: formData,
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> deleteGroup({required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.delete(
        token: token,
        url: GroupLinkContainer.deleteGroup + groupId,
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> joinGroup({required String groupId, required List<String> listUserId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    return await BaseApiClient.post(
        token: token,
        url: GroupLinkContainer.joinGroup,
        body: {
          "group": [int.parse(groupId)],
          "user": listUserId.map((e) => int.parse(e)).toList()
        },
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> leaveGroup({required String groupId, required List<String> listUserId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.post(
        token: token,
        url: GroupLinkContainer.leaveGroup,
        body: {
          "group": [int.parse(groupId)],
          "user": listUserId.map((id) => int.parse(id)).toList()
        },
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> updateCurrentGroup({required GroupModel groupModel, required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    Map<String, dynamic> formData = groupModel.toJson();
    return await BaseApiClient.put(
        token: token,
        url: GroupLinkContainer.updateCurrentGroup + groupId,
        body: formData,
        converter: (value) {
          return unit;
        });
  }
}
