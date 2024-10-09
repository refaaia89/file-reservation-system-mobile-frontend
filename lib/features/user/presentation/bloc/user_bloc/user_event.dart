part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class GetAllUsersEvent extends UserEvent {
  final int page;
  final int pageSize;

  const GetAllUsersEvent({required this.page, required this.pageSize});

  @override
  List<Object?> get props => [page, pageSize];
}
class GetUserEvent extends UserEvent {
  final String userId;

  const GetUserEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class CreateNewUserEvent extends UserEvent{
  final AuthEntity authEntity;
  final String roleId;

  const CreateNewUserEvent({required this.authEntity, required this.roleId});
  @override
  List<Object?> get props => [authEntity,roleId];
}


class UpdateCurrentUserEvent extends UserEvent{
  final AuthEntity authEntity;
  final String roleId;
  final String userId;

  const UpdateCurrentUserEvent({required this.authEntity, required this.roleId,required this.userId,});
  @override
  List<Object?> get props => [authEntity,roleId,userId];
}


class DeleteUserEvent extends UserEvent{
  final String userId;

  const DeleteUserEvent({required this.userId,});
  @override
  List<Object?> get props => [userId];
}
