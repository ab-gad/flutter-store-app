import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_store_app/app/app_regex.dart';
import 'package:flutter_store_app/data/requests/fogot_password_request.dart';
import 'package:flutter_store_app/domain/models/state_renderer_data.dart';
import 'package:flutter_store_app/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter_store_app/presentation/base/base_view_model.dart';
import 'package:flutter_store_app/presentation/common/enums/state_renderer_enums.dart';

import '../../../generated/locale_keys.g.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements _ForgotPasswordViewModelInput, _ForgotPasswordViewModelOutput {
  ForgotPasswordViewModel(this._forgotPassword);
  //======================================
  //------------[Dependencies]-----------
  //======================================
  final ForgotPasswordUseCase _forgotPassword;
  //======================================
  //---------------[State]---------------
  //======================================
  final StreamController<String> _emailStreamCtrl = StreamController();
  final forgotPasswordData = ForgotPasswordRequest();

  //======================================
  //---------------[Inputs]---------------
  //======================================
  @override
  Sink<String> get _emailStreamSink => _emailStreamCtrl.sink;

  @override
  void init() {
    stateRendererSink.add(StateRendererData.content());
  }

  @override
  void dispose() {
    _emailStreamCtrl.close();
    super.dispose();
  }

  @override
  void setEmail(String email) {
    forgotPasswordData.email = email;
    _emailStreamSink.add(email);
  }

  @override
  void forgetPassword() async {
    stateRendererSink.add(
      StateRendererData(
        stateType: StateRendererType.loading,
        stateContainer: StateRendererContainer.popup,
      ),
    );
    (await _forgotPassword(forgotPasswordData)).fold((failure) {
      stateRendererSink.add(
        StateRendererData(
            stateType: StateRendererType.failure,
            stateContainer: StateRendererContainer.popup),
      );
    }, (response) {
      stateRendererSink.add(
        StateRendererData(
          stateType: StateRendererType.success,
          stateContainer: StateRendererContainer.popup,
          title: LocaleKeys.success.tr(),
          message: response.support,
        ),
      );
    });
  }

  //======================================
  //---------------[Outputs]---------------
  //======================================
  @override
  Stream<bool> get emailValidatorStream =>
      _emailStreamCtrl.stream.map(_isEmailValid);

  bool _isEmailValid(String email) {
    return AppRegex.emailRegex.hasMatch(email);
  }
}

abstract class _ForgotPasswordViewModelInput {
  Sink<String> get _emailStreamSink; // private input
  void setEmail(String email); // exposed input
  void forgetPassword(); // use case
}

abstract class _ForgotPasswordViewModelOutput {
  Stream<bool> get emailValidatorStream;
}
