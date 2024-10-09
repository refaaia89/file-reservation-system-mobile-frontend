import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/data/datasource/files_link_container.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/file_remote_datasource.dart';
import 'package:internet_application/features/user/data/models/file_model.dart';

import '../../../../../core/network/base_api_client.dart';

class FileRemoteDataSourcesImpl implements FileRemoteDataSources {
  final AuthLocalDataSources authLocalDataSources;

  FileRemoteDataSourcesImpl({required this.authLocalDataSources});

  @override
  Future<Either<String, Unit>> checkIn(
      {required List<String> listFileId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.post(
        token: token,
        url: FilesLinkContainer.checkIn,
        body: {"files": listFileId.map((id) => int.parse(id)).toList()},
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> checkOut(
      {required List<String> listFileId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.post(
        token: token,
        url: FilesLinkContainer.checkOut,
        body: {"files": listFileId.map((id) => int.parse(id)).toList()},
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, Unit>> createNewFile(
      {required FileModel fileModel, required String groupId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(fileModel.file!.path,
          filename: fileModel.file!.path.split('\\').last),
      'group_id': groupId
    });
    return await BaseApiClient.post(
        token: token,
        url: FilesLinkContainer.createNewFile,
        body: formData,
        converter: (value) {
          return unit;
        });

    // try {
    //   await BaseApiClient.postMultiPartDio(
    //     FilesLinkContainer.createNewFile,
    //     token: token,
    //     body: {"group_id": groupId},
    //     converter: (value) {
    //       return unit;
    //     },
    //     key: 'file',
    //     file: file,
    //   );
    //   return Right(unit);
    // } catch (e) {
    //   return Left(e.toString());
    // }
  }

  @override
  Future<Either<String, Unit>> deleteFile({required String fileId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.delete(
        token: token,
        url: FilesLinkContainer.deleteFile + fileId,
        converter: (value) {
          return unit;
        });
  }

  @override
  Future<Either<String, List<FileModel>>> getAllFiles(
      {required int page, required int pageSize}) async {
    Map<String, dynamic> formData = {
      'page': page,
      'pageSize': pageSize,
    };
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.get(
        token: token,
        url: FilesLinkContainer.getAllFiles,
        queryParameters: formData,
        converter: (value) {
          List<FileModel> files = FileModel.fromJsonList(value['data']);
          return files;
        });
  }

  @override
  Future<Either<String, FileModel>> getFile({required String fileId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";

    return await BaseApiClient.get(
        token: token,
        url: FilesLinkContainer.getFile + fileId,
        converter: (value) {
          return FileModel.fromJson(value['data']);
        });
  }

  @override
  Future<Either<String, Unit>> updateCurrentFile(
      {required FileModel fileModel,
      required String groupId,
      required String fileId}) async {
    final result = authLocalDataSources.getCachedToken();
    String token = result ?? "";
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(fileModel.file!.path,
          filename: fileModel.file!.path.split('\\').last),
      'group_id': groupId
    });
    return await BaseApiClient.put(
        token: token,
        url: FilesLinkContainer.updateCurrentFile + fileId,
        body: formData,
        converter: (value) {
          return unit;
        });
    //   final result = authLocalDataSources.getCachedToken();
    //   String token = result ?? "";

    //   FormData formData = FormData.fromMap({
    //     "file":await MultipartFile.fromFile(fileModel.file!.path, filename: fileModel.file!.path.split('\\').last)  ,
    //     "name": fileModel.name ,
    //     "is_checked_in": fileModel.isCheckedIn,
    //     "checked_in_until_time":fileModel.checkedInUntilTime ,
    //     "owner_id":fileModel.ownerId ,
    //     "group_id": int.parse(groupId),
    //   });
    //   return await BaseApiClient.put(
    //       token: token,
    //       url: FilesLinkContainer.updateCurrentFile + fileId,
    //       body: formData,
    //       converter: (value) {
    //         return unit;
    //       });
    // }
  }
}
