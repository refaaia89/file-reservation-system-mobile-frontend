import 'package:dartz/dartz.dart';
import 'package:internet_application/features/user/data/models/reports_model.dart';


abstract class ReportsRemoteDataSource{
  Future<Either<String, List<ReportsModel>>> getAllCheckProcessReports();

  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByGroupIdReports({required String groupId});

  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByFileIdReports({required String fileId});

  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByUserIdReports({required String userId});

  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByIsCheckedOutAtTimeIsTrued();

  Future<Either<String, List<ReportsModel>>> getAllCheckProcessByIsCheckedOutAtTimeIsFalse();
}