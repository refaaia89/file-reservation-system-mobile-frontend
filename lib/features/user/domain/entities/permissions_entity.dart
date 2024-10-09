import 'package:equatable/equatable.dart';

class PermissionsEntity extends Equatable {
  final int permissionId;
  final String name;
  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PermissionsEntity({
    required this.permissionId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        permissionId,
        name,
        description,
        createdAt,
        updatedAt,
      ];
}
