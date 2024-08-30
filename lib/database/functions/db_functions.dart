// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:io';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:student_record_provider/database/model/data_model.dart';
import 'package:student_record_provider/provider/datacontroller_provider.dart';

late Database _db;
Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'student_db',
    version: 1,
    onCreate: (Database db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, classname TEXT, father TEXT, pnumber TEXT, imagex TEXT)');
    },
  );
}

Future<List<StudentModel>> getstudentdata() async {
  final result = await _db.rawQuery("SELECT * FROM student");
  List<StudentModel> l1 = [];
  for (var map in result) {
    final student = StudentModel.fromMap(map);
    l1.add(student);
  }
  return l1;
}

Future<void> addstudent(StudentModel value, context) async {
  try {
    await _db.rawInsert(
      'INSERT INTO student(name,classname,father,pnumber,imagex) VALUES(?,?,?,?,?)',
      [value.name, value.classname, value.father, value.pnumber, value.imagex],
    );
    await Provider.of<StudentdataProvider>(context).intialize();
  } catch (e) {
    stdout.write('Error inserting data: $e');
  }
}

Future<void> deleteStudent(id, context) async {
  await _db.delete('student', where: 'id=?', whereArgs: [id]);
  await Provider.of<StudentdataProvider>(context, listen: false).intialize();
}

Future<void> editStudent(
    id, name, classname, father, pnumber, imagex, context) async {
  final dataflow = {
    'name': name,
    'classname': classname,
    'father': father,
    'pnumber': pnumber,
    'imagex': imagex,
  };
  await _db.update('student', dataflow, where: 'id=?', whereArgs: [id]);
  await Provider.of<StudentdataProvider>(context, listen: false).intialize();
}
