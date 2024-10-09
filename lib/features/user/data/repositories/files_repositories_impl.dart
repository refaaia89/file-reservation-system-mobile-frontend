import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/file_remote_datasource.dart';
import 'package:internet_application/features/user/data/models/file_model.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';

import '../../../../core/network/network_info.dart';

class FilesRepositoriesImpl extends FilesRepository {
  final FileRemoteDataSources fileRemoteDataSources;
  final NetworkInfo networkInfo;

  FilesRepositoriesImpl({required this.fileRemoteDataSources, required this.networkInfo});

  @override
  Future<Either<String, Unit>> checkIn({required List<String> listFileId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fileRemoteDataSources.checkIn(listFileId: listFileId);
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
  Future<Either<String, Unit>> checkOut({required List<String> listFileId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fileRemoteDataSources.checkOut(listFileId: listFileId);
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
  Future<Either<String, Unit>> createNewFile({required FileEntity fileEntity, required String groupId}) async {
    if (await networkInfo.isConnected) {
      try {
        FileModel fileModel = FileModel(
          fileId: fileEntity.fileId,
          name: fileEntity.name,
          isCheckedIn: fileEntity.isCheckedIn,
          file: fileEntity.file,
          owner: fileEntity.owner,
          ownerId: fileEntity.ownerId,
          checkedInUntilTime: fileEntity.checkedInUntilTime,
          createAt: fileEntity.createAt,
          updateAt: fileEntity.updateAt, group: fileEntity.group,
          updatedBy: fileEntity.updatedBy,
        );

        final result = await fileRemoteDataSources.createNewFile(fileModel: fileModel, groupId: groupId);
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
  Future<Either<String, Unit>> deleteFile({required String fileId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fileRemoteDataSources.deleteFile(fileId: fileId);
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
  Future<Either<String, List<FileEntity>>> getAllFiles({required int page, required int pageSize}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fileRemoteDataSources.getAllFiles(page: page, pageSize: pageSize);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (r) {
          List<FileEntity> fileEntityList = [];
          fileEntityList = r
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
          return Right(fileEntityList);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, FileEntity>> getFile({required String fileId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await fileRemoteDataSources.getFile(fileId: fileId);
        print({result});
        return result.fold((l) {
          return Left(l);
        }, (fileModel) {
          FileEntity fileEntity = FileEntity(
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
          );
          return Right(fileEntity);
        });
      } catch (error) {
        return Left(error.toString());
      }
    } else {
      return const Left("No Internet Connection!");
    }
  }

  @override
  Future<Either<String, Unit>> updateCurrentFile({required FileEntity fileEntity, required String groupId, required String fileId}) async {
    if (await networkInfo.isConnected) {
      try {
        FileModel fileModel = FileModel(
          group: fileEntity.group,
          fileId: fileEntity.fileId,
          name: fileEntity.name,
          isCheckedIn: fileEntity.isCheckedIn,
          file: fileEntity.file,
          owner: fileEntity.owner,
          ownerId: fileEntity.ownerId,
          checkedInUntilTime: fileEntity.checkedInUntilTime,
          createAt: fileEntity.createAt,
          updateAt: fileEntity.updateAt,
          updatedBy: fileEntity.updatedBy,
        );

        final result = await fileRemoteDataSources.updateCurrentFile(fileModel: fileModel, groupId: groupId, fileId: fileId);
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
