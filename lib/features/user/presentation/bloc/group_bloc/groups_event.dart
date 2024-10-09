part of 'groups_bloc.dart';

@immutable
abstract class GroupsEvent {}


class IsMeInGroupEvent extends GroupsEvent {
  final String groupId;

  IsMeInGroupEvent({required this.groupId});
}

class AddFileEvent extends GroupsEvent {}

class AddMembersToGroupEvent extends GroupsEvent {}

class CheckInFilesEvent extends GroupsEvent {}

class CheckOutFilesEvent extends GroupsEvent {}

class DownloadFileEvent extends GroupsEvent {
  final String groupId;
  final String nameFile;

  DownloadFileEvent({required this.groupId, required this.nameFile});

}

class RemoveUserFromGroupEvent extends GroupsEvent {
  final String userId;
  final String groupId;

  RemoveUserFromGroupEvent({required this.userId, required this.groupId});
}

class SearchGroupEvent extends GroupsEvent {}

class SearchUserEvent extends GroupsEvent {}

class UpdateFileEvent extends GroupsEvent {}

class GetAllGroupsEvent extends GroupsEvent {
  final int page;
  final int pageSize;

  GetAllGroupsEvent({required this.page, required this.pageSize});
}

class GetGroupEvent extends GroupsEvent {
  final String groupId;

  GetGroupEvent({required this.groupId});
}

class CreateNewGroupEvent extends GroupsEvent {
  final GroupEntity groupEntity;

  CreateNewGroupEvent({required this.groupEntity});
}

class UpdateCurrentGroupEvent extends GroupsEvent {
  final GroupEntity groupEntity;
  final String groupId;

  UpdateCurrentGroupEvent({required this.groupEntity,required this.groupId});
}

class DeleteGroupEvent extends GroupsEvent {
  final String groupId;

  DeleteGroupEvent({required this.groupId});
}

class JoinGroupEvent extends GroupsEvent {
  final String groupId;
  final List<String> listUserId;
  final BuildContext context;

  JoinGroupEvent( {required this.groupId, required this.listUserId,required this.context,});
}

class LeaveGroupEvent extends GroupsEvent {
  final String groupId;
  final List<String> listUserId;

  LeaveGroupEvent({required this.groupId, required this.listUserId});
}
