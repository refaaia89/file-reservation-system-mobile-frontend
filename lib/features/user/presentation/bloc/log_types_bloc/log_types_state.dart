part of 'log_types_bloc.dart';

@immutable
abstract class LogTypesState {}

class LogTypesInitial extends LogTypesState {}

class LoadingGetAllLogTypesState extends LogTypesState {}
class SuccessGetAllLogTypesState extends LogTypesState {
  final List<LogTypesEntity> listAllLogTypes;
  SuccessGetAllLogTypesState({required this.listAllLogTypes});
}
class ErrorGetAllLogTypesState extends LogTypesState {
  final String message;
  ErrorGetAllLogTypesState({required this.message});
}


class LoadingGetLogTypeState extends LogTypesState {}
class SuccessGetLogTypeState extends LogTypesState {
  final LogTypesEntity logTypesEntity;
  SuccessGetLogTypeState({required this.logTypesEntity});
}
class ErrorGetLogTypeState extends LogTypesState {
  final String message;
  ErrorGetLogTypeState({required this.message});
}


class LoadingCreateNewLogTypeState extends LogTypesState {}
class SuccessCreateNewLogTypeState extends LogTypesState {}
class ErrorCreateNewLogTypeState extends LogTypesState {
  final String message;
  ErrorCreateNewLogTypeState({required this.message});
}



class LoadingUpdateCurrentLogTypeState extends LogTypesState {}
class SuccessUpdateCurrentLogTypeState extends LogTypesState {}
class ErrorUpdateCurrentLogTypeState extends LogTypesState {
  final String message;
  ErrorUpdateCurrentLogTypeState({required this.message});
}


class LoadingDeleteLogTypeState extends LogTypesState {}
class SuccessDeleteLogTypeState extends LogTypesState {}
class ErrorDeleteLogTypeState extends LogTypesState {
  final String message;
  ErrorDeleteLogTypeState({required this.message});
}

