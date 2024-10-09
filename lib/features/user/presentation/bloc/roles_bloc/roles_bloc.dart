import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/roles_entity.dart';
import '../../../domain/usecases/roles/create_new_role_usecase.dart';
import '../../../domain/usecases/roles/delete_role_usecase.dart';
import '../../../domain/usecases/roles/get_all_roles_usecase.dart';
import '../../../domain/usecases/roles/get_role_usecase.dart';
import '../../../domain/usecases/roles/update_current_role_usecase.dart';

part 'roles_event.dart';

part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  final CreateNewRoleUseCase createNewRoleUseCase;
  final DeleteRoleUseCase deleteRoleUseCase;
  final GetAllRolesUseCase getAllRolesUseCase;
  final GetRoleUseCase getRoleUseCase;
  final UpdateCurrentRoleUseCase updateCurrentRoleUseCase;

  RolesBloc({
    required this.createNewRoleUseCase,
    required this.deleteRoleUseCase,
    required this.getAllRolesUseCase,
    required this.getRoleUseCase,
    required this.updateCurrentRoleUseCase,
  }) : super(RolesInitial()) {
    on<CreateNewRolesEvent>(_onCreateNewRole);
    on<GetAllRolesEvent>(_onGetAllRoles);
    on<GetRoleEvent>(_onGetRole);
    on<DeleteRolesEvent>(_onDeleteRole);
    on<UpdateCurrentRolesEvent>(_onUpdateCurrentRole);
  }

  _onGetAllRoles(GetAllRolesEvent event, Emitter<RolesState> emit) async {
    emit(LoadingGetAllRolesState());
    final result = await getAllRolesUseCase(page: event.page, pageSize: event.pageSize);
    result.fold((l) {
      emit(ErrorGetAllRolesState(message: l));
    }, (listAllRoles) {
      emit(SuccessGetAllRolesState(listAllRoles: listAllRoles));
    });
  }

  _onGetRole(GetRoleEvent event, Emitter<RolesState> emit) async {
    emit(LoadingGetRoleState());
    final result = await getRoleUseCase(roleId: event.roleId);
    result.fold((l) {
      emit(ErrorGetRoleState(message: l));
    }, (rolesEntity) {
      emit(SuccessGetRoleState(rolesEntity: rolesEntity));
    });
  }

  _onCreateNewRole(CreateNewRolesEvent event, Emitter<RolesState> emit) async {
    emit(LoadingCreateNewRoleState());
    final result = await createNewRoleUseCase(rolesEntity: event.rolesEntity);
    result.fold((l) {
      emit(ErrorCreateNewRoleState(message: l));
    }, (r) {
      emit(SuccessCreateNewRoleState());
    });
  }

  _onUpdateCurrentRole(UpdateCurrentRolesEvent event, Emitter<RolesState> emit) async {
    emit(LoadingUpdateCurrentRoleState());
    final result = await updateCurrentRoleUseCase(rolesEntity: event.roleEntity,roleId:event.roleId,);
    result.fold((l) {
      emit(ErrorUpdateCurrentRoleState(message: l));
    }, (r) {
      emit(SuccessUpdateCurrentRoleState());
    });
  }

  _onDeleteRole(DeleteRolesEvent event, Emitter<RolesState> emit) async {
    emit(LoadingDeleteRoleState());
    final result = await deleteRoleUseCase(roleId: event.roleId);
    result.fold((l) {
      emit(ErrorDeleteRoleState(message: l));
    }, (r) {
      emit(SuccessDeleteRoleState());
    });
  }
}
