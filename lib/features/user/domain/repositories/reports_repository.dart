import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/domain/entities/reports_entity.dart';

abstract class ReportsRepository {
  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessReports();

  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByGroupIdReports({required String groupId});

  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByFileIdReports({required String fileId});

  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByUserIdReports({required String userId});

  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByIsCheckedOutAtTimeIsTrued();

  Future<Either<String, List<ReportsEntity>>> getAllCheckProcessByIsCheckedOutAtTimeIsFalse();
}
