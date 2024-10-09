import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/features/user/domain/entities/user_entity.dart';
import 'package:internet_application/features/user/presentation/bloc/group_bloc/groups_bloc.dart';
import 'package:internet_application/features/user/presentation/widgets/group_widgets.dart';
import 'package:logger/logger.dart';

import '../../../domain/entities/file_entity.dart';
import '../../../domain/usecases/files/check_in_usecase.dart';
import '../../../domain/usecases/files/check_out_usecase.dart';
import '../../../domain/usecases/files/create_new_file_usecase.dart';
import '../../../domain/usecases/files/delete_file_usecase.dart';
import '../../../domain/usecases/files/get_all_files_usecase.dart';
import '../../../domain/usecases/files/git_file_usecase.dart';
import '../../../domain/usecases/files/update_current_file_usecase.dart';
import '../../pages/files_checkIn.dart';

part 'files_event.dart';
part 'files_state.dart';

class FilesBloc extends Bloc<FilesEvent, FilesState> {
  final CheckInUseCase checkInUseCase;
  final CheckOutUseCase checkOutUseCase;
  final GetAllFilesUseCase getAllFilesUseCase;
  final GetFileUseCase getFileUseCase;
  final DeleteFileUseCase deleteFileUseCase;
  final UpdateCurrentFileUseCase updateCurrentFileUseCase;
  final CreateNewFileUseCase createNewFileUseCase;
  List<bool> fileCheckList = [];

  FilesBloc({
    required this.checkInUseCase,
    required this.checkOutUseCase,
    required this.getAllFilesUseCase,
    required this.getFileUseCase,
    required this.deleteFileUseCase,
    required this.updateCurrentFileUseCase,
    required this.createNewFileUseCase,
  }) : super(FilesInitial()) {
    on<UpdateFileCheckListEvent>(_onUpdateList);
    on<CheckInEvent>(_onCheckIn);
    on<CheckOutEvent>(_onCheckOut);
    on<CreateNewFileEvent>(_onCreateNewFile);
    on<GetAllFilesEvent>(_onGetAllFiles);
    on<GetFileEvent>(_onGetFile);
    on<DeleteFileEvent>(_onDeleteFile);
    on<UpdateCurrentFileEvent>(_onUpdateCurrentFile);
  }

  _onUpdateList(UpdateFileCheckListEvent event, Emitter<FilesState> emit) {
    fileCheckList = event.fileCheckList;
    emit(UpdateFileCheckListState(fileCheckList: fileCheckList));
  }

  _onCheckIn(CheckInEvent event, Emitter<FilesState> emit) async {
    emit(LoadingCheckInState());
    final listFileId = event.listFiles.map<String>((e) => e.fileId).toList();
    final result = await checkInUseCase(listFileId: listFileId);
    result.fold((l) {
      showError(event.context, l);
      emit(ErrorCheckInState(message: l));
    }, (r) {
      Navigator.of(event.context).push(MaterialPageRoute(
          builder: (context) => FilesCheckIn(
                listFiles: event.listFiles,
                // listFilesId: event.groupEntity.files.map<String>((e) => e.fileId).toList(),
                groupId: event.groupId,
                userEntity: event.userEntity,
              )));
      emit(SuccessCheckInState());
    });
  }

  _onCheckOut(CheckOutEvent event, Emitter<FilesState> emit) async {
    emit(LoadingCheckOutState());
    final result = await checkOutUseCase(listFileId: event.listFileId);
    result.fold((l) {
      emit(ErrorCheckOutState(message: l));
      _pop(event.context, event.inside, groupId: event.groupId);
    }, (r) {
      emit(SuccessCheckOutState());
      _pop(event.context, event.inside, groupId: event.groupId);
    });
  }

  _pop(BuildContext context, bool value, {String? groupId}) {
    if (value) {
      Navigator.of(context).pop();
    } else {
      BlocProvider.of<GroupsBloc>(context).add(GetGroupEvent(groupId: groupId!));
    }
  }

  _onGetAllFiles(GetAllFilesEvent event, Emitter<FilesState> emit) async {
    emit(LoadingGetAllFilesState());
    final result = await getAllFilesUseCase(page: event.page, pageSize: event.pageSize);
    result.fold((l) {
      emit(ErrorGetAllFilesState(message: l));
    }, (listAllFiles) {
      emit(SuccessGetAllFilesState(listAllFiles: listAllFiles));
    });
  }

  _onGetFile(GetFileEvent event, Emitter<FilesState> emit) async {
    emit(LoadingGetFileState());
    final result = await getFileUseCase(fileId: event.fileId);
    result.fold((l) {
      emit(ErrorGetFileState(message: l));
    }, (fileEntity) {
      emit(SuccessGetFileState(fileEntity: fileEntity));
    });
  }

  _onCreateNewFile(CreateNewFileEvent event, Emitter<FilesState> emit) async {
    emit(LoadingCreateNewFileState());
    final result = await createNewFileUseCase(fileEntity: event.file, groupId: event.groupId);
    result.fold((l) {
      emit(ErrorCreateNewFileState(message: l));
    }, (r) {
      emit(SuccessCreateNewFileState());
    });
  }

  _onUpdateCurrentFile(UpdateCurrentFileEvent event, Emitter<FilesState> emit) async {
    emit(LoadingUpdateCurrentFileState());

    Logger().w(event.fileEntity);
    final result = await updateCurrentFileUseCase(fileEntity: event.fileEntity, fileId: event.fileId, groupId: event.groupId);
    result.fold((l) {
      Logger().e(l);
      emit(ErrorUpdateCurrentFileState(message: l));
    }, (r) {
      Navigator.pop(event.context);
      BlocProvider.of<GroupsBloc>(event.context).add(GetGroupEvent(groupId: event.groupId));
      emit(SuccessUpdateCurrentFileState());
    });
  }

  _onDeleteFile(DeleteFileEvent event, Emitter<FilesState> emit) async {
    emit(LoadingDeleteFileState());
    final result = await deleteFileUseCase(fileId: event.fileId);
    result.fold((l) {
      showError(event.context, l);
      emit(ErrorDeleteFileState(message: l));
    }, (r) {
      BlocProvider.of<GroupsBloc>(event.context).add(GetGroupEvent(groupId: event.groupId));
      emit(SuccessDeleteFileState());
    });
  }
}
