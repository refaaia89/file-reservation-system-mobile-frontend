part of 'logs_bloc.dart';

@immutable
abstract class LogsEvent {}

class GetAllLogsEvent extends LogsEvent {
  final int page;
  final int pageSize;

  GetAllLogsEvent({required this.page, required this.pageSize});
}

class GetLogEvent extends LogsEvent {
  final String logId;

  GetLogEvent({required this.logId});
}
