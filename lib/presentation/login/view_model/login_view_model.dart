import 'dart:async';

import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/domain/usecases/login_usecase.dart';
import 'package:flutter_store_app/presentation/base/base_view_model.dart';

class LoginViewModel
    implements BaseViewModel, LoginViewModelInput, LoginViewModelOutput {
  late LoginUseCase _loginUseCase;
  LoginViewModel();
  //============================================
  //--------------[State]----------------------
  //============================================
  final StreamController<String> _useNameStreamCtrl =
      StreamController.broadcast();
  final StreamController<String> _passwordStreamCtrl =
      StreamController.broadcast();
  final StreamController _formStreamCtrl = StreamController.broadcast();

  final _loginRequestData = LoginRequest();

  //============================================
  //--------------[Inputs]----------------------
  //============================================
  @override
  Sink<String> get _setPassword => _passwordStreamCtrl.sink;

  @override
  Sink<String> get _setUserName => _useNameStreamCtrl.sink;

  @override
  Sink<void> get _setFormValidity => _formStreamCtrl.sink;

  @override
  void login() async {
    var res = await _loginUseCase(_loginRequestData);
    res.fold((failure) {
      print("-----------[FAILURE]---------------");
      print(failure.message);
    }, (loginResponse) {
      print("-----------[SUCCESS]---------------");
      print(loginResponse.status);
      print(loginResponse.message);
    });
  }

  @override
  void setPassword(String password) {
    _setPassword.add(password);
    _loginRequestData.password = password;
    _setFormValidity.add(null);
  }

  @override
  void setUserName(String userName) {
    _setUserName.add(userName);
    _loginRequestData.email = userName;
    _setFormValidity.add(null);
  }

  @override
  void dispose() {
    _passwordStreamCtrl.close();
    _useNameStreamCtrl.close();
  }

  @override
  void init() {
    // TODO: implement init
  }

  //============================================
  //--------------[Outputs]---------------------
  //============================================
  @override
  Stream<bool> get passwordValidity =>
      _passwordStreamCtrl.stream.map(_isPasswordValid);
  @override
  Stream<bool> get userNameValidity =>
      _useNameStreamCtrl.stream.map(_isUsernameValid);
  @override
  Stream<bool> get formValidity => _formStreamCtrl.stream.map(_isFormValid);

  //============================================
  //--------------[Helpers]--------------------
  //============================================
  bool _isPasswordValid(String password) {
    return password.isNotEmpty && password.length > 4;
  }

  bool _isUsernameValid(String userName) {
    return userName.isNotEmpty && userName.length > 4;
  }

  bool _isFormValid(_) {
    return _isPasswordValid(_loginRequestData.password) &&
        _isUsernameValid(_loginRequestData.email);
  }
}

abstract class LoginViewModelInput {
  // ignore: unused_element
  Sink<String> get _setUserName;
  // ignore: unused_element
  Sink<String> get _setPassword;
  // ignore: unused_element
  Sink<void> get _setFormValidity;

  // We didn't expose stream sinks directly because we need to make additional operations
  void setUserName(String userName);
  void setPassword(String password);

  // Use case trigger
  void login();
}

abstract class LoginViewModelOutput {
  Stream<bool> get userNameValidity;
  Stream<bool> get passwordValidity;
  Stream<bool> get formValidity;
}
