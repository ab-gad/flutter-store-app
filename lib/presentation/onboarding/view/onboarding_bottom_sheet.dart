import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';
import '../view_model/onboarding_view_model.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

class OnboardingBottomSheet extends StatelessWidget {
  final OnboardingViewModel _onboardingViewModel;
  final int _totalObjects;
  final int _currentIndex;

  const OnboardingBottomSheet(
      this._onboardingViewModel, this._totalObjects, this._currentIndex,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ColorManager.primary,
            ),
            onPressed: () => _onboardingViewModel.skipOnboarding(context),
            child: Text(
              LocaleKeys.skip.tr(),
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
                  _totalObjects,
                  _currentIndex,
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
