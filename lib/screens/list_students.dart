import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_record_provider/database/functions/db_functions.dart';
import 'package:student_record_provider/database/model/data_model.dart';
import 'package:student_record_provider/provider/datacontroller_provider.dart';
import 'package:student_record_provider/screens/edit_screen.dart';
import 'package:student_record_provider/screens/profile_screen.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentdataProvider>(context, listen: true).intialize();
    return Consumer<StudentdataProvider>(
      builder: (BuildContext context, studentdata, child) => ListView.builder(
        itemCount: studentdata.studentList.length,
        itemBuilder: (context, index) {
          final student = studentdata.studentList[index];
          return Card(
            color: Colors.lightBlue[50],
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(
                  File(student.imagex),
                ),
              ),
              title: Text(student.name),
              subtitle: Text(
                "Class: ${student.classname}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditStudent(student: student),
                      ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      deletestudent(context, student);
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctr) => StudentDetails(stdetails: student),
                ));
              },
            ),
          );
        },
      ),
    );
  }

  void deletestudent(ctx, StudentModel student) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do You Want delete the list ?'),
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

  void detectedYes(ctx, StudentModel student) {
    deleteStudent(student.id!, ctx);
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
