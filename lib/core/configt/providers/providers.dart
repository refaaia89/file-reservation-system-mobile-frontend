import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/core/services/service_locator.dart' as di;
import 'package:internet_application/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../features/user/presentation/bloc/group_bloc/groups_bloc.dart';

List<BlocProvider> myProviders() {
  return [
    BlocProvider<GroupsBloc>(create: (context) => di.locator<GroupsBloc>()),
    BlocProvider<AuthBloc>(create: (context) => di.locator<AuthBloc>()),
  ];
}
