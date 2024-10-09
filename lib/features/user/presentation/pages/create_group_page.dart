import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_application/core/extensions/media_query.dart';
import 'package:internet_application/features/auth/data/datasource/local_datasource/auth_local_datasource.dart';
import 'package:internet_application/features/user/domain/entities/group_entity.dart';
import 'package:internet_application/features/user/presentation/bloc/group_bloc/groups_bloc.dart';
import 'package:internet_application/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:internet_application/features/user/presentation/widgets/group_widgets.dart';
import '../../../../core/feature/presentation/widgets/custom_button.dart';
import '../../domain/entities/user_entity.dart';
import 'package:internet_application/core/services/service_locator.dart' as di;

import 'home_page.dart';

class CreateNewGroupPage extends StatefulWidget {
  const CreateNewGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateNewGroupPage> createState() => _CreateNewGroupPageState();
}

class _CreateNewGroupPageState extends State<CreateNewGroupPage> {
  TextEditingController nameGroupController = TextEditingController();
  TextEditingController descriptionGroupController = TextEditingController();
  String dropdownValue = "Public";
  TextEditingController maxSizeFileController = TextEditingController();
  TextEditingController allowedExtensionFileTypesController = TextEditingController();
  TextEditingController maxNumFileController = TextEditingController();
  TextEditingController maxMemberController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<bool> userCheckList = [];
  final AuthLocalDataSources authLocalDataSources = di.locator<AuthLocalDataSources>();

  @override
  void initState() {
    super.initState();
  }

  List<UserEntity> listUsersEntity = [];
  late UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    final result=authLocalDataSources.getCachedUser();
    userEntity=UserEntity(id: result!.id, email: result.email, userName: result.userName, role: result.role);
    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_sharp),
            ),
            title: const Text(
              "Create new group",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: context.width / 3,
                          child: TextFormField(
                            controller: nameGroupController,
                            decoration: InputDecoration(
                              hintText: "Name of group.",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                              fillColor: Colors.purple.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: context.width / 3,
                          child: TextFormField(
                            controller: descriptionGroupController,
                            decoration: InputDecoration(
                              hintText: "Description.",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                              fillColor: Colors.purple.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Select type of your group: ",
                          ),
                          DropdownButton<String>(
                            focusColor: Colors.transparent,
                            dropdownColor: Colors.transparent,
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>["Public", "Private"].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Allowed extension file types ",
                          ),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              controller: allowedExtensionFileTypesController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Max allowed file size in mb: ",
                          ),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: maxSizeFileController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Max files count: ",
                          ),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: maxNumFileController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Max members count: ",
                          ),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: maxMemberController,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30,),
                      SizedBox(
                          width: context.width / 4,
                          child: BlocConsumer<GroupsBloc, GroupsState>(
                            listener: (_, state) {
                              if (state is SuccessCreateNewGroupState) {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                              }
                              if (state is ErrorCreateNewGroupState) {
                                showError(context, state.message);
                              }
                            },
                            builder: (_, state) {
                              if (state is LoadingCreateNewGroupState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return CustomButton(
                                  formKey: formKey,
                                  onTap: () {
                                    BlocProvider.of<GroupsBloc>(context).add(CreateNewGroupEvent(
                                        groupEntity: GroupEntity(
                                      groupId: "",
                                      name: nameGroupController.text,
                                      description: descriptionGroupController.text,
                                      isPublic: dropdownValue == "Public",
                                      allowedExtensionFileTypes: allowedExtensionFileTypesController.text==""?null:allowedExtensionFileTypesController.text,
                                      members: [],
                                      administratorId: userEntity.id,
                                      maxMemberCount: maxMemberController.text,
                                      administratorName: userEntity.userName,
                                      maxAllowedFileSizeInMb: maxSizeFileController.text,
                                      maxFilesCount: maxNumFileController.text,
                                      createAt: null,
                                      updateAt: null,
                                      admin: null,
                                      files: [],
                                    )));
                                  },
                                  text: "Create");
                            },
                          )),
                    ],
                  ),
                SizedBox(width: 30,),
                
                // Container(
                //   width: context.width/3,
                //   height: context.height/2,
                //   child:Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwYVFtjPmA1IPmoEOL7QVDOWOg9P16aeGLW-yE12m6nT0VVd5PMb21-0n-j1w01g8upFI&usqp=CAU",fit: BoxFit.fill,) ,)
                ],
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}
