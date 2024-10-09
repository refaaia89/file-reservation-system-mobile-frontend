import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/core/extensions/media_query.dart';
import 'package:internet_application/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:internet_application/features/user/presentation/widgets/group_widgets.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/group_bloc/groups_bloc.dart';
import 'home_page.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({Key? key, required this.groupId, required this.memberOfGroup, required this.adminId}) : super(key: key);
  final String groupId;
  final List<UserEntity> memberOfGroup;
  final String adminId;

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(const GetAllUsersEvent(page: 1, pageSize: 100));
    super.initState();
  }

  List<bool> userCheckList = [];
  List<String> listUserId = [];
  List<UserEntity> listUsersEntity = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is ErrorGetAllUsersState) {
          showError(context, state.message);
        }
        if (state is SuccessGetAllUsersState) {
          state.listAllUsers.map((eUser) {
            if (widget.memberOfGroup.isNotEmpty) {
              widget.memberOfGroup.map((eMember) {
                if (eUser.id != eMember.id && eUser.id!=widget.adminId) {
                  listUsersEntity.add(eUser);
                }
              });
            } else {
              listUsersEntity.add(eUser);
            }
          }).toList();

          userCheckList = List.generate(listUsersEntity.length, (index) => false);
        }
      },
      builder: (context, state) {
        if (state is LoadingGetAllUsersState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              "Add members",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: context.width / 4,
                      child: BlocBuilder<GroupsBloc, GroupsState>(
                         builder: (context, state) {
                          if (state is LoadingJoinGroupState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return IconButton(
                            onPressed: () {
                              BlocProvider.of<GroupsBloc>(context).add(JoinGroupEvent(groupId: widget.groupId, listUserId: listUserId, context: context));
                            },
                            icon: const Icon(
                              Icons.add_circle_outlined,
                              size: 70,
                            ),
                          );
                        },
                      )),
                ],
              ),
              SizedBox(
                width: context.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          listUsersEntity.isEmpty
                              ? const Center(
                                  child: Text("There aren't any users"),
                                )
                              : Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(listUsersEntity.length, (index) {
                                        return ListTile(
                                          title: Text(listUsersEntity[index].userName),
                                          subtitle: Text(listUsersEntity[index].email),
                                          leading: CircleAvatar(
                                            backgroundColor: userCheckList[index]
                                                ? Colors.green // Set the color when selected
                                                : Colors.blue,
                                            radius: 30.0,
                                            child: Text(
                                              listUsersEntity[index].userName.isNotEmpty
                                                  ? listUsersEntity[index].userName[0].toUpperCase() + listUsersEntity[index].userName[1].toUpperCase()
                                                  : '?',
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (userCheckList[index]) {
                                                  listUserId.remove(listUsersEntity[index].id);
                                                } else {
                                                  listUserId.add(listUsersEntity[index].id);
                                                }
                                                userCheckList[index] = !userCheckList[index];
                                              });
                                            },
                                            icon: userCheckList[index] ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
