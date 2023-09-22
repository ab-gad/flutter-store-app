import 'package:flutter_store_app/domain/models/state_renderer_data.dart';
import 'package:flutter_store_app/domain/usecases/logout_usecase.dart';
import 'package:flutter_store_app/presentation/base/base_view_model.dart';
import 'package:flutter_store_app/presentation/common/enums/state_renderer_enums.dart';
import 'package:flutter_store_app/resources/routes_manager.dart';

class SettingsViewModel extends BaseViewModel {
  final LogoutUseCase _logoutUseCase;

  SettingsViewModel({required LogoutUseCase logoutUseCase})
      : _logoutUseCase = logoutUseCase;

  @override
  void init() {
    stateRendererSink.add(StateRendererData.content());
  }

  void logout() {
    _logoutUseCase().then((value) {
      if (value == false) {
        stateRendererSink.add(const StateRendererData(
          stateType: StateRendererType.failure,
          stateContainer: StateRendererContainer.popup,
        ));
      } else {
        stateRendererSink.add(StateRendererData.redirect(AppRoutes.login));
      }
    });
  }
}
