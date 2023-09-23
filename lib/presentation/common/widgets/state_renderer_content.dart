import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/domain/models/state_renderer_content_data.dart';
import 'package:flutter_store_app/resources/style_manager.dart';
import 'package:flutter_store_app/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/locale_keys.g.dart';

/// Each state has the same components
/// a centered columns that hold an image
/// with some title and msg
class StateRendererContent extends StatelessWidget {
  final StateRendererContentData stateData;

  const StateRendererContent({
    super.key,
    required this.stateData,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (stateData.imageUrl != null)
            LottieBuilder.asset(
              stateData.imageUrl!,
              width: AppValues.v100,
              height: AppValues.v100,
              fit: BoxFit.cover,
            ),
          if (stateData.title.isNotEmpty)
            Text(
              stateData.title,
              style: TextStyleManager.boldTextStyle(),
            ),
          Text(
            stateData.message,
            style: TextStyleManager.regularTextStyle(),
            textAlign: TextAlign.center,
          ),
          if (stateData.retryFunction != null)
            Padding(
              padding: const EdgeInsets.only(top: AppValues.v20),
              child: SizedBox(
                width: AppValues.v100 * 2,
                height: AppValues.v20 * 2,
                child: ElevatedButton(
                  onPressed: stateData.retryFunction,
                  child: Text(
                    LocaleKeys.tryAgain.tr(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
