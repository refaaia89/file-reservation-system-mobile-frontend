part of 'reports_bloc.dart';

@immutable
abstract class ReportsState {}

class ReportsInitial extends ReportsState {}


class ErrorGetAllCheckProcessReportsState extends ReportsState {
  final String message;

  ErrorGetAllCheckProcessReportsState({required this.message});
}
class SuccessGetAllCheckProcessReportsState extends ReportsState {
  final List<ReportsEntity> listReportsEntity;

  SuccessGetAllCheckProcessReportsState({required this.listReportsEntity});
}
class LoadingGetAllCheckProcessReportsState extends ReportsState {}



class ErrorGetAllCheckProcessByGroupIdReportsState extends ReportsState {
  final String message;

  ErrorGetAllCheckProcessByGroupIdReportsState({required this.message});
}
class SuccessGetAllCheckProcessByGroupIdReportsState extends ReportsState {
  final List<ReportsEntity> listReportsEntity;

  SuccessGetAllCheckProcessByGroupIdReportsState({required this.listReportsEntity});
}
class LoadingGetAllCheckProcessByGroupIdReportsState extends ReportsState {}



class ErrorGetAllCheckProcessByFileIdReportsState extends ReportsState {
  final String message;

  ErrorGetAllCheckProcessByFileIdReportsState({required this.message});
}
class SuccessGetAllCheckProcessByFileIdReportsState extends ReportsState {
  final List<ReportsEntity> listReportsEntity;

  SuccessGetAllCheckProcessByFileIdReportsState({required this.listReportsEntity});
}
class LoadingGetAllCheckProcessByFileIdReportsState extends ReportsState {}




class ErrorGetAllCheckProcessByUserIdReportsState extends ReportsState {
  final String message;

  ErrorGetAllCheckProcessByUserIdReportsState({required this.message});
}
class SuccessGetAllCheckProcessByUserIdReportsState extends ReportsState {
  final List<ReportsEntity> listReportsEntity;

  SuccessGetAllCheckProcessByUserIdReportsState({required this.listReportsEntity});
}
class LoadingGetAllCheckProcessByUserIdReportsState extends ReportsState {}


class ErrorGetAllCheckProcessByIsCheckedOutAtTimeIsTruedState extends ReportsState {
  final String message;

  ErrorGetAllCheckProcessByIsCheckedOutAtTimeIsTruedState({required this.message});
}
class SuccessGetAllCheckProcessByIsCheckedOutAtTimeIsTruedState extends ReportsState {
  final List<ReportsEntity> listReportsEntity;

  SuccessGetAllCheckProcessByIsCheckedOutAtTimeIsTruedState({required this.listReportsEntity});
}
class LoadingGetAllCheckProcessByIsCheckedOutAtTimeIsTruedState extends ReportsState {}




class ErrorGetAllCheckProcessByIsCheckedOutAtTimeIsFalseState extends ReportsState {
  final String message;

  ErrorGetAllCheckProcessByIsCheckedOutAtTimeIsFalseState({required this.message});
}
class SuccessGetAllCheckProcessByIsCheckedOutAtTimeIsFalseState extends ReportsState {
  final List<ReportsEntity> listReportsEntity;

  SuccessGetAllCheckProcessByIsCheckedOutAtTimeIsFalseState({required this.listReportsEntity});
}
class LoadingGetAllCheckProcessByIsCheckedOutAtTimeIsFalseState extends ReportsState {}

