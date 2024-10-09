import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/features/user/domain/entities/user_entity.dart';
import 'package:internet_application/features/user/presentation/bloc/files_bloc/files_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/group_bloc/groups_bloc.dart';
import 'package:internet_application/features/user/presentation/pages/code_editor_page.dart';
import 'package:internet_application/features/user/presentation/widgets/group_widgets.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/file_entity.dart';

typedef UpdateCallback = void Function();

class FilesCheckIn extends StatefulWidget {
  const FilesCheckIn({Key? key, required this.listFiles, required this.groupId, required this.userEntity}) : super(key: key);
  final List<FileEntity> listFiles;
  final String groupId;
  final UserEntity userEntity;

  @override
  State<FilesCheckIn> createState() => _FilesCheckInState();
}

class _FilesCheckInState extends State<FilesCheckIn> {
  final BehaviorSubject<bool> currentPopState = BehaviorSubject.seeded(false);

  int fileIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.listFiles.isNotEmpty) {
      return BlocProvider.value(
        value: BlocProvider.of<GroupsBloc>(context)..add(DownloadFileEvent(groupId: widget.groupId, nameFile: widget.listFiles[0].name)),
        child: StreamBuilder<bool>(
            stream: currentPopState.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PopScope(
                  canPop: snapshot.data!,
                  onPopInvoked: (didPop) {
                    Logger().w(didPop);
                    showAlertDialog('Back', 'if you want back you need to check out if you need to keep file check in just click back anyway', context,
                        action: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<FilesBloc>(context).add(CheckOutEvent(context: context, listFileId: [widget.listFiles[fileIndex].fileId]));
                            },
                            child: const Text('check out'),
                          ),
                          TextButton(
                            onPressed: () {
                              currentPopState.sink.add(true);
                              SchedulerBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context).pop();
                                Navigator.of(context).maybePop();
                                BlocProvider.of<GroupsBloc>(context).add(GetGroupEvent(groupId: widget.groupId));
                              });
                            },
                            child: const Text('Back Anyway'),
                          ),
                        ],
                        popScope: true);
                  },
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text("The files that chick in"),
                      centerTitle: true,
                    ),
                    body: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: widget.listFiles.isEmpty
                              ? const Center(
                                  child: Text("There aren't any files that chick in."),
                                )
                              : ListView.builder(
                                  shrinkWrap: false,
                                  itemCount: widget.listFiles.length,
                                  itemBuilder: (context, index) {
                                    fileIndex = index;
                                    String extension = widget.listFiles[index].name.split('.').last;
                                    Icon fileIcon = getFileIcon(extension);

                                    return Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Tooltip(
                                            message:
                                                "Created at:  ${widget.listFiles[index].createAt.toString()} \nUpdated at:  ${widget.listFiles[index].updateAt != null ? widget.listFiles[index].updateAt.toString() : "not update"}",
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 20,
                                                  child: fileIcon,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.listFiles[index].owner,
                                                      style: const TextStyle(color: Colors.blue),
                                                    ),
                                                    Text(
                                                      widget.listFiles[index].name.split("\\").last.substring(0, 5),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      softWrap: true,
                                                    ),
                                                    Text(extension),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            children: [
                                              BlocConsumer<FilesBloc, FilesState>(
                                                listener: (context, state) {
                                                  if (state is ErrorCheckOutState) {
                                                    showError(context, state.message);
                                                  }
                                                  if (state is SuccessCheckOutState) {
                                                    setState(() {
                                                      widget.listFiles.removeAt(index);
                                                    });
                                                  }
                                                },
                                                builder: (context, state) {
                                                  return TextButton(
                                                      onPressed: () {
                                                        BlocProvider.of<FilesBloc>(context)
                                                            .add(CheckOutEvent(context: context, listFileId: [widget.listFiles[index].fileId]));
                                                      },
                                                      child: const Text("Chick out"));
                                                },
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  BlocProvider.of<GroupsBloc>(context)
                                                      .add(DownloadFileEvent(groupId: widget.groupId, nameFile: widget.listFiles[index].name));
                                                },
                                                icon: const Icon(Icons.install_desktop),
                                                tooltip: "Download",
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  FilePickerResult? result = await FilePicker.platform.pickFiles();

                                                  if (result != null) {
                                                    File file = File(result.files.single.path!);
                                                    BlocProvider.of<FilesBloc>(context).add(UpdateCurrentFileEvent(
                                                        context: context,
                                                        fileEntity: FileEntity(
                                                          name: basename(file.path),
                                                          file: file,
                                                          owner: widget.userEntity.userName,
                                                          ownerId: widget.userEntity.id,
                                                          isCheckedIn: widget.listFiles[index].isCheckedIn,
                                                          fileId: widget.listFiles[index].fileId,
                                                          checkedInUntilTime: widget.listFiles[index].checkedInUntilTime,
                                                          createAt: widget.listFiles[index].createAt,
                                                          group: '',
                                                          updateAt: widget.listFiles[index].updateAt,
                                                          updatedBy: widget.listFiles[index].updatedBy,
                                                        ),
                                                        groupId: widget.groupId,
                                                        fileId: widget.listFiles[index].fileId));
                                                  }
                                                },
                                                icon: const Icon(Icons.edit),
                                                tooltip: "Update",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                            flex: 4,
                            child: BlocBuilder<GroupsBloc, GroupsState>(
                              builder: (context, state) {
                                if (state is LoadingDownloadFileState) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return CodeEditorPage(
                                  fileName: widget.listFiles[0].name,
                                  fileEntity: widget.listFiles[0],
                                  groupId: widget.groupId,
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            }),
      );
    }
    return Container();
  }

  Future<void> showAlertDialog(String title, String content, BuildContext context,
      {List<Widget>? action, String cancelTitle = "Close", bool popScope = false}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            if (!popScope)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(cancelTitle),
              ),
            ...action ?? [const SizedBox.shrink()]
          ],
        );
      },
    );
  }
}
