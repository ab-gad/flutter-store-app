import 'package:flutter/material.dart';
import 'package:flutter_store_app/presentation/forget_password/forget_password_view.dart';
import 'package:flutter_store_app/presentation/login/login_view.dart';
import 'package:flutter_store_app/presentation/registration/registration_view.dart';
import 'package:flutter_store_app/presentation/splash/splash_view.dart';

import '../presentation/main/main_view.dart';
import '../presentation/page_not_found/page_not_found_view.dart';
import '../presentation/store_details/store_details_view.dart';

abstract class RoutesManager {
  static const splash = '/';
  static const registration = '/registration';
  static const login = '/login';
  static const forgetPassword = '/forgetPassword';
  static const main = '/main';
  static const storeDetails = '/storeDetails';
  static const pageNotFound = '/404';

  static MaterialPageRoute generateRout(AppRoutes route, [Object? arguments]) {
    return MaterialPageRoute(builder: (_) => route.page);
  }

  static get undefinedRout => generateRout(AppRoutes.pageNotFound);
}

enum AppRoutes {
  splash,
  registration,
  login,
  forgetPassword,
  main,
  storeDetails,
  pageNotFound,
}

extension RoutesDetails on AppRoutes {
  String get path => switch (this) {
        AppRoutes.splash => RoutesManager.splash,
        AppRoutes.registration => RoutesManager.registration,
        AppRoutes.login => RoutesManager.login,
        AppRoutes.forgetPassword => RoutesManager.forgetPassword,
        AppRoutes.main => RoutesManager.main,
        AppRoutes.storeDetails => RoutesManager.storeDetails,
        AppRoutes.pageNotFound => RoutesManager.pageNotFound,
      };
  Widget get page => switch (this) {
        AppRoutes.splash => const SplashView(),
        AppRoutes.registration => const RegistrationView(),
        AppRoutes.login => const LoginView(),
        AppRoutes.forgetPassword => const ForgetPasswordView(),
        AppRoutes.main => const MainView(),
        AppRoutes.storeDetails => const StoreDetailsView(),
        AppRoutes.pageNotFound => const PageNotFoundView(),
      };
}
