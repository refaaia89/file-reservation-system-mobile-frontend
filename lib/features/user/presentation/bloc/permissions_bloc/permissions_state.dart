part of 'permissions_bloc.dart';

@immutable
abstract class PermissionsState {}

class PermissionsInitial extends PermissionsState {}


class LoadingGetAllPermissionsState extends PermissionsState {}
class SuccessGetAllPermissionsState extends PermissionsState {
  final List<PermissionsEntity> listAllPermissions;
  SuccessGetAllPermissionsState({required this.listAllPermissions});
}
class ErrorGetAllPermissionsState extends PermissionsState {
  final String message;
  ErrorGetAllPermissionsState({required this.message});
}


class LoadingGetPermissionState extends PermissionsState {}
class SuccessGetPermissionState extends PermissionsState {
  final PermissionsEntity permissionsEntity;
  SuccessGetPermissionState({required this.permissionsEntity});
}
class ErrorGetPermissionState extends PermissionsState {
  final String message;
  ErrorGetPermissionState({required this.message});
}


class LoadingCreateNewPermissionState extends PermissionsState {}
class SuccessCreateNewPermissionState extends PermissionsState {}
class ErrorCreateNewPermissionState extends PermissionsState {
  final String message;
  ErrorCreateNewPermissionState({required this.message});
}



class LoadingUpdateCurrentPermissionState extends PermissionsState {}
class SuccessUpdateCurrentPermissionState extends PermissionsState {}
class ErrorUpdateCurrentPermissionState extends PermissionsState {
  final String message;
  ErrorUpdateCurrentPermissionState({required this.message});
}


class LoadingDeletePermissionState extends PermissionsState {}
class SuccessDeletePermissionState extends PermissionsState {}
class ErrorDeletePermissionState extends PermissionsState {
  final String message;
  ErrorDeletePermissionState({required this.message});
}

