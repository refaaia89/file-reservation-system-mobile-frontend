part of 'files_bloc.dart';

@immutable
abstract class FilesEvent {}

class CheckInEvent extends FilesEvent {
  final List<FileEntity> listFiles;
  // final List<String> listFileId;
  final BuildContext context;
  final String groupId;
  final UserEntity userEntity;
  // final int? index;

  CheckInEvent({
    // required this.listFileId,
    required this.context,
    required this.groupId,
    required this.userEntity,
    required this.listFiles,
    /*this.index*/
  });
}

class CheckOutEvent extends FilesEvent {
  final List<String> listFileId;
  final BuildContext context;
  final bool inside;
  final String? groupId;

  CheckOutEvent(
      {required this.listFileId,
      required this.context,
      this.inside = true,
      this.groupId});
}

class CreateNewFileEvent extends FilesEvent {
  final FileEntity file;
  final String groupId;

  CreateNewFileEvent({required this.file, required this.groupId});
}

class DeleteFileEvent extends FilesEvent {
  final String fileId;
  final String groupId;
  final BuildContext context;
  DeleteFileEvent(
      {required this.fileId, required this.context, required this.groupId});
}

class GetAllFilesEvent extends FilesEvent {
  final int page;
  final int pageSize;

  GetAllFilesEvent({required this.page, required this.pageSize});
}

class GetFileEvent extends FilesEvent {
  final String fileId;

  GetFileEvent({required this.fileId});
}

class UpdateCurrentFileEvent extends FilesEvent {
  final FileEntity fileEntity;
  final String groupId;
  final String fileId;
  final BuildContext context;

  UpdateCurrentFileEvent(
      {required this.fileEntity,
      required this.groupId,
      required this.fileId,
      required this.context});
}

class UpdateFileCheckListEvent extends FilesEvent {
  final List<bool> fileCheckList;

  UpdateFileCheckListEvent({required this.fileCheckList});
}
