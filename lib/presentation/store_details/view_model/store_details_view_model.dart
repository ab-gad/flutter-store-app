import 'dart:async';

import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:flutter_store_app/presentation/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/state_renderer_data.dart';
import '../../../domain/usecases/main/get_home_store_details.dart';
import '../../common/enums/state_renderer_enums.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final StreamController<HomeStoreItemDetailsModel> _storeDetailsCtrl =
      BehaviorSubject();

  final GetHomeStoreDetailsUseCase _getHomeStoreDetailsUseCase;

  StoreDetailsViewModel(
      {required GetHomeStoreDetailsUseCase getHomeStoreDetailsUseCase})
      : _getHomeStoreDetailsUseCase = getHomeStoreDetailsUseCase;

  @override
  Sink<HomeStoreItemDetailsModel> get _storeDetailsSink =>
      _storeDetailsCtrl.sink;

  @override
  getStoreDetails(int storeId) async {
    stateRendererSink.add(
      const StateRendererData(
        stateType: StateRendererType.loading,
        stateContainer: StateRendererContainer.fullScreen,
      ),
    );

    (await _getHomeStoreDetailsUseCase(storeId)).fold((failure) {
      stateRendererSink.add(
        StateRendererData(
          stateType: StateRendererType.failure,
          stateContainer: StateRendererContainer.fullScreen,
          message: failure.message,
          retryFunction: () {
            getStoreDetails(storeId);
          },
        ),
      );
    }, (storeData) {
      _storeDetailsSink.add(storeData);
      stateRendererSink.add(
        const StateRendererData(
          stateType: StateRendererType.success,
          stateContainer: StateRendererContainer.content,
        ),
      );
    });
  }

  @override
  void init() {}

  @override
  void dispose() {
    _storeDetailsCtrl.close();
    super.dispose();
  }

  @override
  Stream<HomeStoreItemDetailsModel> get storeDetailsStream =>
      _storeDetailsCtrl.stream;
}

abstract class StoreDetailsViewModelInput {
  Sink<HomeStoreItemDetailsModel> get _storeDetailsSink;

  getStoreDetails(int storeId);
}

abstract class StoreDetailsViewModelOutput {
  Stream<HomeStoreItemDetailsModel> get storeDetailsStream;
}
