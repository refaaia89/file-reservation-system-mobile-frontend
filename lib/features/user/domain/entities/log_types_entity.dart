import 'package:equatable/equatable.dart';

class LogTypesEntity extends Equatable {
  final String logTypeId;
  final String name;
  final DateTime? createAt;
  final DateTime? updateAt;

  const LogTypesEntity({
    required this.logTypeId,
    required this.name,
    required this.createAt,
    required this.updateAt,
  });

  @override
  List<Object?> get props => [
        logTypeId,
        name,
        createAt,
        updateAt,
      ];
}
