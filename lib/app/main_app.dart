import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  static const MainApp instance = MainApp._internal();

  const MainApp._internal();

  factory MainApp() {
    return instance;
  }

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Center(
        child: Text("Main App"),
      ),
    );
  }
}
