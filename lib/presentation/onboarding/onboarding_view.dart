import 'package:flutter/material.dart';
import 'package:flutter_store_app/resources/assets_manager.dart';
import 'package:flutter_store_app/resources/string_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<SliderObject> _sliderObjcets = [
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

  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [Container()],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class SliderObject {
  final String title;
  final String subTitle;
  final String imageUrl;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  });
}
