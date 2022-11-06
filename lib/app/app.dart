import 'package:complete_advanced_project/presentation/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {// default constructor
  MyApp._internal(); //private name constructor
  int appState = 0;
  static MyApp instance = MyApp._internal(); // single instance --singleton

  factory MyApp() => instance; // factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
