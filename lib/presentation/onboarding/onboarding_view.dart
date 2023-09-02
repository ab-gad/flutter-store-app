import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_dart.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<SliderObject> _sliderObjects = [
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
  static const _initialPageIndex = 0;

  final _pageController = PageController(initialPage: _initialPageIndex);
  late int _lastPageIndex;
  int _currentPageIndex = _initialPageIndex;

  @override
  Widget build(BuildContext context) {
    _lastPageIndex = _sliderObjects.length - 1;
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: ColorManager.white.withOpacity(0.8),
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).viewPadding.top -
            AppValues.v100,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _sliderObjects.length,
          itemBuilder: _buildSliderPages,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: ColorManager.primary,
              ),
              onPressed: _skipOnboarding,
              child: Text(
                StringManager.skip,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Container(
            height: AppValues.v50,
            color: ColorManager.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  splashRadius: AppValues.v1_5,
                  onPressed: _goToPreviousPage,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.white,
                    size: AppValues.v20,
                  ),
                ),
                Row(
                  children: _buildNavigationCircles(),
                ),
                IconButton(
                  splashRadius: AppValues.v1_5,
                  onPressed: _goToNextPage,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.white,
                    size: AppValues.v20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  OnboardingSliderPage _buildSliderPages(
      BuildContext context, int targetElementIndex) {
    return OnboardingSliderPage(_sliderObjects[targetElementIndex]);
  }

  List<Widget> _buildNavigationCircles() {
    List<Widget> circlesList = [];
    for (var i = 0; i < _sliderObjects.length; i++) {
      circlesList.add(
        Padding(
          padding: const EdgeInsets.all(AppValues.v10),
          child: Icon(
            _currentPageIndex == i ? Icons.circle_outlined : Icons.circle,
            size: AppValues.v14,
            color: ColorManager.white,
          ),
        ),
      );
    }

    return circlesList;
  }

  void _goToNextPage() {
    final nextPageIndex = _currentPageIndex == _lastPageIndex
        ? _initialPageIndex
        : _currentPageIndex + 1;
    _animateToPage(nextPageIndex);
  }

  void _animateToPage(int targetPageIndex) {
    _pageController.animateToPage(
      targetPageIndex,
      duration: const Duration(
        milliseconds: ConstantsManager.onboardingSliderAnimationDurationInMS,
      ),
      curve: Curves.ease,
    );
  }

  void _goToPreviousPage() {
    final previousPageIndex = _currentPageIndex == _initialPageIndex
        ? _lastPageIndex
        : _currentPageIndex - 1;
    _animateToPage(previousPageIndex);
  }

  void _skipOnboarding() {
    Navigator.pushReplacementNamed(context, RoutesManager.login);
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

class OnboardingSliderPage extends StatelessWidget {
  final SliderObject _pageData;

  const OnboardingSliderPage(this._pageData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppValues.v20,
        ),
        Padding(
          padding: const EdgeInsets.all(AppValues.v8),
          child: Text(
            _pageData.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.v16),
          child: Text(
            _pageData.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(
          height: AppValues.v40,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: AppValues.v40),
            child: SvgPicture.asset(
              _pageData.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
