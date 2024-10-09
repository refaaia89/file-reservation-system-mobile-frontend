import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/permissions_entity.dart';
import 'package:internet_application/features/user/domain/repositories/permissions_repository.dart';

class CreateNewPermissionUseCase {
  final PermissionsRepository repository;

  CreateNewPermissionUseCase(this.repository);

  Future<Either<String, Unit>> call({required PermissionsEntity permissionsEntity}) async {
    return await repository.createNewPermission(permissionsEntity: permissionsEntity);
  }
}
