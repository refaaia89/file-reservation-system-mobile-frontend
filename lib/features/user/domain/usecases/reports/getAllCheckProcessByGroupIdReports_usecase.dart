import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/reports_entity.dart';
import 'package:internet_application/features/user/domain/repositories/reports_repository.dart';

class GetAllCheckProcessByGroupIdReportsUseCase {
  final ReportsRepository repository;

  GetAllCheckProcessByGroupIdReportsUseCase(this.repository);

  Future<Either<String, List<ReportsEntity>>> call({required String groupId}) async {
    return await repository.getAllCheckProcessByGroupIdReports(groupId: groupId);
  }
}
