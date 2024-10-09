import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/group_bloc/groups_bloc.dart';

String getFileSize(File file) {
  double bytes = file.lengthSync().toDouble();
  double kb = bytes / 1024;
  if (kb < 1024) {
    return '${kb.toStringAsFixed(2)} KB';
  } else {
    double mb = kb / 1024;
    return '${mb.toStringAsFixed(2)} MB';
  }
}


void leaveGroup({required String groupId, required BuildContext context,required List<String>listUserId}) {
  final groupsBloc = BlocProvider.of<GroupsBloc>(context);
  groupsBloc.add(LeaveGroupEvent(groupId: groupId, listUserId:listUserId ));
  if (groupsBloc.state is ErrorLeaveGroupState) {
    showError(context, (groupsBloc.state as ErrorLeaveGroupState).message);
  }
}



void showError(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: Center(
        child: Text(
      errorMessage,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    )),
    backgroundColor: Colors.red,
    padding: const EdgeInsets.all(10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccess(BuildContext context, String successMessage) {
  final snackBar = SnackBar(
    content: Center(
        child: Text(
      successMessage,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    )),
    backgroundColor: Colors.green,
    padding: const EdgeInsets.all(10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void removeUserFromGroup({required String userId, required String groupId, required BuildContext context}) {
  final groupsBloc = BlocProvider.of<GroupsBloc>(context);
  groupsBloc.add(RemoveUserFromGroupEvent(userId: userId, groupId: groupId));
  if (groupsBloc.state is RemoveUserFromGroupErrorState) {
    showError(context, (groupsBloc.state as RemoveUserFromGroupErrorState).message);
  }
  if (groupsBloc.state is RemoveUserFromGroupSuccessState) {
    showSuccess(context, (groupsBloc.state as RemoveUserFromGroupSuccessState).message);
  }
}



Icon getFileIcon(String extension) {
  switch (extension) {
    case 'txt':
      return const Icon(Icons.text_fields);
    case 'jpg':
    case 'jpeg':
    case 'png':
      return const Icon(Icons.image);
    case 'pdf':
      return const Icon(Icons.picture_as_pdf);
    case 'zip':
      return const Icon(Icons.archive);
    case 'mp4':
      return const Icon(Icons.video_library);
    case 'mp3':
    case 'MP3':
      return const Icon(Icons.music_note);
    default:
      return const Icon(Icons.insert_drive_file);
  }
}

PopupMenuItem buildPopupMenuItem({required String title, required VoidCallback function}) {
  return PopupMenuItem(
    onTap: function,
    child: Text(title),
  );
}