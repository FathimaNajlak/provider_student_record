import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_record_provider/database/functions/db_functions.dart';
import 'package:student_record_provider/provider/addstudent_provider.dart';
import 'package:student_record_provider/provider/datacontroller_provider.dart';
import 'package:student_record_provider/provider/edit_provider.dart';
import 'package:student_record_provider/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddProvider()),
        ChangeNotifierProvider(create: (context) => EditProvider()),
        ChangeNotifierProvider(create: (context) => StudentdataProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
