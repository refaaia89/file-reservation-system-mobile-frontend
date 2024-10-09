part of 'reports_bloc.dart';

@immutable
abstract class ReportsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllCheckProcessReportsEvent extends ReportsEvent {
  final BuildContext context;

  GetAllCheckProcessReportsEvent({required this.context});
}

class GetAllCheckProcessByGroupIdReportsEvent extends ReportsEvent {
  final BuildContext context;
  final String groupId;

  GetAllCheckProcessByGroupIdReportsEvent({required this.groupId,required this.context});
}

class GetAllCheckProcessByFileIdReportsEvent extends ReportsEvent {
  final String fileId;
  final BuildContext context;
  GetAllCheckProcessByFileIdReportsEvent({required this.context,required this.fileId});
}

class GetAllCheckProcessByUserIdReportsEvent extends ReportsEvent {
  final String userId;
  final BuildContext context;
  GetAllCheckProcessByUserIdReportsEvent({required this.userId,required this.context});
}

class GetAllCheckProcessByIsCheckedOutAtTimeIsTruedEvent extends ReportsEvent {
  final BuildContext context;

  GetAllCheckProcessByIsCheckedOutAtTimeIsTruedEvent({required this.context});
}


class GetAllCheckProcessByIsCheckedOutAtTimeIsFalseEvent extends ReportsEvent {
  final BuildContext context;

  GetAllCheckProcessByIsCheckedOutAtTimeIsFalseEvent({required this.context});
}
