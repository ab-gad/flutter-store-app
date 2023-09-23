import 'package:easy_localization/easy_localization.dart';
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
      debugShowCheckedModeBanner: false,
      //? Easy localization config
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
