import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/reports_entity.dart';
import 'package:internet_application/features/user/domain/repositories/reports_repository.dart';

class GetAllCheckProcessReportsUseCase {
  final ReportsRepository repository;

  GetAllCheckProcessReportsUseCase(this.repository);

  Future<Either<String, List<ReportsEntity>>> call() async {
    return await repository.getAllCheckProcessReports();
  }
}
