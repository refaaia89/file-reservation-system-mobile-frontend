import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/core/extensions/media_query.dart';
import 'package:internet_application/core/services/service_locator.dart' as di;
import 'package:internet_application/features/user/presentation/bloc/reports_bloc/reports_bloc.dart';
import 'package:internet_application/features/user/presentation/pages/show_group.dart';

import '../../../auth/data/datasource/local_datasource/auth_local_datasource.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../domain/entities/group_entity.dart';
import '../bloc/group_bloc/groups_bloc.dart';
import '../widgets/group_widgets.dart';
import 'create_group_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userEntity = di.locator<AuthLocalDataSources>().getCachedUser();
  List<GroupEntity> listSearch = [];
  @override
  void initState() {
    BlocProvider.of<GroupsBloc>(context).listGroups = [];
    BlocProvider.of<GroupsBloc>(context).add(GetAllGroupsEvent(page: 1, pageSize: 10));
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  Widget? _widget;

  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _loadingMore = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_loadingMore) {
      _loadingMore = true;
      _currentPage++;
      BlocProvider.of<GroupsBloc>(context).add(GetAllGroupsEvent(page: _currentPage, pageSize: _pageSize));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.black45,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<GroupsBloc>(context).add(GetAllGroupsEvent(page: _currentPage, pageSize: _pageSize));
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.greenAccent,
            ),
            tooltip: "Refresh",
          ),
          if (userEntity!.id == "2")
            PopupMenuButton(
              icon: const Icon(Icons.file_present_rounded, color: Colors.white),
              itemBuilder: (ctx) => [
                buildPopupMenuItem(
                    title: 'All reports',
                    function: () {
                      BlocProvider.of<ReportsBloc>(context).add(GetAllCheckProcessReportsEvent(context: context));
                    }),
                buildPopupMenuItem(
                    title: 'CheckOut False',
                    function: () {
                      BlocProvider.of<ReportsBloc>(context).add(GetAllCheckProcessByIsCheckedOutAtTimeIsFalseEvent(context: context));
                    }),
                buildPopupMenuItem(
                    title: 'CheckOut True',
                    function: () {
                      BlocProvider.of<ReportsBloc>(context).add(GetAllCheckProcessByIsCheckedOutAtTimeIsTruedEvent(context: context));
                    }),
              ],
            ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is LoadingLogOutState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ErrorLogOutState) {
                Future.delayed(const Duration(seconds: 1), () {
                  showError(context, state.message);
                });
              }
              if (state is SuccessLogOutState) {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                });
              }
              return IconButton(
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                tooltip: "Log Out",
              );
            },
          ),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: context.width / 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              listSearch = BlocProvider.of<GroupsBloc>(context)
                                  .listGroups
                                  .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.purple.withOpacity(0.1),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CreateNewGroupPage(),
                            ));
                          },
                          icon: const Icon(Icons.add),
                          tooltip: "Create group",
                        ),
                      )
                    ],
                  ),
                  BlocConsumer<GroupsBloc, GroupsState>(
                    listener: (context, state) {
                      if (state is ErrorGetAllGroupsState) {
                        showError(context, state.message);
                      }
                      if (state is SuccessGetAllGroupsState) {
                        final List<GroupEntity> newGroups = state.listAllGroups;
                        final List<GroupEntity> existingGroups = BlocProvider.of<GroupsBloc>(context).listGroups;

                        // Add only those groups which are not already in the list
                        for (final GroupEntity newGroup in newGroups) {
                          if (!existingGroups.any((GroupEntity existingGroup) => existingGroup.groupId == newGroup.groupId)) {
                            existingGroups.add(newGroup);
                          }
                        }

                        BlocProvider.of<GroupsBloc>(context).listGroups = existingGroups;
                        setState(() {
                          listSearch = BlocProvider.of<GroupsBloc>(context).listGroups;
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingGetAllGroupsState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              Column(
                                children: List.generate(listSearch.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      // setState(() {
                                      BlocProvider.of<GroupsBloc>(context).add(GetGroupEvent(groupId: listSearch[index].groupId));
                                      // });
                                    },
                                    child: ListTile(
                                      title: Text(listSearch[index].name),
                                      subtitle: Text(listSearch[index].isPublic ? "Public" : "Private"),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        // You can customize the background color
                                        radius: 30.0,
                                        child: Text(
                                          listSearch[index].name.isNotEmpty
                                              ? listSearch[index].name[0].toUpperCase() + listSearch[index].name[1].toUpperCase()
                                              : '?',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const VerticalDivider(),
            SizedBox(
                width: context.width * 0.6,
                child: BlocConsumer<GroupsBloc, GroupsState>(builder: (context, state) {
                  if (_widget == null) {
                    return const Center(
                      child: Text("please select any group!"),
                    );
                  } else {
                    return _widget!;
                  }
                }, listener: (context, state) {
                  if (state is ErrorGetGroupState) {
                    showError(context, state.message);
                  }
                  if (state is SuccessGetGroupState) {
                    _widget = ShowGroupPage(groupEntity: state.groupEntity);
                  }
                  if (state is LoadingGetGroupState) {
                    _widget = const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }))
          ],
        ),
      ),
    );
  }
}
