import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_record_provider/const/color.dart';

import 'package:student_record_provider/provider/addstudent_provider.dart';
import 'package:student_record_provider/screens/text_form_field.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AddProvider>(context, listen: false).initialization();
    return Consumer<AddProvider>(
      builder: (context, addStudent, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Add Student'),
          actions: [
            IconButton(
              onPressed: () {
                addStudent.addstudentclicked(context, addStudent);
              },
              icon: const Icon(Icons.save_alt_outlined),
            )
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: addStudent.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                          backgroundImage: addStudent.imagepath.isNotEmpty
                              ? FileImage(File(addStudent.imagepath))
                              : const AssetImage('assets/profile.jpg')
                                  as ImageProvider,
                          radius: 75),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: IconButton(
                          onPressed: () {
                            addStudent.addphoto(context, addStudent, context);
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: Colors.black45,
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  ReuseTextFormField(
                    controller: addStudent.nameController,
                    labelText: "Name",
                    hintText: 'enter name',
                    keyboardType: TextInputType.name,
                    validationMessage: 'Please enter a Name',
                  ),
                  const SizedBox(height: 20),
                  ReuseTextFormField(
                      controller: addStudent.classController,
                      labelText: "Class",
                      hintText: 'enter class',
                      keyboardType: TextInputType.text,
                      validationMessage: 'Please enter a Class'),
                  const SizedBox(height: 20),
                  ReuseTextFormField(
                      controller: addStudent.guardianController,
                      labelText: "Guardian",
                      hintText: 'enter Guardian name',
                      keyboardType: TextInputType.name,
                      validationMessage: 'Please enter a Guardian'),
                  const SizedBox(height: 20),
                  ReuseTextFormField(
                      controller: addStudent.mobileController,
                      labelText: "Mobile",
                      hintText: 'Mobile Number',
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      validationMessage: 'Please enter Mobile Number'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
