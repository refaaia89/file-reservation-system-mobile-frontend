import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/log_types_entity.dart';
import '../../../domain/usecases/log types/create_new_log_type_usecase.dart';
import '../../../domain/usecases/log types/delete_log_type_usecase.dart';
import '../../../domain/usecases/log types/get_all_log_types_usecase.dart';
import '../../../domain/usecases/log types/get_log_type_usecase.dart';
import '../../../domain/usecases/log types/update_current_log_type_usecase.dart';

part 'log_types_event.dart';

part 'log_types_state.dart';

class LogTypesBloc extends Bloc<LogTypesEvent, LogTypesState> {
  final GetAllLogTypesUseCase getAllLogTypesUseCase;
  final GetLogTypeUseCase getLogTypeUseCase;
  final CreateNewLogTypeUseCase createNewLogTypeUseCase;
  final DeleteLogTypeUseCase deleteLogTypeUseCase;
  final UpdateCurrentLogTypeUseCase updateCurrentLogTypeUseCase;

  LogTypesBloc({
    required this.getAllLogTypesUseCase,
    required this.getLogTypeUseCase,
    required this.createNewLogTypeUseCase,
    required this.deleteLogTypeUseCase,
    required this.updateCurrentLogTypeUseCase,
  }) : super(LogTypesInitial()) {
    on<CreateNewLogTypesEvent>(_onCreateNewLogType);
    on<GetAllLogTypesEvent>(_onGetAllLogTypes);
    on<GetLogTypeEvent>(_onGetLogType);
    on<DeleteLogTypesEvent>(_onDeleteLogType);
    on<UpdateCurrentLogTypesEvent>(_onUpdateCurrentLogType);
  }

  _onGetAllLogTypes(GetAllLogTypesEvent event, Emitter<LogTypesState> emit) async {
    emit(LoadingGetAllLogTypesState());
    final result = await getAllLogTypesUseCase(page: event.page, pageSize: event.pageSize);
    result.fold((l) {
      emit(ErrorGetAllLogTypesState(message: l));
    }, (listAllLogTypes) {
      emit(SuccessGetAllLogTypesState(listAllLogTypes: listAllLogTypes));
    });
  }

  _onGetLogType(GetLogTypeEvent event, Emitter<LogTypesState> emit) async {
    emit(LoadingGetLogTypeState());
    final result = await getLogTypeUseCase(logTypeId: event.logTypeId);
    result.fold((l) {
      emit(ErrorGetLogTypeState(message: l));
    }, (logTypesEntity) {
      emit(SuccessGetLogTypeState(logTypesEntity: logTypesEntity));
    });
  }

  _onCreateNewLogType(CreateNewLogTypesEvent event, Emitter<LogTypesState> emit) async {
    emit(LoadingCreateNewLogTypeState());
    final result = await createNewLogTypeUseCase(logTypesEntity: event.logTypesEntity);
    result.fold((l) {
      emit(ErrorCreateNewLogTypeState(message: l));
    }, (r) {
      emit(SuccessCreateNewLogTypeState());
    });
  }

  _onUpdateCurrentLogType(UpdateCurrentLogTypesEvent event, Emitter<LogTypesState> emit) async {
    emit(LoadingUpdateCurrentLogTypeState());
    final result = await updateCurrentLogTypeUseCase(
      logTypesEntity: event.logTypeEntity,
      logTypeId: event.logTypeId,
    );
    result.fold((l) {
      emit(ErrorUpdateCurrentLogTypeState(message: l));
    }, (r) {
      emit(SuccessUpdateCurrentLogTypeState());
    });
  }

  _onDeleteLogType(DeleteLogTypesEvent event, Emitter<LogTypesState> emit) async {
    emit(LoadingDeleteLogTypeState());
    final result = await deleteLogTypeUseCase(logTypeId: event.logTypeId);
    result.fold((l) {
      emit(ErrorDeleteLogTypeState(message: l));
    }, (r) {
      emit(SuccessDeleteLogTypeState());
    });
  }
}
