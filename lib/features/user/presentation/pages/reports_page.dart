import 'package:flutter/material.dart';
import '../../domain/entities/reports_entity.dart';
import '../widgets/group_widgets.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key, required this.listAllReports}) : super(key: key);
  final List<ReportsEntity> listAllReports;

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
          title: const Text(
            "Reports",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: widget.listAllReports.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: widget.listAllReports.length,
                  itemBuilder: (BuildContext context, int index) {
                    String extension = widget.listAllReports[index].fileEntity.name.split('.').last;
                    Icon fileIcon = getFileIcon(extension);
                    return Card(
                      margin: const EdgeInsets.all(5),
                      color: Colors.black38,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            CircleAvatar(
                                              child: Icon(Icons.change_circle),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Checked",
                                              style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Checked in at: ${widget.listAllReports[index].checkedInAt ?? "not yet"}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Checked out at: ${widget.listAllReports[index].checkedOutAt ?? "not yet"}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Checked out at time: ${widget.listAllReports[index].checkedOutAtTime ?? "not yet"}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Created at: ${widget.listAllReports[index].createdAt ?? "not created"}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Updated at: ${widget.listAllReports[index].updatedAt ?? "not updated"}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              child: Icon(Icons.person),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              widget.listAllReports[index].userEntity.userName,
                                              style: const TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Email: ${widget.listAllReports[index].userEntity.email}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Role: ${widget.listAllReports[index].userEntity.role}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Created at: ${widget.listAllReports[index].userEntity.createAt}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Updated at: ${widget.listAllReports[index].userEntity.updateAt ?? "not updated"}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              child: fileIcon,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              widget.listAllReports[index].fileEntity.name.length > 20
                                                  ? widget.listAllReports[index].fileEntity.name.substring(0, 20) + '....'
                                                  : widget.listAllReports[index].fileEntity.name,
                                              overflow: TextOverflow.fade,
                                              maxLines: 2, // Ensure that only one line is displayed
                                              style: const TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Group: ${widget.listAllReports[index].fileEntity.group}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Is check in: ${widget.listAllReports[index].fileEntity.isCheckedIn}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Created at: ${widget.listAllReports[index].fileEntity.createAt}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Updated at: ${widget.listAllReports[index].fileEntity.updateAt ?? "Not updated"}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Center(
                child: Text("There aren't any reports"),
              ));
  }
}
