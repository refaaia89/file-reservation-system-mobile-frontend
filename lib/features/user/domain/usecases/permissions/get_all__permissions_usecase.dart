import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/permissions_entity.dart';
import 'package:internet_application/features/user/domain/repositories/permissions_repository.dart';

class GetAllPermissionsUseCase {
  final PermissionsRepository repository;

  GetAllPermissionsUseCase(this.repository);

  Future<Either<String, List<PermissionsEntity>>> call({required int page,required int pageSize}) async {
    return await repository.getAllPermissions(page: page, pageSize: pageSize);
  }
}
