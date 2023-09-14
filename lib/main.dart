import 'package:flutter/material.dart';
import 'package:flutter_store_app/app/service_locator.dart';

import 'app/main_app.dart';

void main() async {
  // Register dependencies to get it service locator.
  // as u see the registration is done before the run app,
  // so if one or more dependencies relies on the underlying
  // platform to make some process or obtain some info,
  // make sure to use [WidgetsFlutterBinding.ensureInitialized()]
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  runApp(MainApp());
}
