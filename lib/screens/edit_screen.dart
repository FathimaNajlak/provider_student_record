// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_record_provider/database/model/data_model.dart';
import 'package:student_record_provider/provider/edit_provider.dart';
import 'package:student_record_provider/screens/text_form_field.dart';

class EditStudent extends StatelessWidget {
  StudentModel student;
  EditStudent({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    Provider.of<EditProvider>(context, listen: false).initiate(
        imagepath: student.imagex,
        name: student.name,
        studentclass: student.classname,
        father: student.father,
        pnumber: student.pnumber);
    return Consumer<EditProvider>(
      builder: (BuildContext context, editstudent, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student'),
          actions: [
            IconButton(
              onPressed: () {
                editstudent.editstudentclicked(context, student, editstudent);
              },
              icon: const Icon(Icons.cloud_upload),
            )
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: editstudent.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () => editstudent.editphoto(
                              context, editstudent, context),
                          child: CircleAvatar(
                            backgroundImage:
                                FileImage(File(editstudent.updatedImagepath)),
                            radius: 75,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: ReuseTextFormField(
                            controller: editstudent.nameController,
                            labelText: "Name",
                            hintText: 'enter name',
                            keyboardType: TextInputType.name,
                            validationMessage: 'Please enter a Name',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: ReuseTextFormField(
                              controller: editstudent.classController,
                              labelText: "Class",
                              hintText: 'enter class',
                              keyboardType: TextInputType.text,
                              validationMessage: 'Please enter a Class'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: ReuseTextFormField(
                              controller: editstudent.guardianController,
                              labelText: "Guardian",
                              hintText: 'enter Guardian name',
                              keyboardType: TextInputType.name,
                              validationMessage: 'Please enter a Guardian'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: ReuseTextFormField(
                              controller: editstudent.mobileController,
                              labelText: "Mobile",
                              hintText: 'Mobile Number',
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              validationMessage: 'Please enter Mobile Number'),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
