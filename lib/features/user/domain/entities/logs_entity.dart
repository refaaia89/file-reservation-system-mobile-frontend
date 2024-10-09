import 'package:equatable/equatable.dart';

class LogsEntity extends Equatable{
final String logId;
final String name;

  const LogsEntity({required this.logId,required this.name, });
  @override
  List<Object?> get props => [logId,name];

}