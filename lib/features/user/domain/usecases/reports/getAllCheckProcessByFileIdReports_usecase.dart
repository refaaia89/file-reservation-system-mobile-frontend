import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/reports_entity.dart';
import 'package:internet_application/features/user/domain/repositories/reports_repository.dart';

class GetAllCheckProcessByFileIdReportsUseCase {
  final ReportsRepository repository;

  GetAllCheckProcessByFileIdReportsUseCase(this.repository);

  Future<Either<String, List<ReportsEntity>>> call({required String fileId}) async {
    return await repository.getAllCheckProcessByFileIdReports(fileId: fileId);
  }
}
