import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_application/features/user/presentation/widgets/group_widgets.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/file_entity.dart';
import '../../../domain/entities/group_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/group/create_new_group_usecase.dart';
import '../../../domain/usecases/group/delete_group_usecase.dart';
import '../../../domain/usecases/group/download_file_usecase.dart';
import '../../../domain/usecases/group/get_all_groups_usecase.dart';
import '../../../domain/usecases/group/get_group_usecase.dart';
import '../../../domain/usecases/group/join_group_usecase.dart';
import '../../../domain/usecases/group/leave_group_usecase.dart';
import '../../../domain/usecases/group/update_current_group_usecase.dart';
import '../../pages/home_page.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  List<FileEntity> filesSelect = [];
  List<GroupEntity> listGroups = [];

  final GetAllGroupsUseCase getAllGroupsUseCase;
  final GetGroupUseCase getGroupUseCase;
  final CreateNewGroupUseCase createNewGroupUseCase;
  final UpdateCurrentGroupUseCase updateCurrentGroupUseCase;
  final DeleteGroupUseCase deleteGroupUseCase;
  final LeaveGroupUseCase leaveGroupUseCase;
  final JoinGroupUseCase joinGroupUseCase;
  final DownloadFileUseCase downloadFileUseCase;

  GroupsBloc({
    required this.getGroupUseCase,
    required this.getAllGroupsUseCase,
    required this.deleteGroupUseCase,
    required this.leaveGroupUseCase,
    required this.joinGroupUseCase,
    required this.updateCurrentGroupUseCase,
    required this.createNewGroupUseCase,
    required this.downloadFileUseCase,
  }) : super(GroupsInitial()) {
    on<GetAllGroupsEvent>(_onGetAllGroups);
    on<GetGroupEvent>(_onGetGroup);
    on<CreateNewGroupEvent>(_onCreateNewGroup);
    on<UpdateCurrentGroupEvent>(_onUpdateCurrentGroup);
    on<DeleteGroupEvent>(_onDeleteGroup);
    on<JoinGroupEvent>(_onJoinGroup);
    on<LeaveGroupEvent>(_onLeaveGroup);
    on<DownloadFileEvent>(_onDownloadFile);
  }

  _onGetAllGroups(GetAllGroupsEvent event, Emitter<GroupsState> emit) async {
    emit(LoadingGetAllGroupsState());
    final result = await getAllGroupsUseCase(page: event.page, pageSize: event.pageSize);
    result.fold((l) {
      emit(ErrorGetAllGroupsState(message: l));
    }, (listAllGroups) {
      emit(SuccessGetAllGroupsState(listAllGroups: listAllGroups));
    });
  }

  _onGetGroup(GetGroupEvent event, Emitter<GroupsState> emit) async {
    emit(LoadingGetGroupState());
    final result = await getGroupUseCase(groupId: event.groupId);
    result.fold((l) {
      emit(ErrorGetGroupState(message: l));
    }, (groupEntity) {
      emit(SuccessGetGroupState(groupEntity: groupEntity));
    });
  }

  _onCreateNewGroup(CreateNewGroupEvent event, Emitter<GroupsState> emit) async {
    emit(LoadingCreateNewGroupState());
    final result = await createNewGroupUseCase(groupEntity: event.groupEntity);
    result.fold((l) {
      emit(ErrorCreateNewGroupState(message: l));
    }, (r) {
      emit(SuccessCreateNewGroupState());
    });
  }

  _onUpdateCurrentGroup(UpdateCurrentGroupEvent event, Emitter<GroupsState> emit) async {
    emit(LoadingUpdateCurrentGroupState());
    final result = await updateCurrentGroupUseCase(groupEntity: event.groupEntity, groupId: event.groupId);
    result.fold((l) {
      emit(ErrorUpdateCurrentGroupState(message: l));
    }, (r) {
      emit(SuccessUpdateCurrentGroupState());
    });
  }

  _onDeleteGroup(DeleteGroupEvent event, Emitter<GroupsState> emit) async {
    emit(LoadingDeleteGroupState());
    final result = await deleteGroupUseCase(groupId: event.groupId);
    result.fold((l) {
      emit(ErrorDeleteGroupState(message: l));
    }, (r) {
      emit(SuccessDeleteGroupState());
    });
  }

  _onLeaveGroup(LeaveGroupEvent event, Emitter<GroupsState> emit) async {
    emit(LoadingLeaveGroupState());
    final result = await leaveGroupUseCase(groupId: event.groupId, listUserId: event.listUserId);
    result.fold((l) {
      emit(ErrorLeaveGroupState(message: l));
    }, (r) {
      emit(SuccessLeaveGroupState());
    });
  }

  _onJoinGroup(JoinGroupEvent event, Emitter<GroupsState> emit) async {
    emit(LoadingJoinGroupState());
    final result = await joinGroupUseCase(groupId: event.groupId, listUserId: event.listUserId);
    result.fold((l) {
      showError(event.context, l);
      emit(ErrorJoinGroupState(message: l));
    }, (r) {
      Navigator.pushReplacement(event.context, MaterialPageRoute(builder: (context) => const HomePage()));
      emit(SuccessJoinGroupState());
    });
  }

  _onDownloadFile(DownloadFileEvent event, Emitter<GroupsState> emit) async {
    emit(LoadingDownloadFileState());

    await Future.delayed(const Duration(milliseconds: 1500));
    final result = await downloadFileUseCase(nameFile: event.nameFile, groupId: event.groupId);
    result.fold((l) {
      // showError(context, state.message);
      emit(ErrorDownloadFileState(message: l));
    }, (r) {
      emit(SuccessDownloadFileState());
    });
  }
}
