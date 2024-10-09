import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/permissions_entity.dart';
import '../../../domain/usecases/permissions/create_new_permission_usecase.dart';
import '../../../domain/usecases/permissions/delete_permission_usecase.dart';
import '../../../domain/usecases/permissions/get_all__permissions_usecase.dart';
import '../../../domain/usecases/permissions/get_permission_usecase.dart';
import '../../../domain/usecases/permissions/update_current_permission_usecase.dart';

part 'permissions_event.dart';

part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  final CreateNewPermissionUseCase createNewPermissionUseCase;
  final DeletePermissionUseCase deletePermissionUseCase;
  final GetAllPermissionsUseCase getAllPermissionsUseCase;
  final GetPermissionUseCase getPermissionUseCase;
  final UpdateCurrentPermissionUseCase updateCurrentPermissionUseCase;

  PermissionsBloc(
      {required this.createNewPermissionUseCase,
      required this.deletePermissionUseCase,
      required this.getAllPermissionsUseCase,
      required this.getPermissionUseCase,
      required this.updateCurrentPermissionUseCase})
      : super(PermissionsInitial()) {
  on<CreateNewPermissionsEvent>(_onCreateNewPermission);
  on<GetAllPermissionsEvent>(_onGetAllPermissions);
  on<GetPermissionEvent>(_onGetPermission);
  on<DeletePermissionsEvent>(_onDeletePermission);
  on<UpdateCurrentPermissionEvent>(_onUpdateCurrentPermission);

  }

  _onGetAllPermissions(GetAllPermissionsEvent event, Emitter<PermissionsState> emit) async {
    emit(LoadingGetAllPermissionsState());
    final result = await getAllPermissionsUseCase(page: event.page, pageSize: event.pageSize);
    result.fold((l) {
      emit(ErrorGetAllPermissionsState(message: l));
    }, (listAllPermissions) {
      emit(SuccessGetAllPermissionsState(listAllPermissions: listAllPermissions));
    });
  }

  _onGetPermission(GetPermissionEvent event, Emitter<PermissionsState> emit) async {
    emit(LoadingGetPermissionState());
    final result = await getPermissionUseCase(permissionId: event.permissionId);
    result.fold((l) {
      emit(ErrorGetPermissionState(message: l));
    }, (permissionsEntity) {
      emit(SuccessGetPermissionState(permissionsEntity: permissionsEntity));
    });
  }

  _onCreateNewPermission(CreateNewPermissionsEvent event, Emitter<PermissionsState> emit) async {
    emit(LoadingCreateNewPermissionState());
    final result = await createNewPermissionUseCase(permissionsEntity: event.permissionsEntity);
    result.fold((l) {
      emit(ErrorCreateNewPermissionState(message: l));
    }, (r) {
      emit(SuccessCreateNewPermissionState());
    });
  }

  _onUpdateCurrentPermission(UpdateCurrentPermissionEvent event, Emitter<PermissionsState> emit) async {
    emit(LoadingUpdateCurrentPermissionState());
    final result = await updateCurrentPermissionUseCase(permissionsEntity: event.permissionEntity,permissionId:event.permissionId,);
    result.fold((l) {
      emit(ErrorUpdateCurrentPermissionState(message: l));
    }, (r) {
      emit(SuccessUpdateCurrentPermissionState());
    });
  }

  _onDeletePermission(DeletePermissionsEvent event, Emitter<PermissionsState> emit) async {
    emit(LoadingDeletePermissionState());
    final result = await deletePermissionUseCase(permissionId: event.permissionId);
    result.fold((l) {
      emit(ErrorDeletePermissionState(message: l));
    }, (r) {
      emit(SuccessDeletePermissionState());
    });
  }
}
