part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class SuccessGetAllUsersState extends UserState {
  final List<UserEntity> listAllUsers;

  const SuccessGetAllUsersState({required this.listAllUsers});
  @override
  List<Object?> get props => [listAllUsers];
}

class ErrorGetAllUsersState extends UserState {
  final String message;

  const ErrorGetAllUsersState({required this.message});
  @override
  List<Object?> get props => [message];
}

class LoadingGetAllUsersState extends UserState {}




class SuccessGetUserState extends UserState {
  final UserEntity userEntity;

  const SuccessGetUserState({required this.userEntity});
  @override
  List<Object?> get props => [userEntity];
}

class ErrorGetUserState extends UserState {
  final String message;

  const ErrorGetUserState({required this.message});
  @override
  List<Object?> get props => [message];
}

class LoadingGetUserState extends UserState {}




class SuccessCreateNewUserState extends UserState {}

class ErrorCreateNewUserState extends UserState {
  final String message;

  const ErrorCreateNewUserState({required this.message});
  @override
  List<Object?> get props => [message];
}

class LoadingCreateNewUserState extends UserState {}



class SuccessUpdateCurrentUserState extends UserState {}

class ErrorUpdateCurrentUserState extends UserState {
  final String message;

  const ErrorUpdateCurrentUserState({required this.message});
  @override
  List<Object?> get props => [message];
}

class LoadingUpdateCurrentUserState extends UserState {}


class SuccessDeleteUserState extends UserState {}

class ErrorDeleteUserState extends UserState {
  final String message;

  const ErrorDeleteUserState({required this.message});
  @override
  List<Object?> get props => [message];
}

class LoadingDeleteUserState extends UserState {}
