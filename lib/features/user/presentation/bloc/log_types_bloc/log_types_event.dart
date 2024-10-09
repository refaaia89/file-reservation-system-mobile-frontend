part of 'log_types_bloc.dart';

@immutable
abstract class LogTypesEvent {}

class CreateNewLogTypesEvent extends LogTypesEvent {
  final LogTypesEntity logTypesEntity;

  CreateNewLogTypesEvent({required this.logTypesEntity});
}

class DeleteLogTypesEvent extends LogTypesEvent {
  final String logTypeId;

  DeleteLogTypesEvent({required this.logTypeId});
}

class GetAllLogTypesEvent extends LogTypesEvent {
  final int page;
  final int pageSize;

  GetAllLogTypesEvent({required this.page, required this.pageSize});
}

class GetLogTypeEvent extends LogTypesEvent {
  final String logTypeId;

  GetLogTypeEvent({required this.logTypeId});
}

class UpdateCurrentLogTypesEvent extends LogTypesEvent {
  final LogTypesEntity logTypeEntity;
  final String logTypeId;

  UpdateCurrentLogTypesEvent({required this.logTypeEntity, required this.logTypeId});
}
