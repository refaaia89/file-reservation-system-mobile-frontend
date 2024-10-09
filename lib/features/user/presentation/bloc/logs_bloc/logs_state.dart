part of 'logs_bloc.dart';

@immutable
abstract class LogsState {}

class LogsInitial extends LogsState {}



class LoadingGetAllLogsState extends LogsState {}
class SuccessGetAllLogsState extends LogsState {
  final List<LogsEntity> listAllLogs;
  SuccessGetAllLogsState({required this.listAllLogs});
}
class ErrorGetAllLogsState extends LogsState {
  final String message;
  ErrorGetAllLogsState({required this.message});
}


class LoadingGetLogState extends LogsState {}
class SuccessGetLogState extends LogsState {
  final LogsEntity logsEntity;
  SuccessGetLogState({required this.logsEntity});
}
class ErrorGetLogState extends LogsState {
  final String message;
  ErrorGetLogState({required this.message});
}

