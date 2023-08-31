import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_store_app/resources/assets_manager.dart';
import 'package:flutter_store_app/resources/color_manager.dart';
import 'package:flutter_store_app/resources/constants_dart.dart';
import 'package:flutter_store_app/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.asset(AppImages.splashLogo),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer(
      const Duration(
        seconds: ConstantsManager.splashDelayInSeconds,
      ),
      _goToOnboardingView,
    );
  }

  void _cancelTimer() {
    _timer.cancel();
  }

  void _goToOnboardingView() {
    Navigator.pushReplacementNamed(context, RoutesManager.onboarding);
  }
}
