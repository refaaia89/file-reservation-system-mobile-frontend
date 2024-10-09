import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';

abstract class FilesRepository {
  Future<Either<String, Unit>> checkIn({required List<String> listFileId});
  Future<Either<String, Unit>> checkOut({required List<String> listFileId});
  Future<Either<String, Unit>> createNewFile({required FileEntity fileEntity, required String groupId});
  Future<Either<String, Unit>> deleteFile({required String fileId});
  Future<Either<String, List<FileEntity>>> getAllFiles({required int page, required int pageSize});
  Future<Either<String, FileEntity>> getFile({required String fileId});
  Future<Either<String, Unit>> updateCurrentFile({required FileEntity fileEntity, required String groupId, required String fileId});
}
