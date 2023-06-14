import 'package:flutter/material.dart';
import 'pages/percentagePage.dart';
import 'pages/profilePage.dart';
import 'pages/moodPage2.dart';
import 'pages/homePage.dart';
import 'registerScreen.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'pages/sqf_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUBES_APB_KEL6',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
