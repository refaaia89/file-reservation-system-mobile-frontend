import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_application/features/user/presentation/widgets/group_widgets.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/reports_entity.dart';
import '../../../domain/usecases/reports/getAllCheckProcessByFileIdReports_usecase.dart';
import '../../../domain/usecases/reports/getAllCheckProcessByGroupIdReports_usecase.dart';
import '../../../domain/usecases/reports/getAllCheckProcessByIsCheckedOutAtTimeIsFalse_usecase.dart';
import '../../../domain/usecases/reports/getAllCheckProcessByIsCheckedOutAtTimeIsTrued_usecase.dart';
import '../../../domain/usecases/reports/getAllCheckProcessByUserIdReports_usecase.dart';
import '../../../domain/usecases/reports/get_all_check_process_reports_usecase.dart';
import '../../pages/reports_page.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final GetAllCheckProcessReportsUseCase getAllCheckProcessReportsUseCase;
  final GetAllCheckProcessByFileIdReportsUseCase getAllCheckProcessByFileIdReportsUseCase;
  final GetAllCheckProcessByGroupIdReportsUseCase getAllCheckProcessByGroupIdReportsUseCase;
  final GetAllCheckProcessByIsCheckedOutAtTimeIsFalseUseCase getAllCheckProcessByIsCheckedOutAtTimeIsFalseUseCase;
  final GetAllCheckProcessByIsCheckedOutAtTimeIsTruedUseCase getAllCheckProcessByIsCheckedOutAtTimeIsTruedUseCase;
  final GetAllCheckProcessByUserIdReportsUseCase getAllCheckProcessByUserIdReportsUseCase;

  ReportsBloc({
    required this.getAllCheckProcessReportsUseCase,
    required this.getAllCheckProcessByFileIdReportsUseCase,
    required this.getAllCheckProcessByGroupIdReportsUseCase,
    required this.getAllCheckProcessByIsCheckedOutAtTimeIsFalseUseCase,
    required this.getAllCheckProcessByIsCheckedOutAtTimeIsTruedUseCase,
    required this.getAllCheckProcessByUserIdReportsUseCase,
  }) : super(ReportsInitial()) {
    on<GetAllCheckProcessReportsEvent>(_onGetAllCheckProcessReports);
    on<GetAllCheckProcessByFileIdReportsEvent>(_onGetAllCheckProcessByFileIdReports);
    on<GetAllCheckProcessByGroupIdReportsEvent>(_onGetAllCheckProcessByGroupIdReports);
    on<GetAllCheckProcessByIsCheckedOutAtTimeIsFalseEvent>(_onGetAllCheckProcessByIsCheckedOutAtTimeIsFalse);
    on<GetAllCheckProcessByIsCheckedOutAtTimeIsTruedEvent>(_onGetAllCheckProcessByIsCheckedOutAtTimeIsTrued);
    on<GetAllCheckProcessByUserIdReportsEvent>(_onGetAllCheckProcessByUserIdReports);
  }

  _onGetAllCheckProcessReports(GetAllCheckProcessReportsEvent event, Emitter<ReportsState> emit) async {
    emit(LoadingGetAllCheckProcessReportsState());
    final result = await getAllCheckProcessReportsUseCase();
    result.fold((l) {
      showError(event.context, l);
      emit(ErrorGetAllCheckProcessReportsState(message: l));
    }, (list) {
      Navigator.push(event.context, MaterialPageRoute(builder: (context) => ReportsPage(listAllReports: list)));

      emit(SuccessGetAllCheckProcessReportsState(listReportsEntity: list));
    });
  }

  _onGetAllCheckProcessByFileIdReports(GetAllCheckProcessByFileIdReportsEvent event, Emitter<ReportsState> emit) async {
    emit(LoadingGetAllCheckProcessByFileIdReportsState());
    final result = await getAllCheckProcessByFileIdReportsUseCase(fileId: event.fileId);
    result.fold((l) {
      showError(event.context, l);
      emit(ErrorGetAllCheckProcessByFileIdReportsState(message: l));
    }, (list) {
      Navigator.push(event.context, MaterialPageRoute(builder: (context) => ReportsPage(listAllReports: list)));
      emit(SuccessGetAllCheckProcessByFileIdReportsState(listReportsEntity: list));
    });
  }

  _onGetAllCheckProcessByGroupIdReports(GetAllCheckProcessByGroupIdReportsEvent event, Emitter<ReportsState> emit) async {
    emit(LoadingGetAllCheckProcessByGroupIdReportsState());
    final result = await getAllCheckProcessByGroupIdReportsUseCase(groupId: event.groupId);
    result.fold((l) {
      showError(event.context, l);
      emit(ErrorGetAllCheckProcessByGroupIdReportsState(message: l));
    }, (list) {
      Navigator.push(event.context, MaterialPageRoute(builder: (context) => ReportsPage(listAllReports: list)));

      emit(SuccessGetAllCheckProcessByGroupIdReportsState(listReportsEntity: list));
    });
  }

  _onGetAllCheckProcessByIsCheckedOutAtTimeIsFalse(GetAllCheckProcessByIsCheckedOutAtTimeIsFalseEvent event, Emitter<ReportsState> emit) async {
    emit(LoadingGetAllCheckProcessByIsCheckedOutAtTimeIsFalseState());
    final result = await getAllCheckProcessByIsCheckedOutAtTimeIsFalseUseCase();
    result.fold((l) {
      showError(event.context, l);
      emit(ErrorGetAllCheckProcessByIsCheckedOutAtTimeIsFalseState(message: l));
    }, (list) {
      Navigator.push(event.context, MaterialPageRoute(builder: (context) => ReportsPage(listAllReports: list)));

      emit(SuccessGetAllCheckProcessByIsCheckedOutAtTimeIsFalseState(listReportsEntity: list));
    });
  }

  _onGetAllCheckProcessByIsCheckedOutAtTimeIsTrued(GetAllCheckProcessByIsCheckedOutAtTimeIsTruedEvent event, Emitter<ReportsState> emit) async {
    emit(LoadingGetAllCheckProcessByIsCheckedOutAtTimeIsTruedState());
    final result = await getAllCheckProcessByIsCheckedOutAtTimeIsTruedUseCase();
    result.fold((l) {
      showError(event.context, l);

      emit(ErrorGetAllCheckProcessByIsCheckedOutAtTimeIsTruedState(message: l));
    }, (list) {
      Navigator.push(event.context, MaterialPageRoute(builder: (context) => ReportsPage(listAllReports: list)));

      emit(SuccessGetAllCheckProcessByIsCheckedOutAtTimeIsTruedState(listReportsEntity: list));
    });
  }

  _onGetAllCheckProcessByUserIdReports(GetAllCheckProcessByUserIdReportsEvent event, Emitter<ReportsState> emit) async {
    emit(LoadingGetAllCheckProcessByUserIdReportsState());
    final result = await getAllCheckProcessByUserIdReportsUseCase(userId: event.userId);
    result.fold((l) {
      showError(event.context, l);
      emit(ErrorGetAllCheckProcessByUserIdReportsState(message: l));
    }, (list) {
      Navigator.push(event.context, MaterialPageRoute(builder: (context) => ReportsPage(listAllReports: list)));

      emit(SuccessGetAllCheckProcessByUserIdReportsState(listReportsEntity: list));
    });
  }
}
