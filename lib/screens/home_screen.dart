import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record_provider/const/color.dart';

import 'package:student_record_provider/provider/datacontroller_provider.dart';
import 'package:student_record_provider/screens/add_student.dart';
import 'package:student_record_provider/screens/list_students.dart';

import 'package:student_record_provider/screens/search_screen.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({super.key});

  @override
  // Widget build(BuildContext context) {
  //   getstudentdata();
  Widget build(BuildContext context) {
    // Initialize data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentdataProvider>(context, listen: false).intialize();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Students Record',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctxs) => const SearchScreen()));
              },
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.black,
              ))
        ],
      ),
      // body: const Column(
      //   children: [
      //     Expanded(child: StudentList()),
      //   ],
      // ),
      body: Consumer<StudentdataProvider>(
        builder: (context, studentProvider, child) {
          if (studentProvider.studentList.isEmpty) {
            return const Center(
              child: Text(
                'No students added',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            return const Column(
              children: [
                Expanded(child: StudentList()),
              ],
            );
          }
        },
      ),
      floatingActionButton: Visibility(
        visible: true, // Show the add button
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          onPressed: () {
            addstudent(context);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  void addstudent(ctx) {
    Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (ctx) => const AddStudent()));
  }
}
