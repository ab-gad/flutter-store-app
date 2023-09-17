import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/domain/models/state_renderer_content_data.dart';
import 'package:flutter_store_app/presentation/common/widgets/state_renderer_content.dart';
import 'package:flutter_store_app/resources/assets_manager.dart';
import 'package:flutter_store_app/resources/routes_manager.dart';
import 'package:flutter_store_app/resources/string_manager.dart';
import 'package:flutter_store_app/resources/values_manager.dart';

import '../../../domain/models/state_renderer_data.dart';
import '../enums/state_renderer_enums.dart';

class StateRenderer extends StatelessWidget {
  final StateRendererData stateRendererData;
  final Widget content;

  const StateRenderer({
    super.key,
    required this.stateRendererData,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return _buildStateWidget(context);
  }

  Widget _buildStateWidget(BuildContext context) {
    if (stateRendererData.stateContainer == StateRendererContainer.content) {
      return content;
    }
    if (stateRendererData.redirectRoute != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(
          context,
          stateRendererData.redirectRoute!.path,
        );
      });
      return content;
    }
    if (stateRendererData.stateContainer == StateRendererContainer.fullScreen) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppValues.v20),
          child: StateRendererContent(
            stateData: _getStateRendererData(),
          ),
        ),
      );
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(AppValues.v20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StateRendererContent(
                    stateData: _getStateRendererData(),
                  ),
                  if (stateRendererData.stateType == StateRendererType.failure)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppValues.v20,
                      ),
                      child: SizedBox(
                        height: AppValues.v50,
                        width: AppValues.v100 * 2,
                        child: ElevatedButton(
                          onPressed: Navigator.of(context).pop,
                          child: const Text(StringManager.ok),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      });
      return content;
    }
  }

  StateRendererContentData _getStateRendererData() {
    return switch (stateRendererData.stateType) {
      StateRendererType.loading => StateRendererContentData(
          imageUrl: AppImages.loadingStateJsonImage,
          message: stateRendererData.message ?? StringManager.loading,
          title: stateRendererData.title.orEmpty(),
        ),
      StateRendererType.failure => StateRendererContentData(
          imageUrl: AppImages.errorStateJsonImage,
          message: stateRendererData.message ?? StringManager.unknownErr,
          title: stateRendererData.title.orEmpty(),
        ),
      StateRendererType.success => StateRendererContentData(
          imageUrl: AppImages.successStateJsonImage,
          message: stateRendererData.message ?? StringManager.success,
          title: stateRendererData.title.orEmpty(),
        ),
      StateRendererType.empty => StateRendererContentData(
          imageUrl: AppImages.emptyStateJsonImage,
          message: stateRendererData.message ?? StringManager.noData,
          title: stateRendererData.title.orEmpty(),
        ),
    };
  }
}
