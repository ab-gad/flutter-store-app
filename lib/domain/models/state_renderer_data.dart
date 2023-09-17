import 'package:flutter_store_app/resources/routes_manager.dart';

import '../../presentation/common/enums/state_renderer_enums.dart';

class StateRendererData {
  final StateRendererType stateType;
  final StateRendererContainer stateContainer;
  final String? message;
  final String? title;
  final AppRoutes? redirectRoute;

  StateRendererData({
    required this.stateType,
    required this.stateContainer,
    this.message,
    this.title,
    this.redirectRoute,
  });

  factory StateRendererData.content() {
    return StateRendererData(
      stateType: StateRendererType.empty,
      stateContainer: StateRendererContainer.content,
    );
  }
}
