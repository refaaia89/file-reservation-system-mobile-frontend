part of 'roles_bloc.dart';

@immutable
abstract class RolesState {}

class RolesInitial extends RolesState {}


class LoadingGetAllRolesState extends RolesState {}
class SuccessGetAllRolesState extends RolesState {
  final List<RolesEntity> listAllRoles;
  SuccessGetAllRolesState({required this.listAllRoles});
}
class ErrorGetAllRolesState extends RolesState {
  final String message;
  ErrorGetAllRolesState({required this.message});
}


class LoadingGetRoleState extends RolesState {}
class SuccessGetRoleState extends RolesState {
  final RolesEntity rolesEntity;
  SuccessGetRoleState({required this.rolesEntity});
}
class ErrorGetRoleState extends RolesState {
  final String message;
  ErrorGetRoleState({required this.message});
}


class LoadingCreateNewRoleState extends RolesState {}
class SuccessCreateNewRoleState extends RolesState {}
class ErrorCreateNewRoleState extends RolesState {
  final String message;
  ErrorCreateNewRoleState({required this.message});
}



class LoadingUpdateCurrentRoleState extends RolesState {}
class SuccessUpdateCurrentRoleState extends RolesState {}
class ErrorUpdateCurrentRoleState extends RolesState {
  final String message;
  ErrorUpdateCurrentRoleState({required this.message});
}


class LoadingDeleteRoleState extends RolesState {}
class SuccessDeleteRoleState extends RolesState {}
class ErrorDeleteRoleState extends RolesState {
  final String message;
  ErrorDeleteRoleState({required this.message});
}

