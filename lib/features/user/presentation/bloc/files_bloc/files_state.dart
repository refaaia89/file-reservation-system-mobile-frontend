part of 'files_bloc.dart';

@immutable
abstract class FilesState {}

class FilesInitial extends FilesState {}

class LoadingCheckInState extends FilesState {}
class SuccessCheckInState extends FilesState {}
class ErrorCheckInState extends FilesState {
  final String message;
  ErrorCheckInState({required this.message});
}


class LoadingCheckOutState extends FilesState {}
class SuccessCheckOutState extends FilesState {}
class ErrorCheckOutState extends FilesState {
  final String message;
  ErrorCheckOutState({required this.message});
}


class LoadingGetAllFilesState extends FilesState {}
class SuccessGetAllFilesState extends FilesState {
  final List<FileEntity> listAllFiles;
  SuccessGetAllFilesState({required this.listAllFiles});
}
class ErrorGetAllFilesState extends FilesState {
  final String message;
  ErrorGetAllFilesState({required this.message});
}


class LoadingGetFileState extends FilesState {}
class SuccessGetFileState extends FilesState {
  final FileEntity fileEntity;
  SuccessGetFileState({required this.fileEntity});
}
class ErrorGetFileState extends FilesState {
  final String message;
  ErrorGetFileState({required this.message});
}


class LoadingCreateNewFileState extends FilesState {}
class SuccessCreateNewFileState extends FilesState {}
class ErrorCreateNewFileState extends FilesState {
  final String message;
  ErrorCreateNewFileState({required this.message});
}



class LoadingUpdateCurrentFileState extends FilesState {}
class SuccessUpdateCurrentFileState extends FilesState {}
class ErrorUpdateCurrentFileState extends FilesState {
  final String message;
  ErrorUpdateCurrentFileState({required this.message});
}


class LoadingDeleteFileState extends FilesState {}
class SuccessDeleteFileState extends FilesState {}
class ErrorDeleteFileState extends FilesState {
  final String message;
  ErrorDeleteFileState({required this.message});
}


class UpdateFileCheckListState extends FilesState{
  List<bool> fileCheckList;
  UpdateFileCheckListState({required this.fileCheckList});
}
