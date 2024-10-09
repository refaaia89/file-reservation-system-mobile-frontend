import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/core/extensions/media_query.dart';
import 'package:internet_application/core/services/service_locator.dart' as di;
import 'package:internet_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/files_bloc/files_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/reports_bloc/reports_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:internet_application/features/user/presentation/pages/add_member.dart';
import 'package:internet_application/features/user/presentation/pages/home_page.dart';
import 'package:internet_application/features/user/presentation/pages/settings_group.dart';

import '../../../auth/data/datasource/local_datasource/auth_local_datasource.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/entities/group_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/group_bloc/groups_bloc.dart';
import '../widgets/group_widgets.dart';
import 'files_checkIn.dart';

class ShowGroupPage extends StatefulWidget {
  const ShowGroupPage({Key? key, required this.groupEntity}) : super(key: key);
  final GroupEntity groupEntity;

  @override
  State<ShowGroupPage> createState() => _ShowGroupPageState();
}

class _ShowGroupPageState extends State<ShowGroupPage> {
  final userEntity = di.locator<AuthLocalDataSources>().getCachedUser();
  String dropdownValue = "Public";
  List<bool> fileCheckList = [];
  bool isMeInGroup = false;
  List<FileEntity> listFiles = [];
  String downloadedFileId = '';

  @override
  void initState() {
    fileCheckList = List.generate(widget.groupEntity.files.length, (index) => false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.groupEntity.members.map((e) {
      if (e.id == userEntity!.id) {
        isMeInGroup = true;
      }
    }).toList();

    return Scaffold(
      appBar: _buildAppBar(context: context),
      body: widget.groupEntity.isPublic
          ? _buildBody(context: context)
          : isMeInGroup
              ? _buildBody(context: context)
              : BlocBuilder<GroupsBloc, GroupsState>(
                  builder: (context, state) {
                    if (state is LoadingJoinGroupState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(
                      child: TextButton(
                          onPressed: () {
                            BlocProvider.of<GroupsBloc>(context)
                                .add(JoinGroupEvent(groupId: widget.groupEntity.groupId, listUserId: [userEntity!.id], context: context));
                          },
                          child: const Text("Join to group")),
                    );
                  },
                ),
    );
  }

  List<FileEntity> _getSelectedFile() {
    List<FileEntity> tempList = [];
    for (int i = fileCheckList.length - 1; i >= 0; i--) {
      if (fileCheckList[i]) {
        tempList.add(widget.groupEntity.files[i]);
      }
    }
    return tempList;
  }

  AppBar _buildAppBar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.purple.withOpacity(0.1),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Tooltip(
        message: "Admin: ${widget.groupEntity.admin!.userName}",
        child: Text(
          widget.groupEntity.name,
        ),
      ),
      actions: [
        if (BlocProvider.of<GroupsBloc>(context).filesSelect.isNotEmpty)
          IconButton(
            onPressed: () {
              BlocProvider.of<FilesBloc>(context)
                  .add(CheckInEvent(listFiles: _getSelectedFile(), context: context, groupId: widget.groupEntity.groupId, userEntity: userEntity!));
            },
            icon: const Icon(
              Icons.fact_check_outlined,
              color: Colors.green,
            ),
            tooltip: "Check In",
          ),
        IconButton(
          onPressed: () {
            BlocProvider.of<GroupsBloc>(context).add(GetGroupEvent(groupId: widget.groupEntity.groupId));
          },
          icon: const Icon(
            Icons.refresh,
            color: Colors.greenAccent,
          ),
          tooltip: "Refresh",
        ),
        if (BlocProvider.of<GroupsBloc>(context).filesSelect.isNotEmpty)
          IconButton(
            onPressed: () {
              BlocProvider.of<FilesBloc>(context).add(CheckOutEvent(
                  listFileId: _getSelectedFile().map<String>((e) => e.fileId).toList(), context: context, groupId: widget.groupEntity.groupId, inside: false));
            },
            icon: const Icon(
              Icons.fact_check_outlined,
              color: Colors.red,
            ),
            tooltip: "Chick out",
          ),

        ///ADD FILE
        if ((isMeInGroup && !widget.groupEntity.isPublic) || widget.groupEntity.isPublic)
          BlocConsumer<FilesBloc, FilesState>(
            listener: (context, state) {
              if (state is ErrorCreateNewFileState) {
                showError(context, state.message);
              }
              if (state is SuccessCreateNewFileState) {
                fileCheckList.add(false);
                BlocProvider.of<GroupsBloc>(context).add(GetGroupEvent(groupId: widget.groupEntity.groupId));
              }
            },
            builder: (context, state) {
              if (state is LoadingCreateNewFileState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return IconButton(
                onPressed: () => addFile(context: context),
                icon: const Icon(
                  Icons.file_open,
                  color: Colors.grey,
                ),
                tooltip: "add file",
              );
            },
          ),

        ///MORE ABOUT GROUP
        if ((isMeInGroup && !widget.groupEntity.isPublic) || widget.groupEntity.isPublic)
          IconButton(
            onPressed: () => _moreAboutGroup(context: context),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
            tooltip: "more",
          ),

        ///SELECT ALL
        if (BlocProvider.of<GroupsBloc>(context).filesSelect.isNotEmpty)
          IconButton(
            tooltip: "Select All",
            onPressed: () {
              setState(() {
                if (fileCheckList.contains(false)) {
                  fileCheckList.fillRange(0, fileCheckList.length, true);
                  BlocProvider.of<GroupsBloc>(context).filesSelect.clear();
                  BlocProvider.of<GroupsBloc>(context).filesSelect.addAll(widget.groupEntity.files);
                } else {
                  fileCheckList.fillRange(0, fileCheckList.length, false);
                  BlocProvider.of<GroupsBloc>(context).filesSelect.clear();
                }
              });
            },
            icon: fileCheckList.every((bool value) => value)
                ? const Icon(
                    Icons.check_box,
                    color: Colors.grey,
                  )
                : const Icon(Icons.check_box_outline_blank, color: Colors.grey),
          )
      ],
    );
  }

  Widget _buildBody({required BuildContext context}) {
    return SizedBox(
      height: context.height,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.groupEntity.files.length,
        itemBuilder: (context, index) {
          String extension = widget.groupEntity.files[index].name.split('.').last;
          Icon fileIcon = getFileIcon(extension);
          bool isCurrentUserCheckedFile = widget.groupEntity.files[index].isCheckedIn && widget.groupEntity.files[index].updatedBy == int.parse(userEntity!.id);
          return Tooltip(
            message:
                "ID: ${widget.groupEntity.files[index].fileId} \nCreated at:  ${widget.groupEntity.files[index].createAt.toString()} \nUpdated at:  ${widget.groupEntity.files[index].updateAt != null ? widget.groupEntity.files[index].updateAt.toString() : "not update"}",
            child: Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListTile(
                  tileColor: fileCheckList[index] ? Colors.black12 : null,
                  title: Text(
                    widget.groupEntity.files[index].owner,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.groupEntity.files[index].name.split("\\").last),
                          Text(extension),
                        ],
                      ),
                      if (widget.groupEntity.files[index].isCheckedIn) const Text("checked in", style: TextStyle(color: Colors.red))
                    ],
                  ),
                  leading: CircleAvatar(
                    child: fileIcon,
                  ),
                  trailing: BlocBuilder<GroupsBloc, GroupsState>(
                    builder: (context, state) {
                      if (state is LoadingDownloadFileState && downloadedFileId == widget.groupEntity.files[index].fileId) {
                        return const Align(
                          alignment: Alignment.bottomRight,
                          child: CircularProgressIndicator(),
                        );
                      }
                      return !fileCheckList.contains(true)
                          ? BlocBuilder<FilesBloc, FilesState>(
                              builder: (context, state) {
                                return BlocConsumer<FilesBloc, FilesState>(
                                  listener: (context, state) {
                                    if (state is ErrorDeleteFileState) {
                                      showError(context, state.message);
                                    }
                                    if (state is SuccessDeleteFileState) {
                                      BlocProvider.of<GroupsBloc>(context).add(GetGroupEvent(groupId: widget.groupEntity.groupId));
                                    }
                                  },
                                  builder: (context, state) {
                                    return PopupMenuButton(
                                      itemBuilder: (ctx) => [
                                        buildPopupMenuItem(
                                            title: 'Select',
                                            function: () {
                                              setState(() {
                                                BlocProvider.of<GroupsBloc>(context).filesSelect.add(widget.groupEntity.files[index]);
                                                fileCheckList[index] = true;
                                              });
                                            }),
                                        buildPopupMenuItem(
                                            title: isCurrentUserCheckedFile ? "Open" : 'Check in',
                                            function: () {
                                              listFiles.addAll([widget.groupEntity.files[index]]);
                                              if (isCurrentUserCheckedFile) {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => FilesCheckIn(
                                                          listFiles: listFiles,
                                                          // listFilesId: [widget.groupEntity.files[index].fileId],
                                                          groupId: widget.groupEntity.groupId,
                                                          userEntity: userEntity!,
                                                        )));
                                              } else {
                                                BlocProvider.of<FilesBloc>(context).add(CheckInEvent(
                                                  listFiles: [widget.groupEntity.files[index]],
                                                  context: context,
                                                  groupId: widget.groupEntity.groupId,
                                                  userEntity: userEntity!,
                                                  // index: index
                                                ));
                                              }
                                            }),
                                        if (isCurrentUserCheckedFile)
                                          buildPopupMenuItem(
                                              title: 'Check out',
                                              function: () {
                                                BlocProvider.of<FilesBloc>(context).add(CheckOutEvent(
                                                    listFileId: [widget.groupEntity.files[index].fileId],
                                                    context: context,
                                                    inside: false,
                                                    groupId: widget.groupEntity.groupId));
                                              }),
                                        buildPopupMenuItem(
                                            title: 'Download',
                                            function: () {
                                              downloadedFileId = widget.groupEntity.files[index].fileId;
                                              BlocProvider.of<GroupsBloc>(context)
                                                  .add(DownloadFileEvent(groupId: widget.groupEntity.groupId, nameFile: widget.groupEntity.files[index].name));
                                            }),
                                        if (widget.groupEntity.files[index].owner == userEntity!.userName || userEntity!.id == widget.groupEntity.admin!.id)
                                          buildPopupMenuItem(
                                              title: 'Delete',
                                              function: () {
                                                BlocProvider.of<FilesBloc>(context).add(DeleteFileEvent(
                                                    fileId: widget.groupEntity.files[index].fileId, context: context, groupId: widget.groupEntity.groupId));
                                              }),
                                        if (userEntity!.id == "2")
                                          buildPopupMenuItem(
                                              title: 'Reports',
                                              function: () {
                                                BlocProvider.of<ReportsBloc>(context).add(
                                                    GetAllCheckProcessByFileIdReportsEvent(context: context, fileId: widget.groupEntity.files[index].fileId));
                                              }),
                                      ],
                                    );
                                  },
                                );
                              },
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  fileCheckList[index] = !fileCheckList[index];
                                  if (fileCheckList[index]) {
                                    BlocProvider.of<GroupsBloc>(context).filesSelect.add(widget.groupEntity.files[index]);
                                  } else {
                                    BlocProvider.of<GroupsBloc>(context).filesSelect.remove(widget.groupEntity.files[index]);
                                  }
                                });
                              },
                              icon: fileCheckList[index]
                                  ? const Icon(Icons.check_box, color: Colors.grey)
                                  : const Icon(Icons.check_box_outline_blank, color: Colors.grey),
                            );
                    },
                  )),
            ),
          );
        },
      ),
    );
  }

  void addFile({required BuildContext context}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      BlocProvider.of<FilesBloc>(context).add(CreateNewFileEvent(
          file: FileEntity(
            name: file.path.split("\\").last,
            file: file,
            owner: userEntity!.userName,
            ownerId: userEntity!.id,
            isCheckedIn: false,
            fileId: "",
            checkedInUntilTime: DateTime.now(),
            createAt: DateTime.now(),
            updateAt: DateTime.now(),
            group: '',
            updatedBy: int.parse(userEntity!.id),
          ),
          groupId: widget.groupEntity.groupId));
    }
  }

  void showAlertDialog(String title, String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void settings({required GroupEntity group, required BuildContext context}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) => di.locator<AuthBloc>(),
              child: SettingsGroupPage(groupEntity: group),
            )));
  }

  void _deleteGroup({required String groupId, required BuildContext context}) {
    BlocProvider.of<GroupsBloc>(context).add(DeleteGroupEvent(groupId: groupId));
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  void _addMembers({required BuildContext context, required String groupId, required List<UserEntity> members}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddMembers(
                  groupId: groupId,
                  memberOfGroup: members,
                  adminId: widget.groupEntity.admin!.id,
                )));
  }

  void _moreAboutGroup({required BuildContext context}) {
    BlocProvider.of<UserBloc>(context).add(const GetAllUsersEvent(page: 1, pageSize: 100));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Group info"),
            content: SizedBox(
              width: context.width / 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Admin: ${widget.groupEntity.admin!.userName}",
                        ),
                        const Icon(
                          Icons.admin_panel_settings,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  if (widget.groupEntity.admin!.id == userEntity!.id || userEntity!.id == "2")
                    Column(
                      children: [
                        if (userEntity!.id == "2")
                          InkWell(
                            onTap: () {
                              BlocProvider.of<ReportsBloc>(context)
                                  .add(GetAllCheckProcessByGroupIdReportsEvent(groupId: widget.groupEntity.groupId, context: context));
                            },
                            child: const SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Reports",
                                  ),
                                  Icon(
                                    Icons.file_present_rounded,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                        InkWell(
                          onTap: () => settings(group: widget.groupEntity, context: context),
                          child: const SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Settings group",
                                ),
                                Icon(
                                  Icons.settings,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _addMembers(context: context, groupId: widget.groupEntity.groupId, members: widget.groupEntity.members),
                          child: const SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add members",
                                ),
                                Icon(
                                  Icons.person_add_alt_rounded,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _deleteGroup(groupId: widget.groupEntity.groupId, context: context),
                          child: const SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delete group",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  else if (isMeInGroup)
                    BlocConsumer<GroupsBloc, GroupsState>(
                      listener: (context, state) {
                        if (state is ErrorLeaveGroupState) {
                          showError(context, state.message);
                        }
                        if (state is SuccessLeaveGroupState) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadingLeaveGroupState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return InkWell(
                          onTap: () => leaveGroup(groupId: widget.groupEntity.groupId, context: context, listUserId: [userEntity!.id]),
                          child: const SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Leave group",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Icon(
                                  Icons.exit_to_app,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Text(
                          "Members",
                          style: TextStyle(color: Colors.purple.withOpacity(0.9)),
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.purple.withOpacity(0.9),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: widget.groupEntity.members.isEmpty
                        ? const Center(
                            child: Text("There aren't any members."),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.groupEntity.members.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ReportsBloc>(context)
                                        .add(GetAllCheckProcessByUserIdReportsEvent(userId: widget.groupEntity.members[index].id, context: context));
                                  },
                                  icon: const Icon(Icons.file_present_rounded),
                                ),
                                onTap: widget.groupEntity.admin!.id == userEntity!.id || userEntity!.id == "2"
                                    ? () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Center(
                                            child: SizedBox(
                                              width: 500,
                                              height: 140,
                                              child: AlertDialog(
                                                content: Column(
                                                  children: [
                                                    const Text("Do you want to delete this user?"),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text(
                                                              "cancel",
                                                              style: TextStyle(color: Colors.black),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              BlocProvider.of<GroupsBloc>(context).add(LeaveGroupEvent(
                                                                  groupId: widget.groupEntity.groupId, listUserId: [widget.groupEntity.members[index].id]));
                                                            },
                                                            child: const Text(
                                                              "delete",
                                                              style: TextStyle(color: Colors.red),
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                    : () {},
                                title: Text(widget.groupEntity.members[index].userName),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                  child: Text(
                                    widget.groupEntity.members[index].userName[0].toUpperCase() + widget.groupEntity.members[index].userName[1].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
