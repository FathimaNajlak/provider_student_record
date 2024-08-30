// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:student_record_provider/database/functions/db_functions.dart';
import 'package:student_record_provider/database/model/data_model.dart';

class EditProvider extends ChangeNotifier {
  String updatedImagepath = "";

  final formKey = GlobalKey<FormState>(); //  form key for the validation
  final nameController = TextEditingController();
  final classController = TextEditingController();
  final guardianController = TextEditingController();
  final mobileController = TextEditingController();
  addimage(String image) {
    updatedImagepath = image;
    notifyListeners();
  }

  initiate({
    required String imagepath,
    required String name,
    required String studentclass,
    required String father,
    required String pnumber,
  }) {
    nameController.text = name;
    classController.text = studentclass;
    guardianController.text = father;
    mobileController.text = pnumber;
    updatedImagepath = imagepath;
  }

  Future<void> geterimage(ImageSource source, EditProvider editProvider) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }

    editProvider.addimage(image.path);
  }

  Future<void> editstudentclicked(BuildContext context, StudentModel student,
      EditProvider editprovide) async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text.toUpperCase();
      final classA = classController.text.toString().trim();
      final father = guardianController.text;
      final phonenumber = mobileController.text.trim();

      final updatedStudent = StudentModel(
        id: student.id,
        name: name,
        classname: classA,
        father: father,
        pnumber: phonenumber,
        imagex: editprovide.updatedImagepath,
      );
      Navigator.of(context).pop();
      await editStudent(
          student.id!,
          updatedStudent.name,
          updatedStudent.classname,
          updatedStudent.father,
          updatedStudent.pnumber,
          updatedStudent.imagex,
          context);
    }
  }

  void editphoto(ctxr, EditProvider editProvider, context) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          title: const Text('Update Photo '),
          actions: [
            Column(
              children: [
                Row(
                  children: [
                    const Text('Choose from camera'),
                    IconButton(
                      onPressed: () {
                        geterimage(ImageSource.camera, editProvider);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Choose from gallery '),
                    IconButton(
                      onPressed: () {
                        geterimage(ImageSource.gallery, editProvider);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.image,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
