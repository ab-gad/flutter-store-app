import '../../../domain/models/onboarding_view_models.dart';

class OnboardingViewModelState {
  final int currentIndex;
  final int totalObjects;
  final SliderObject currentSliderObject;

  OnboardingViewModelState({
    required this.currentIndex,
    required this.currentSliderObject,
    required this.totalObjects,
  });
}
