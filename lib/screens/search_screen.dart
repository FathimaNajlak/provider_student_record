import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_record_provider/database/functions/db_functions.dart';
import 'package:student_record_provider/database/model/data_model.dart';
import 'package:student_record_provider/provider/datacontroller_provider.dart';
import 'package:student_record_provider/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentdataProvider>(context, listen: false).getsearchdata('');
    return Consumer<StudentdataProvider>(
      builder: (context, studentdata, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    onChanged: (value) => studentdata.getsearchdata(value),
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: studentdata.filterStudent.isEmpty
                      ? const Center(
                          child: Text(
                            'No results found',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: studentdata.filterStudent.length,
                          itemBuilder: (context, index) {
                            final finduserItem =
                                studentdata.filterStudent[index];
                            return Card(
                              color: const Color.fromARGB(255, 160, 207, 246),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(File(finduserItem.imagex)),
                                ),
                                title: Text(finduserItem.name),
                                subtitle:
                                    Text('CLASS : ${finduserItem.classname}'),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deletestudent(context, finduserItem);
                                  },
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (ctr) =>
                                        StudentDetails(stdetails: finduserItem),
                                  ));
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deletestudent(ctx, StudentModel student) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do You Want to delete the list?'),
          actions: [
            TextButton(
              onPressed: () {
                detectedYes(context, student);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void detectedYes(ctx, StudentModel student) async {
    deleteStudent(student.id!, ctx);
    Provider.of<StudentdataProvider>(ctx, listen: false).getsearchdata('');
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.of(ctx).pop();
  }
}
