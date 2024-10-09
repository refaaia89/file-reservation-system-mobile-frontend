import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/reports_entity.dart';
import 'package:internet_application/features/user/domain/repositories/reports_repository.dart';

class GetAllCheckProcessByUserIdReportsUseCase {
  final ReportsRepository repository;

  GetAllCheckProcessByUserIdReportsUseCase(this.repository);

  Future<Either<String, List<ReportsEntity>>> call({required String userId}) async {
    return await repository.getAllCheckProcessByUserIdReports(userId: userId);
  }
}
