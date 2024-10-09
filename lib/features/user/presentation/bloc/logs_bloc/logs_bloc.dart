import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/logs_entity.dart';
import '../../../domain/usecases/logs/get_all_logs_usecase.dart';
import '../../../domain/usecases/logs/get_log_usecase.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final GetAllLogsUseCase getAllLogsUseCase;
  final GetLogUseCase getLogUseCase;
  LogsBloc({required this.getAllLogsUseCase,required this.getLogUseCase}) : super(LogsInitial()) {
  on<GetAllLogsEvent>(_onGetAllLogs);
  on<GetLogEvent>(_onGetLog);
  }


  _onGetAllLogs(GetAllLogsEvent event, Emitter<LogsState> emit) async {
    emit(LoadingGetAllLogsState());
    final result = await getAllLogsUseCase(page: event.page, pageSize: event.pageSize);
    result.fold((l) {
      emit(ErrorGetAllLogsState(message: l));
    }, (listAllLogs) {
      emit(SuccessGetAllLogsState(listAllLogs: listAllLogs));
    });
  }

  _onGetLog(GetLogEvent event, Emitter<LogsState> emit) async {
    emit(LoadingGetLogState());
    final result = await getLogUseCase(logId: event.logId);
    result.fold((l) {
      emit(ErrorGetLogState(message: l));
    }, (logsEntity) {
      emit(SuccessGetLogState(logsEntity: logsEntity));
    });
  }

}
