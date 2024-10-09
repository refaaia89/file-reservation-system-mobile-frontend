import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/all.dart' as mode;
import 'package:internet_application/core/helper/utilities.dart';
import 'package:internet_application/core/services/service_locator.dart' as di;
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/domain/entities/file_entity.dart';
import 'package:internet_application/features/user/domain/entities/user_entity.dart';
import 'package:internet_application/features/user/presentation/bloc/files_bloc/files_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

enum FileType { File, Image }

class CodeEditorPage extends StatefulWidget {
  const CodeEditorPage({super.key, required this.fileName, required this.fileEntity, required this.groupId});

  final FileEntity fileEntity;
  final String fileName;
  final String groupId;

  @override
  State<CodeEditorPage> createState() => _CodeEditorPageState();
}

class _CodeEditorPageState extends State<CodeEditorPage> {
  final BehaviorSubject<String> _currentText = BehaviorSubject.seeded("");
  late File file;
  String tempText = "";

  @override
  void initState() {
    super.initState();
    Utilities.getDownloadPath().then((value) {
      file = File('$value/${widget.fileName}');
      if (_getFileType(widget.fileName) == FileType.File) {
        file.readAsString().then((value) {
          Logger().w(value);
          _currentText.sink.add(value);
        });
      }
    });
  }

  FileType _getFileType(String name) {
    String tempName = name.split('.').last;
    Logger().f(name);
    switch (tempName) {
      case 'png':
        return FileType.Image;
      case 'jpg':
        return FileType.Image;
      case 'jpeg':
        return FileType.Image;
      case 'gif':
        return FileType.Image;
      default:
        return FileType.File;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: _currentText.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (_getFileType(widget.fileName) == FileType.File) {
              return SingleChildScrollView(
                  child: Stack(
                children: [
                  CodeTheme(
                      data: CodeThemeData(styles: monokaiSublimeTheme),
                      child: CodeField(
                        controller: CodeController(text: snapshot.data!, language: mode.allLanguages['dart']),
                        onChanged: (p0) {
                          tempText = p0;
                          // _currentText.sink.add(p0);
                        },
                      )),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () async {
                        // FilePickerResult? result = await FilePicker.platform.pickFiles();
                        final result = di.locator<AuthLocalDataSources>().getCachedUser();
                        final userEntity = UserEntity(id: result!.id, email: result.email, userName: result.userName, role: result.role);

                        Utilities.getDownloadPath().then((value) {
                          final time = Utilities.getTime();
                          final file = File("$value\\$time${widget.fileEntity.name}");
                          file.writeAsString(tempText);

                          BlocProvider.of<FilesBloc>(context).add(UpdateCurrentFileEvent(
                              context: context,
                              fileEntity: FileEntity(
                                name: "$time${widget.fileEntity.name}",
                                file: file,
                                owner: userEntity.userName,
                                ownerId: userEntity.id,
                                isCheckedIn: true,
                                fileId: widget.fileEntity.fileId,
                                checkedInUntilTime: widget.fileEntity.checkedInUntilTime,
                                createAt: widget.fileEntity.createAt,
                                group: '',
                                updateAt: widget.fileEntity.updateAt,
                                updatedBy: widget.fileEntity.updatedBy,
                              ),
                              groupId: widget.groupId,
                              fileId: widget.fileEntity.fileId));
                        });
                      },
                      icon: const Icon(Icons.edit),
                      tooltip: "Update",
                    ),
                  )
                ],
              ));
            } else {
              return Center(
                  child: Image.file(
                file,
                alignment: Alignment.center,
              ));
            }
          }
          return Container();
        });
  }
}
