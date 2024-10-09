part of 'roles_bloc.dart';

@immutable
abstract class RolesEvent {}


class CreateNewRolesEvent extends RolesEvent {
  final RolesEntity rolesEntity;

  CreateNewRolesEvent({required this.rolesEntity});
}

class DeleteRolesEvent extends RolesEvent {
  final String roleId;

  DeleteRolesEvent({required this.roleId});
}

class GetAllRolesEvent extends RolesEvent {
  final int page;
  final int pageSize;

  GetAllRolesEvent({required this.page, required this.pageSize});
}

class GetRoleEvent extends RolesEvent {
  final String roleId;

  GetRoleEvent({required this.roleId});
}

class UpdateCurrentRolesEvent extends RolesEvent {
  final RolesEntity roleEntity;
  final String roleId;

  UpdateCurrentRolesEvent({required this.roleEntity, required this.roleId});
}


