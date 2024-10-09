import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/core/configt/theme/theme.dart';
import 'package:internet_application/core/helper/utilities.dart';
import 'package:internet_application/core/services/service_locator.dart' as di;
import 'package:internet_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:internet_application/features/auth/presentation/pages/login_page.dart';
import 'package:internet_application/features/user/presentation/bloc/files_bloc/files_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/log_types_bloc/log_types_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/logs_bloc/logs_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/permissions_bloc/permissions_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/reports_bloc/reports_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/roles_bloc/roles_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:internet_application/features/user/presentation/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';

import 'core/network/base_api_client.dart';
import 'features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'features/user/presentation/bloc/group_bloc/groups_bloc.dart';

_bootstrapApplication() async {
  BaseApiClient();
  WidgetsFlutterBinding.ensureInitialized();
  Utilities.setWindowSize();
  await di.initDiContainer();
  final dir = await getApplicationDocumentsDirectory();
  // print(dir.path);
}

void main() async {
  await _bootstrapApplication();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupsBloc>(create: (context) => di.locator<GroupsBloc>()),
        BlocProvider<FilesBloc>(create: (context) => di.locator<FilesBloc>()),
        BlocProvider<LogTypesBloc>(create: (context) => di.locator<LogTypesBloc>()),
        BlocProvider<LogsBloc>(create: (context) => di.locator<LogsBloc>()),
        BlocProvider<UserBloc>(create: (context) => di.locator<UserBloc>()),
        BlocProvider<PermissionsBloc>(create: (context) => di.locator<PermissionsBloc>()),
        BlocProvider<RolesBloc>(create: (context) => di.locator<RolesBloc>()),
        BlocProvider<ReportsBloc>(create: (context) => di.locator<ReportsBloc>()),
        BlocProvider<AuthBloc>(create: (context) => di.locator<AuthBloc>(), lazy: false),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.system,
        home: _widget(),
      ),
    );
  }

  Widget _widget() {
    // di.locator<AuthLocalDataSources>().deleteCachedToken();
    // di.locator<AuthLocalDataSources>().deleteCachedUser();
    final token = di.locator<AuthLocalDataSources>().getCachedToken();
    if (token == null) {
      return LoginPage();
    } else {
      return const HomePage();
    }
  }
}
