// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:student_record_provider/database/functions/db_functions.dart';
import 'package:student_record_provider/database/model/data_model.dart';
import 'package:student_record_provider/provider/datacontroller_provider.dart';

class AddProvider extends ChangeNotifier {
  String imagepath = "";
  final formKey = GlobalKey<FormState>();
  addimage(String image) {
    imagepath = image;
    notifyListeners();
  }

  initialization() {
    imagepath = '';
    nameController.clear();
    classController.clear();
    guardianController.clear();
    mobileController.clear();
  }

  final nameController = TextEditingController();
  final classController = TextEditingController();
  final guardianController = TextEditingController();
  final mobileController = TextEditingController();

  Future<void> addstudentclicked(
      BuildContext context, AddProvider addStudent) async {
    if (formKey.currentState!.validate() && imagepath.isNotEmpty) {
      final name = nameController.text.toUpperCase();
      final classA = classController.text.toString().trim();
      final father = guardianController.text;
      final phonenumber = mobileController.text.trim();

      final stdData = StudentModel(
        name: name,
        classname: classA,
        father: father,
        pnumber: phonenumber,
        imagex: imagepath,
      );

      await addstudent(
          stdData, context); // Update with the correct function call

      // Notify StudentdataProvider to refresh data
      Provider.of<StudentdataProvider>(context, listen: false).intialize();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      initialization();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add Profile Picture '),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> getimage(ImageSource source, AddProvider addProvider) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    addProvider.addimage(image.path);
  }

  void addphoto(ctxr, AddProvider addprovider, context) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          content: const Text('Profile'),
          actions: [
            IconButton(
              onPressed: () {
                getimage(ImageSource.camera, addprovider);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                getimage(ImageSource.gallery, addprovider);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
