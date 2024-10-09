part of 'groups_bloc.dart';

@immutable
abstract class GroupsState {}

class GroupsInitial extends GroupsState {}

class AddFileLoadingState extends GroupsState {}

class AddFileSuccessState extends GroupsState {}

class AddFileErrorState extends GroupsState {
  final String message;

  AddFileErrorState({required this.message});
}

class AddMembersToGroupLoadingState extends GroupsState {}

class AddMembersToGroupSuccessState extends GroupsState {}

class AddMembersToGroupErrorState extends GroupsState {
  final String message;

  AddMembersToGroupErrorState({required this.message});
}

class ChickInFilesLoadingState extends GroupsState {}

class ChickInFilesSuccessState extends GroupsState {}

class ChickInFilesErrorState extends GroupsState {
  final String message;

  ChickInFilesErrorState({required this.message});
}

class CheckOutFilesLoadingState extends GroupsState {}
class CheckOutFilesSuccessState extends GroupsState {}
class CheckOutFilesErrorState extends GroupsState {
  final String message;

  CheckOutFilesErrorState({required this.message});
}




class GetMyAccountLoadingState extends GroupsState {}

class GetMyAccountSuccessState extends GroupsState {
  final UserEntity userEntity;

  GetMyAccountSuccessState({required this.userEntity});
}

class GetMyAccountErrorState extends GroupsState {
  final String message;

  GetMyAccountErrorState({required this.message});
}

class IsMeInGroupLoadingState extends GroupsState {}

class IsMeInGroupSuccessState extends GroupsState {}

class IsMeInGroupErrorState extends GroupsState {
  final String message;

  IsMeInGroupErrorState({required this.message});
}


class RemoveUserFromGroupLoadingState extends GroupsState {}

class RemoveUserFromGroupSuccessState extends GroupsState {
  final String message;

  RemoveUserFromGroupSuccessState({required this.message});
}

class RemoveUserFromGroupErrorState extends GroupsState {
  final String message;

  RemoveUserFromGroupErrorState({required this.message});
}

class SearchGroupLoadingState extends GroupsState {}

class SearchGroupSuccessState extends GroupsState {}

class SearchGroupErrorState extends GroupsState {
  final String message;

  SearchGroupErrorState({required this.message});
}

class SearchUserLoadingState extends GroupsState {}

class SearchUserSuccessState extends GroupsState {}

class SearchUserErrorState extends GroupsState {
  final String message;

  SearchUserErrorState({required this.message});
}



class LoadingGetAllGroupsState extends GroupsState {}
class SuccessGetAllGroupsState extends GroupsState {
  final List<GroupEntity> listAllGroups;
  SuccessGetAllGroupsState({required this.listAllGroups});
  }
class ErrorGetAllGroupsState extends GroupsState {
  final String message;
   ErrorGetAllGroupsState({required this.message});
}


class LoadingGetGroupState extends GroupsState {}
class SuccessGetGroupState extends GroupsState {
  final GroupEntity groupEntity;
   SuccessGetGroupState({required this.groupEntity});
}
class ErrorGetGroupState extends GroupsState {
  final String message;
   ErrorGetGroupState({required this.message});
}


class LoadingCreateNewGroupState extends GroupsState {}
class SuccessCreateNewGroupState extends GroupsState {}
class ErrorCreateNewGroupState extends GroupsState {
  final String message;
  ErrorCreateNewGroupState({required this.message});
}



class LoadingUpdateCurrentGroupState extends GroupsState {}
class SuccessUpdateCurrentGroupState extends GroupsState {}
class ErrorUpdateCurrentGroupState extends GroupsState {
  final String message;
  ErrorUpdateCurrentGroupState({required this.message});
}


class LoadingDeleteGroupState extends GroupsState {}
class SuccessDeleteGroupState extends GroupsState {}
class ErrorDeleteGroupState extends GroupsState {
  final String message;
  ErrorDeleteGroupState({required this.message});
}


class LoadingJoinGroupState extends GroupsState {}
class SuccessJoinGroupState extends GroupsState {}
class ErrorJoinGroupState extends GroupsState {
  final String message;
  ErrorJoinGroupState({required this.message});
}


class LoadingLeaveGroupState extends GroupsState {}
class SuccessLeaveGroupState extends GroupsState {}
class ErrorLeaveGroupState extends GroupsState {
  final String message;
  ErrorLeaveGroupState({required this.message});
}



class LoadingDownloadFileState extends GroupsState {}
class SuccessDownloadFileState extends GroupsState {}
class ErrorDownloadFileState extends GroupsState {
  final String message;
  ErrorDownloadFileState({required this.message});
}
