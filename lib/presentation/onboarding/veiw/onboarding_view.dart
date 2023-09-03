import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_store_app/presentation/onboarding/veiw/onboarding_bottom_sheet.dart';
import 'package:flutter_store_app/presentation/onboarding/view_model/onboarding_view_model_state.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

import '../view_model/onboarding_view_model.dart';
import 'onboarding_slider_page.dart';

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
        bottomSheet: OnboardingBottomSheet(
          _onboardingViewModel,
          stateObject.totalObjects,
          stateObject.currentIndex,
        ),
      );
    }
  }
}
