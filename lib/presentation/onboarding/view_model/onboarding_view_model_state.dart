import 'package:flutter_store_app/presentation/onboarding/veiw/onboarding_view.dart';

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
