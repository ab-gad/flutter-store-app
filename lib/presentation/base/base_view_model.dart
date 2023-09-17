import 'dart:async';

import 'package:flutter_store_app/domain/models/state_renderer_data.dart';

abstract class BaseViewModel
    implements BaseViewModelInput, BaseViewModelOutput {
  final StreamController<StateRendererData> stateRenderer = StreamController();

  @override
  Sink<StateRendererData> get stateRendererSink => stateRenderer.sink;

  @override
  Stream<StateRendererData> get stateRendererStream => stateRenderer.stream;

  @override
  void dispose() {
    stateRenderer.close();
  }
}

/// Base Interface for all view models inputs.
///
/// Contains methods that represents the actions/events
/// that comes from views and will be used in all view models
abstract class BaseViewModelInput {
  void init();
  void dispose();

  Sink<StateRendererData> get stateRendererSink;
}

/// Base Interface for all view models outputs.
///
/// Contains methods that represents the results
/// of the input events that will return to views
/// to be updated corresponding to the new state (result)
abstract class BaseViewModelOutput {
  Stream<StateRendererData> get stateRendererStream;
}
