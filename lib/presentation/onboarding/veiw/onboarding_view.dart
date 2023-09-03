import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store_app/presentation/onboarding/view_model/onboarding_view_model_state.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../view_model/onboarding_view_model.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController =
      PageController(initialPage: OnboardingViewModel.initialPageIndex);
  late OnboardingViewModel _onboardingViewModel;

  @override
  void initState() {
    _onboardingViewModel = OnboardingViewModel(_pageController);
    _onboardingViewModel.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OnboardingViewModelState>(
        stream: _onboardingViewModel.stateStream,
        builder: (context, snapshot) => _getContentWidget(snapshot.data));
  }

  _getContentWidget(OnboardingViewModelState? stateObject) {
    if (stateObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppValues.v0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor:
                ColorManager.white.withOpacity(AppValues.v0_8),
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
            itemCount: stateObject.totalObjects,
            onPageChanged: (newIndex) {
              _onboardingViewModel.updateCurrentPageIndex(newIndex);
            },
            itemBuilder: (context, index) => OnboardingSliderPage(
              stateObject.currentSliderObject,
            ),
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
                onPressed: () => _onboardingViewModel.skipOnboarding(context),
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
                    onPressed: _onboardingViewModel.goToPreviousPage,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ColorManager.white,
                      size: AppValues.v20,
                    ),
                  ),
                  Row(
                    children: _buildNavigationCircles(
                      stateObject.totalObjects,
                      stateObject.currentIndex,
                    ),
                  ),
                  IconButton(
                    splashRadius: AppValues.v1_5,
                    onPressed: _onboardingViewModel.goToNextPage,
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
  }

  List<Widget> _buildNavigationCircles(int totalObjects, int currentPageIndex) {
    List<Widget> circlesList = [];
    for (var i = 0; i < totalObjects; i++) {
      circlesList.add(
        Padding(
          padding: const EdgeInsets.all(AppValues.v10),
          child: Icon(
            currentPageIndex == i ? Icons.circle_outlined : Icons.circle,
            size: AppValues.v14,
            color: ColorManager.white,
          ),
        ),
      );
    }

    return circlesList;
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
