import 'package:flutter/material.dart';
import '../presentation/onboarding/view/onboarding_view.dart';
import '../presentation/forget_password/view/forget_password_view.dart';
import '../presentation/login/view/login_view.dart';
import '../presentation/registration/view/registration_view.dart';
import '../presentation/splash/splash_view.dart';

import '../presentation/main/main_view.dart';
import '../presentation/page_not_found/page_not_found_view.dart';
import '../presentation/store_details/view/store_details_view.dart';

abstract class RoutesManager {
  static const splash = '/';
  static const registration = '/registration';
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const forgetPassword = '/forgetPassword';
  static const main = '/main';
  static const storeDetails = '/storeDetails';
  static const pageNotFound = '/404';

  static Route<dynamic> generateRout(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => settings.route.page,
      settings: settings,
    );
  }

  static get undefinedRout =>
      generateRout(AppRouteSettings(AppRoutes.pageNotFound));
}

class AppRouteSettings extends RouteSettings {
  final AppRoutes route;

  AppRouteSettings(this.route, [Object? arguments])
      : super(name: route.path, arguments: arguments);
}

enum AppRoutes {
  splash,
  registration,
  login,
  forgetPassword,
  main,
  storeDetails,
  pageNotFound,
  onboarding,
}

extension RoutesDetails on AppRoutes {
  String get path => switch (this) {
        AppRoutes.splash => RoutesManager.splash,
        AppRoutes.registration => RoutesManager.registration,
        AppRoutes.login => RoutesManager.login,
        AppRoutes.forgetPassword => RoutesManager.forgetPassword,
        AppRoutes.main => RoutesManager.main,
        AppRoutes.storeDetails => RoutesManager.storeDetails,
        AppRoutes.onboarding => RoutesManager.onboarding,
        AppRoutes.pageNotFound => RoutesManager.pageNotFound,
      };
  Widget get page => switch (this) {
        AppRoutes.splash => const SplashView(),
        AppRoutes.registration => const RegistrationView(),
        AppRoutes.login => const LoginView(),
        AppRoutes.forgetPassword => const ForgetPasswordView(),
        AppRoutes.main => const MainView(),
        AppRoutes.storeDetails => const StoreDetailsView(),
        AppRoutes.onboarding => const OnboardingView(),
        AppRoutes.pageNotFound => const PageNotFoundView(),
      };
}

extension RouteData on RouteSettings {
  AppRoutes get route => switch (name) {
        RoutesManager.splash => AppRoutes.splash,
        RoutesManager.registration => AppRoutes.registration,
        RoutesManager.login => AppRoutes.login,
        RoutesManager.forgetPassword => AppRoutes.forgetPassword,
        RoutesManager.main => AppRoutes.main,
        RoutesManager.storeDetails => AppRoutes.storeDetails,
        RoutesManager.onboarding => AppRoutes.onboarding,
        (_) => AppRoutes.pageNotFound,
        // AppRoutes.pageNotFound => RoutesManager.pageNotFound,
      };
}
