import 'package:dartz/dartz.dart';

import '../../repositories/group_repository.dart';

class DownloadFileUseCase {
  final GroupRepository repository;

  DownloadFileUseCase(this.repository);

  Future<Either<String, String>> call({required String groupId, required String nameFile}) async {
    return await repository.downloadFile(groupId: groupId, nameFile: nameFile);
  }
}
