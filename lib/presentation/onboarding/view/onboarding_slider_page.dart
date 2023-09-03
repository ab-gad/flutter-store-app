import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../domain/models/onboarding_view_models.dart';
import '../../../resources/values_manager.dart';

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
