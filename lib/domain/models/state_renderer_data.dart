import 'package:flutter/material.dart';
import 'package:flutter_store_app/resources/routes_manager.dart';

import '../../presentation/common/enums/state_renderer_enums.dart';

@immutable
class StateRendererData {
  final StateRendererType stateType;
  final StateRendererContainer stateContainer;
  final String? message;
  final String? title;
  final AppRoutes? redirectRoute;
  final VoidCallback? retryFunction;

  const StateRendererData({
    required this.stateType,
    required this.stateContainer,
    this.message,
    this.title,
    this.redirectRoute,
    this.retryFunction,
  });

  factory StateRendererData.content() {
    return const StateRendererData(
      stateType: StateRendererType.empty,
      stateContainer: StateRendererContainer.content,
    );
  }

  factory StateRendererData.loading() {
    return const StateRendererData(
      stateType: StateRendererType.loading,
      stateContainer: StateRendererContainer.fullScreen,
    );
  }
}
