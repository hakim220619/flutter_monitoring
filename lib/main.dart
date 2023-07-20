import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monitoring/home/view/home.dart';
// ignore: unused_import
import 'package:monitoring/login/view/logo.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LoginApp",
      debugShowCheckedModeBanner: false,
      home: LogoPage(),
      builder: EasyLoading.init(),
    );
  }
}
