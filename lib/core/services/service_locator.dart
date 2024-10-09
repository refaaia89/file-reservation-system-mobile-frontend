import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_application/core/services/log_service.dart';
import 'package:internet_application/core/services/storage_service.dart';
import 'package:internet_application/features/auth/data/datasource/remote_datasource/auth_reomte_datasource_impl.dart';
import 'package:internet_application/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:internet_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:internet_application/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:internet_application/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:internet_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/file_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/file_remote_datasource_impl.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/group_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/group_remote_datasource_impl.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/log_types_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/log_types_remote_datasource_impl.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/logs_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/logs_remote_datasource_impl.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/permissions_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/permissions_remote_datasources_impl.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/reports_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/reports_remote_datasource_impl.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/roles_remote_datasource.dart';
import 'package:internet_application/features/user/data/datasource/remote_datasources/roles_remote_datasources_impl.dart';
import 'package:internet_application/features/user/data/repositories/files_repositories_impl.dart';
import 'package:internet_application/features/user/data/repositories/log_types_repositories_impl.dart';
import 'package:internet_application/features/user/data/repositories/logs_repositories_impl.dart';
import 'package:internet_application/features/user/data/repositories/permissions_repositories_impl.dart';
import 'package:internet_application/features/user/data/repositories/reports_repositories_impl.dart';
import 'package:internet_application/features/user/data/repositories/roles_repositories_impl.dart';
import 'package:internet_application/features/user/data/repositories/user_repositories_impl.dart';
import 'package:internet_application/features/user/domain/repositories/files_repository.dart';
import 'package:internet_application/features/user/domain/repositories/log_types_repository.dart';
import 'package:internet_application/features/user/domain/repositories/logs_repository.dart';
import 'package:internet_application/features/user/domain/repositories/permissions_repository.dart';
import 'package:internet_application/features/user/domain/repositories/reports_repository.dart';
import 'package:internet_application/features/user/domain/repositories/roles_repository.dart';
import 'package:internet_application/features/user/domain/repositories/user_repository.dart';
import 'package:internet_application/features/user/domain/usecases/files/check_in_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/files/check_out_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/files/create_new_file_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/files/delete_file_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/files/get_all_files_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/files/git_file_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/files/update_current_file_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/group/create_new_group_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/group/download_file_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/group/update_current_group_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/users/create_new_User_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/users/delete_user_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/users/get_all_users_usecase.dart';
import 'package:internet_application/features/user/domain/usecases/users/update_current_user_usecase.dart';
import 'package:internet_application/features/user/presentation/bloc/files_bloc/files_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/log_types_bloc/log_types_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/logs_bloc/logs_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/permissions_bloc/permissions_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/reports_bloc/reports_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/roles_bloc/roles_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasource/local_datasource/auth_local_data_source_impl.dart';
import '../../features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import '../../features/auth/data/datasource/remote_datasource/auth_remote_datasource.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/user/data/datasource/remote_datasources/user_remote_datasource.dart';
import '../../features/user/data/datasource/remote_datasources/user_remote_datasource_impl.dart';
import '../../features/user/data/repositories/group_repositories_impl.dart';
import '../../features/user/domain/repositories/group_repository.dart';
import '../../features/user/domain/usecases/get_my_account_usecase.dart';
import '../../features/user/domain/usecases/group/delete_group_usecase.dart';
import '../../features/user/domain/usecases/group/get_all_groups_usecase.dart';
import '../../features/user/domain/usecases/group/get_group_usecase.dart';
import '../../features/user/domain/usecases/group/join_group_usecase.dart';
import '../../features/user/domain/usecases/group/leave_group_usecase.dart';
import '../../features/user/domain/usecases/log types/create_new_log_type_usecase.dart';
import '../../features/user/domain/usecases/log types/delete_log_type_usecase.dart';
import '../../features/user/domain/usecases/log types/get_all_log_types_usecase.dart';
import '../../features/user/domain/usecases/log types/get_log_type_usecase.dart';
import '../../features/user/domain/usecases/log types/update_current_log_type_usecase.dart';
import '../../features/user/domain/usecases/logs/get_all_logs_usecase.dart';
import '../../features/user/domain/usecases/logs/get_log_usecase.dart';
import '../../features/user/domain/usecases/permissions/create_new_permission_usecase.dart';
import '../../features/user/domain/usecases/permissions/delete_permission_usecase.dart';
import '../../features/user/domain/usecases/permissions/get_all__permissions_usecase.dart';
import '../../features/user/domain/usecases/permissions/get_permission_usecase.dart';
import '../../features/user/domain/usecases/permissions/update_current_permission_usecase.dart';
import '../../features/user/domain/usecases/reports/getAllCheckProcessByFileIdReports_usecase.dart';
import '../../features/user/domain/usecases/reports/getAllCheckProcessByGroupIdReports_usecase.dart';
import '../../features/user/domain/usecases/reports/getAllCheckProcessByIsCheckedOutAtTimeIsFalse_usecase.dart';
import '../../features/user/domain/usecases/reports/getAllCheckProcessByIsCheckedOutAtTimeIsTrued_usecase.dart';
import '../../features/user/domain/usecases/reports/getAllCheckProcessByUserIdReports_usecase.dart';
import '../../features/user/domain/usecases/reports/get_all_check_process_reports_usecase.dart';
import '../../features/user/domain/usecases/roles/create_new_role_usecase.dart';
import '../../features/user/domain/usecases/roles/delete_role_usecase.dart';
import '../../features/user/domain/usecases/roles/get_all_roles_usecase.dart';
import '../../features/user/domain/usecases/roles/get_role_usecase.dart';
import '../../features/user/domain/usecases/roles/update_current_role_usecase.dart';
import '../../features/user/domain/usecases/users/get_user_usecase.dart';
import '../../features/user/presentation/bloc/group_bloc/groups_bloc.dart';
import '../feature/presentation/bloc/theme_bloc.dart';
import '../network/connectivity_service.dart';
import '../network/network_info.dart';

final locator = GetIt.instance;

Future<void> initDiContainer() async {
  locator.registerSingleton(ThemeBloc());
  locator.registerSingleton(LogService());

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  locator.registerSingleton<StorageService>(
    StorageService(preferences: preferences),
  );
  // locator.registerSingleton(HomeBloc());

  ///Blocs
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc(
        loginUseCase: locator(),
        signUpUseCase: locator(),
        logOutUseCase: locator(),
      ));
  locator.registerFactory(() => UserBloc(
        getAllUsersUseCase: locator(),
        getUserUseCase: locator(),
        deleteUserUseCase: locator(),
        createNewUserUseCase: locator(),
        updateCurrentUserUseCase: locator(),
      ));

  locator.registerFactory(() => GroupsBloc(
        deleteGroupUseCase: locator(),
        leaveGroupUseCase: locator(),
        getGroupUseCase: locator(),
        getAllGroupsUseCase: locator(),
        joinGroupUseCase: locator(),
        updateCurrentGroupUseCase: locator(),
        createNewGroupUseCase: locator(),
        downloadFileUseCase: locator(),
      ));

  locator.registerFactory(() => FilesBloc(
        checkInUseCase: locator(),
        checkOutUseCase: locator(),
        getAllFilesUseCase: locator(),
        getFileUseCase: locator(),
        deleteFileUseCase: locator(),
        updateCurrentFileUseCase: locator(),
        createNewFileUseCase: locator(),
      ));

  locator.registerFactory(() => PermissionsBloc(
        createNewPermissionUseCase: locator(),
        deletePermissionUseCase: locator(),
        getAllPermissionsUseCase: locator(),
        getPermissionUseCase: locator(),
        updateCurrentPermissionUseCase: locator(),
      ));

  locator.registerFactory(() => RolesBloc(
        createNewRoleUseCase: locator(),
        deleteRoleUseCase: locator(),
        getAllRolesUseCase: locator(),
        getRoleUseCase: locator(),
        updateCurrentRoleUseCase: locator(),
      ));

  locator.registerFactory(() => LogsBloc(getAllLogsUseCase: locator(), getLogUseCase: locator()));

  locator.registerFactory(() => LogTypesBloc(
        getAllLogTypesUseCase: locator(),
        getLogTypeUseCase: locator(),
        createNewLogTypeUseCase: locator(),
        deleteLogTypeUseCase: locator(),
        updateCurrentLogTypeUseCase: locator(),
      ));

  locator.registerFactory(() => ReportsBloc(
        getAllCheckProcessReportsUseCase: locator(),
        getAllCheckProcessByFileIdReportsUseCase: locator(),
        getAllCheckProcessByGroupIdReportsUseCase: locator(),
        getAllCheckProcessByIsCheckedOutAtTimeIsFalseUseCase: locator(),
        getAllCheckProcessByIsCheckedOutAtTimeIsTruedUseCase: locator(),
        getAllCheckProcessByUserIdReportsUseCase: locator(),
      ));

  ///UseCases
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => LogOutUseCase(locator()));
  locator.registerLazySingleton(() => SignUpUseCase(locator()));
  locator.registerLazySingleton(() => GetMyAccountUseCase(locator()));

  locator.registerLazySingleton(() => GetAllUsersUseCase(locator()));
  locator.registerLazySingleton(() => GetUserUseCase(locator()));
  locator.registerLazySingleton(() => CreateNewUserUseCase(locator()));
  locator.registerLazySingleton(() => UpdateCurrentUserUseCase(locator()));
  locator.registerLazySingleton(() => DeleteUserUseCase(locator()));

  locator.registerLazySingleton(() => GetAllGroupsUseCase(locator()));
  locator.registerLazySingleton(() => GetGroupUseCase(locator()));
  locator.registerLazySingleton(() => CreateNewGroupUseCase(locator()));
  locator.registerLazySingleton(() => UpdateCurrentGroupUseCase(locator()));
  locator.registerLazySingleton(() => JoinGroupUseCase(locator()));
  locator.registerLazySingleton(() => LeaveGroupUseCase(locator()));
  locator.registerLazySingleton(() => DeleteGroupUseCase(locator()));
  locator.registerLazySingleton(() => DownloadFileUseCase(locator()));

  locator.registerLazySingleton(() => CheckInUseCase(locator()));
  locator.registerLazySingleton(() => CheckOutUseCase(locator()));
  locator.registerLazySingleton(() => GetAllFilesUseCase(locator()));
  locator.registerLazySingleton(() => GetFileUseCase(locator()));
  locator.registerLazySingleton(() => DeleteFileUseCase(locator()));
  locator.registerLazySingleton(() => CreateNewFileUseCase(locator()));
  locator.registerLazySingleton(() => UpdateCurrentFileUseCase(locator()));

  locator.registerLazySingleton(() => GetAllPermissionsUseCase(locator()));
  locator.registerLazySingleton(() => GetPermissionUseCase(locator()));
  locator.registerLazySingleton(() => DeletePermissionUseCase(locator()));
  locator.registerLazySingleton(() => CreateNewPermissionUseCase(locator()));
  locator.registerLazySingleton(() => UpdateCurrentPermissionUseCase(locator()));

  locator.registerLazySingleton(() => GetAllRolesUseCase(locator()));
  locator.registerLazySingleton(() => GetRoleUseCase(locator()));
  locator.registerLazySingleton(() => DeleteRoleUseCase(locator()));
  locator.registerLazySingleton(() => CreateNewRoleUseCase(locator()));
  locator.registerLazySingleton(() => UpdateCurrentRoleUseCase(locator()));

  locator.registerLazySingleton(() => GetAllLogsUseCase(locator()));
  locator.registerLazySingleton(() => GetLogUseCase(locator()));

  locator.registerLazySingleton(() => GetAllLogTypesUseCase(locator()));
  locator.registerLazySingleton(() => GetLogTypeUseCase(locator()));
  locator.registerLazySingleton(() => DeleteLogTypeUseCase(locator()));
  locator.registerLazySingleton(() => CreateNewLogTypeUseCase(locator()));
  locator.registerLazySingleton(() => UpdateCurrentLogTypeUseCase(locator()));


  locator.registerLazySingleton(() => GetAllCheckProcessReportsUseCase(locator()));
  locator.registerLazySingleton(() => GetAllCheckProcessByFileIdReportsUseCase(locator()));
  locator.registerLazySingleton(() => GetAllCheckProcessByGroupIdReportsUseCase(locator()));
  locator.registerLazySingleton(() => GetAllCheckProcessByIsCheckedOutAtTimeIsFalseUseCase(locator()));
  locator.registerLazySingleton(() => GetAllCheckProcessByIsCheckedOutAtTimeIsTruedUseCase(locator()));
  locator.registerLazySingleton(() => GetAllCheckProcessByUserIdReportsUseCase(locator()));


  ///Repositories
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(localDataSources: locator(), authRemoteDataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton<GroupRepository>(() => GroupRepositoriesImpl(groupRemoteDataSources: locator(), networkInfo: locator()));
  locator.registerLazySingleton<UserRepository>(() => UserRepositoriesImpl(userRemoteDataSources: locator(), networkInfo: locator()));
  locator.registerLazySingleton<FilesRepository>(() => FilesRepositoriesImpl(fileRemoteDataSources: locator(), networkInfo: locator()));
  locator.registerLazySingleton<LogTypesRepository>(() => LogTypesRepositoriesImpl(logTypesRemoteDataSources: locator(), networkInfo: locator()));
  locator.registerLazySingleton<LogsRepository>(() => LogsRepositoriesImpl(logsRemoteDataSources: locator(), networkInfo: locator()));
  locator.registerLazySingleton<PermissionsRepository>(() => PermissionsRepositoriesImpl(permissionsRemoteDataSources: locator(), networkInfo: locator()));
  locator.registerLazySingleton<RolesRepository>(() => RolesRepositoriesImpl(rolesRemoteDataSources: locator(), networkInfo: locator()));
  locator.registerLazySingleton<ReportsRepository>(() => ReportsRepositoriesImpl(reportsRemoteDataSource: locator(), networkInfo: locator()));

  ///DataSources
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(authLocalDataSources: locator()));
  locator.registerLazySingleton<AuthLocalDataSources>(() => AuthLocalDataSourcesImpl(sharedPreferences: locator()));
  locator.registerLazySingleton<GroupRemoteDataSources>(() => GroupRemoteDataSourcesImpl(authLocalDataSources: locator()));
  locator.registerLazySingleton<UserRemoteDataSources>(() => UserRemoteDataSourcesImpl(authLocalDataSources: locator()));
  locator.registerLazySingleton<FileRemoteDataSources>(() => FileRemoteDataSourcesImpl(authLocalDataSources: locator()));
  locator.registerLazySingleton<LogTypesRemoteDataSources>(() => LogTypesRemoteDataSourceImpl(authLocalDataSources: locator()));
  locator.registerLazySingleton<LogsRemoteDataSources>(() => LogsRemoteDataSourcesImpl(authLocalDataSources: locator()));
  locator.registerLazySingleton<PermissionsRemoteDataSources>(() => PermissionsRemoteDataSourceImpl(authLocalDataSources: locator()));
  locator.registerLazySingleton<RolesRemoteDataSources>(() => RolesRemoteDataSourcesImpl(authLocalDataSources: locator()));
  locator.registerLazySingleton<ReportsRemoteDataSource>(() => ReportsRemoteDataSourceImpl(authLocalDataSources: locator()));

  ///Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivityService: locator()));

  ///External
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => Connectivity());
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerLazySingleton(() => http.Client());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
