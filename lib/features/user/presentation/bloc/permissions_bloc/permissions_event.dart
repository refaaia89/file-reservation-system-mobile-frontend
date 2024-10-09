part of 'permissions_bloc.dart';

@immutable
abstract class PermissionsEvent {}


class CreateNewPermissionsEvent extends PermissionsEvent {
  final PermissionsEntity permissionsEntity;

  CreateNewPermissionsEvent({required this.permissionsEntity});
}

class DeletePermissionsEvent extends PermissionsEvent {
  final String permissionId;

  DeletePermissionsEvent({required this.permissionId});
}

class GetAllPermissionsEvent extends PermissionsEvent {
  final int page;
  final int pageSize;

  GetAllPermissionsEvent({required this.page, required this.pageSize});
}

class GetPermissionEvent extends PermissionsEvent {
  final String permissionId;

  GetPermissionEvent({required this.permissionId});
}

class UpdateCurrentPermissionEvent extends PermissionsEvent {
  final PermissionsEntity permissionEntity;
  final String permissionId;

  UpdateCurrentPermissionEvent({required this.permissionEntity, required this.permissionId});
}
