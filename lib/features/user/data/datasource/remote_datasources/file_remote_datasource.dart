import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';

import '../../models/file_model.dart';

abstract class FileRemoteDataSources {
  Future<Either<String, Unit>> checkIn({required List<String> listFileId});

  Future<Either<String, Unit>> checkOut({required List<String> listFileId});

  Future<Either<String, Unit>> createNewFile({required FileModel fileModel, required String groupId});

  Future<Either<String, Unit>> deleteFile({required String fileId});

  Future<Either<String, List<FileModel>>> getAllFiles({required int page, required int pageSize});

  Future<Either<String, FileModel>> getFile({required String fileId});

  Future<Either<String, Unit>> updateCurrentFile({required FileModel fileModel, required String groupId, required String fileId});
}
