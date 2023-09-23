import 'package:flutter/material.dart';
import 'package:flutter_store_app/app/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'firebase_options.dart';
import 'app/main_app.dart';
import 'generated/codegen_loader.g.dart';

void main() async {
  // Register dependencies to get it service locator.
  // as u see the registration is done before the run app,
  // so if one or more dependencies relies on the underlying
  // platform to make some process or obtain some info,
  // make sure to use [WidgetsFlutterBinding.ensureInitialized()]
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/l10n', // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: MainApp()),
  );
}
