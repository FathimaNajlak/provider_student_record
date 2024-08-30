import 'package:flutter/material.dart';

import 'package:student_record_provider/database/functions/db_functions.dart';
import 'package:student_record_provider/database/model/data_model.dart';

class StudentdataProvider extends ChangeNotifier {
  List<StudentModel> studentList = <StudentModel>[];
  List<StudentModel> filterStudent = <StudentModel>[];
  intialize() async {
    dynamic data = await getstudentdata();
    studentList = data;
    notifyListeners();
  }

  getsearchdata(String query) async {
    await intialize();
    if (query.isEmpty) {
      filterStudent = studentList;
    } else {
      List<StudentModel> s = studentList
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()) ||
              element.classname.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filterStudent = s;
    }
    notifyListeners();
  }
}
