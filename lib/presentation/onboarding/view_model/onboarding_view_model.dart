import 'dart:async';

import 'package:flutter/material.dart';
import '../../base/base_view_model.dart';
import 'onboarding_view_model_state.dart';
import '../../../resources/constants_dart.dart';
import '../../../resources/routes_manager.dart';

import '../../../domain/models/onboarding_view_models.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/string_manager.dart';

class OnboardingViewModel extends BaseViewModel
    implements OnboardingViewModelInput, OnboardingViewModelOutput {
  static const initialPageIndex = 0;
  late int _lastPageIndex;

  late List<SliderObject> _sliderObjects;
  late int _currentPageIndex;

  final PageController _pageController;
  final StreamController<OnboardingViewModelState> _stateStreamController =
      StreamController();

  OnboardingViewModel(this._pageController);

  @override
  Stream<OnboardingViewModelState> get stateStream =>
      _stateStreamController.stream;

  @override
  void init() {
    // create the initial state and update the
    // stream with the new state
    _sliderObjects = _getSliderObjects();
    _lastPageIndex = _sliderObjects.length - 1;
    _currentPageIndex = initialPageIndex;

    update();
  }

  @override
  void dispose() {
    _stateStreamController.close();
  }

  @override
  void goToPreviousPage() {
    final previousPageIndex = _currentPageIndex == initialPageIndex
        ? _lastPageIndex
        : _currentPageIndex - 1;

    _animateToPage(previousPageIndex);
  }

  @override
  void goToNextPage() {
    final nextPageIndex = _currentPageIndex == _lastPageIndex
        ? initialPageIndex
        : _currentPageIndex + 1;

    _animateToPage(nextPageIndex);
  }

  @override
  void skipOnboarding(context) {
    Navigator.pushReplacementNamed(context, RoutesManager.login);
  }

  //helpers
  void _animateToPage(int targetPageIndex) {
    _pageController.animateToPage(
      targetPageIndex,
      duration: const Duration(
        milliseconds: ConstantsManager.onboardingSliderAnimationDurationInMS,
      ),
      curve: Curves.ease,
    );
  }

  @override
  StreamSink<OnboardingViewModelState> get _updateStream =>
      _stateStreamController.sink;

  void update() {
    _updateStream.add(
      OnboardingViewModelState(
        currentIndex: _currentPageIndex,
        currentSliderObject: _sliderObjects[_currentPageIndex],
        totalObjects: _sliderObjects.length,
      ),
    );
  }

  List<SliderObject> _getSliderObjects() {
    return [
      SliderObject(
          title: StringManager.sliderTitle1,
          subTitle: StringManager.sliderSubTitle1,
          imageUrl: AppImages.onboardingLogoSvg1),
      SliderObject(
          title: StringManager.sliderTitle2,
          subTitle: StringManager.sliderSubTitle2,
          imageUrl: AppImages.onboardingLogoSvg2),
      SliderObject(
          title: StringManager.sliderTitle3,
          subTitle: StringManager.sliderSubTitle3,
          imageUrl: AppImages.onboardingLogoSvg3),
      SliderObject(
          title: StringManager.sliderTitle4,
          subTitle: StringManager.sliderSubTitle4,
          imageUrl: AppImages.onboardingLogoSvg4),
    ];
  }

  @override
  void updateCurrentPageIndex(int index) {
    _currentPageIndex = index;
    update();
  }
}

abstract class OnboardingViewModelInput {
  //specify actions(events) that will be emitted
  //from the view and cause state changes
  void goToNextPage();
  void goToPreviousPage();
  void updateCurrentPageIndex(int index);
  void skipOnboarding(BuildContext context);

  StreamSink<OnboardingViewModelState> get _updateStream;
}

abstract class OnboardingViewModelOutput {
  Stream<OnboardingViewModelState> get stateStream;
}
