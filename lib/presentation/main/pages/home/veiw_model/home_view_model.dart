import 'dart:async';
import 'dart:ffi';

import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:flutter_store_app/domain/models/state_renderer_data.dart';
import 'package:flutter_store_app/domain/usecases/main/get_home_data_usecase.dart';
import 'package:flutter_store_app/presentation/base/base_view_model.dart';
import 'package:flutter_store_app/presentation/common/enums/state_renderer_enums.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInput, HomeViewModelOutput {
  //=================================
  // ---------[Dependencies]
  //=================================
  final GetHomeDataUseCase _getHomeDataUseCase;

  HomeViewModel({required GetHomeDataUseCase getHomeDataUseCase})
      : _getHomeDataUseCase = getHomeDataUseCase;

  //=================================
  // ---------[State]
  //=================================
  final StreamController<HomeDataModel> _homeDataStreamCtrl = BehaviorSubject();

  //=================================
  // ---------[Inputs]
  //=================================
  @override
  Sink<HomeDataModel> get _homeDataSink => _homeDataStreamCtrl.sink;

  @override
  void dispose() {
    _homeDataStreamCtrl.close();
    super.dispose();
  }

  @override
  void getHomeData() async {
    stateRendererSink.add(
      StateRendererData(
        stateType: StateRendererType.loading,
        stateContainer: StateRendererContainer.fullScreen,
      ),
    );

    (await _getHomeDataUseCase(Void)).fold((failure) {
      stateRendererSink.add(
        StateRendererData(
          stateType: StateRendererType.failure,
          stateContainer: StateRendererContainer.fullScreen,
          message: failure.message,
          retryFunction: getHomeData,
        ),
      );
    }, (homeData) {
      _homeDataSink.add(homeData);
      stateRendererSink.add(
        StateRendererData(
          stateType: StateRendererType.success,
          stateContainer: StateRendererContainer.content,
        ),
      );
    });
  }

  @override
  void init() {
    getHomeData();
  }

//==================================
//--------------[Outputs]
//==================================
  @override
  Stream<HomeDataModel> get homeDataStream => _homeDataStreamCtrl.stream;
}

abstract class HomeViewModelInput {
  //? use case
  void getHomeData();

  //? Sink
  Sink<HomeDataModel> get _homeDataSink;
}

abstract class HomeViewModelOutput {
  Stream<HomeDataModel> get homeDataStream;
}
