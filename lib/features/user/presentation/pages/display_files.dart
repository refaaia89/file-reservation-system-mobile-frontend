// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:internet_application/features/user/presentation/bloc/files_bloc/files_bloc.dart';
//
// class DisplayFiles extends StatelessWidget {
//   const DisplayFiles({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true);
//
//                 if (result != null) {
//                   File file = File(result.files.single.path!);
//                   BlocProvider.of<FilesBloc>(context).add(CreateNewFileEvent(file: result.files.single, groupId: "1"));
//                 } else {}
//               },
//               icon: Icon(Icons.add))
//         ],
//       ),
//       body: BlocBuilder<FilesBloc, FilesState>(
//         builder: (context, state) {
//           if (state is LoadingGetAllFilesState) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is SuccessGetAllFilesState) {
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//               itemCount: state.listAllFiles.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   child: Column(
//                     children: [
//                       Text(state.listAllFiles[index].name),
//                       Text(state.listAllFiles[index].owner),
//                       Text(state.listAllFiles[index].checkedInUntilTime.toString()),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
