import 'package:flutter/material.dart';
import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';

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
    return MaterialApp(
      theme: ThemeManager.getAppTheme(),
      onGenerateRoute: RoutesManager.generateRout,
      initialRoute: RoutesManager.splash,
      home: const Center(
        child: Text("Main App"),
      ),
    );
  }
}
