import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_store_app/app/app_regex.dart';
import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/data/requests/register_request.dart';
import 'package:flutter_store_app/domain/models/state_renderer_data.dart';
import 'package:flutter_store_app/domain/usecases/register_usecase.dart';
import 'package:flutter_store_app/presentation/base/base_view_model.dart';
import 'package:flutter_store_app/presentation/common/enums/state_renderer_enums.dart';
import 'package:flutter_store_app/resources/routes_manager.dart';

import '../../../generated/locale_keys.g.dart';

class RegistrationViewModel extends BaseViewModel
    implements _RegistrationViewModelInput, _RegistrationViewModelOutput {
  //=====================================
  //------------[dependencies]-----------
  //=====================================
  //! Dependency injection
  final RegisterUseCase registerUserCase;

  RegistrationViewModel({required this.registerUserCase});

  //=====================================
  //----------------[State]--------------
  //=====================================
  var registerRequestData = RegisterRequest(); // data object

  final StreamController<String> _emailStreamCtrl =
      StreamController.broadcast();
  final StreamController<String> _userNameStreamCtrl =
      StreamController.broadcast();
  final StreamController<String> _passwordStreamCtrl =
      StreamController.broadcast();
  final StreamController<String> _mobileNumberStreamCtrl =
      StreamController.broadcast();
  final StreamController<File> _profilePictureStreamCtrl =
      StreamController.broadcast();
  final StreamController<String> _countryMobileCodeStreamCtrl =
      StreamController.broadcast();
  final StreamController<bool> _formValidityCtrl = StreamController.broadcast();

  //=====================================
  //----------------[Inputs]-------------
  //=====================================
  //! Life cycle inputs
  @override
  void init() {
    stateRendererSink.add(StateRendererData.content());
  }

  @override
  void dispose() {
    _emailStreamCtrl.close();
    _userNameStreamCtrl.close();
    _passwordStreamCtrl.close();
    _mobileNumberStreamCtrl.close();
    _profilePictureStreamCtrl.close();
    _countryMobileCodeStreamCtrl.close();
    _formValidityCtrl.close();
    super.dispose();
  }

  //! Use Case [MAIN INPUT]
  @override
  void register() async {
    stateRendererSink.add(
      const StateRendererData(
        stateType: StateRendererType.loading,
        stateContainer: StateRendererContainer.popup,
      ),
    );
    (await registerUserCase(registerRequestData)).fold(
      (failure) {
        stateRendererSink.add(
          StateRendererData(
            stateType: StateRendererType.failure,
            stateContainer: StateRendererContainer.popup,
            message: failure.message,
          ),
        );
      },
      (response) {
        stateRendererSink.add(
          StateRendererData(
            stateType: StateRendererType.success,
            stateContainer: StateRendererContainer.fullScreen,
            title: LocaleKeys.success.tr(),
            message: response.message,
            redirectRoute: AppRoutes.main,
          ),
        );
      },
    );
  }

  //! Public inputs (exposed to the register view)
  @override
  void setCountryMobileCode(String? countryMobileCode) {
    _countryMobileCodeStreamSink.add(countryMobileCode.orEmpty());
    if (_countryMobileValidator(countryMobileCode)) {
      registerRequestData.countryMobileCode = countryMobileCode!;
    } else {
      registerRequestData.countryMobileCode = '';
    }
    _formValidityStreamSink.add(_formValidator());
  }

  @override
  void setEmail(String email) {
    _emailStreamSink.add(email);
    if (_emailValidator(email)) {
      registerRequestData.email = email;
    } else {
      registerRequestData.email = '';
    }
    _formValidityStreamSink.add(_formValidator());
  }

  @override
  void setMobileNumber(String mobileNumber) {
    _mobileNumberStreamSink.add(mobileNumber);
    if (_mobileNumberValidator(mobileNumber)) {
      registerRequestData.mobileNumber = mobileNumber;
    } else {
      registerRequestData.mobileNumber = '';
    }
    _formValidityStreamSink.add(_formValidator());
  }

  @override
  void setPassword(String password) {
    _passwordStreamSink.add(password);
    if (_passwordValidator(password)) {
      registerRequestData.password = password;
    } else {
      registerRequestData.password = '';
    }
    _formValidityStreamSink.add(_formValidator());
  }

  @override
  void setProfilePicture(File? profilePicture) {
    if (_pictureProfileValidator(profilePicture)) {
      registerRequestData.profilePicture = profilePicture!.path;
      _pictureProfileStreamSink.add(profilePicture);
    } else {
      registerRequestData.profilePicture = '';
    }
    _formValidityStreamSink.add(_formValidator());
  }

  @override
  void setUserName(String userName) {
    _userNameStreamSink.add(userName);
    if (_userNameValidator(userName)) {
      registerRequestData.userName = userName;
    } else {
      registerRequestData.userName = '';
    }
    _formValidityStreamSink.add(_formValidator());
  }

  //! Private Inputs [Actual inputs (stream manipulators)]
  @override
  Sink<String> get _countryMobileCodeStreamSink =>
      _countryMobileCodeStreamCtrl.sink;

  @override
  Sink<String> get _emailStreamSink => _emailStreamCtrl.sink;

  @override
  Sink<bool> get _formValidityStreamSink => _formValidityCtrl.sink;

  @override
  Sink<String> get _mobileNumberStreamSink => _mobileNumberStreamCtrl.sink;

  @override
  Sink<String> get _passwordStreamSink => _passwordStreamCtrl.sink;

  @override
  Sink<File> get _pictureProfileStreamSink => _profilePictureStreamCtrl.sink;

  @override
  Sink<String> get _userNameStreamSink => _userNameStreamCtrl.sink;

  //=====================================
  //--------------[Outputs]--------------
  //=====================================

  @override
  Stream<bool> get countryMobileCodeValidityStream =>
      _countryMobileCodeStreamCtrl.stream.map(_countryMobileValidator);

  @override
  Stream<bool> get emailValidityStream =>
      _emailStreamCtrl.stream.map(_emailValidator);

  @override
  Stream<bool> get mobileNumberValidityStream =>
      _mobileNumberStreamCtrl.stream.map(_mobileNumberValidator);

  @override
  Stream<bool> get passwordValidityStream =>
      _passwordStreamCtrl.stream.map(_passwordValidator);

  @override
  Stream<File> get pictureProfileStream => _profilePictureStreamCtrl.stream;

  @override
  Stream<bool> get userNameValidityStream =>
      _userNameStreamCtrl.stream.map(_userNameValidator);

  @override
  Stream<bool> get formValidityValidityStream => _formValidityCtrl.stream;

  //==================================
  //-------------[Helpers]------------
  //==================================
  bool _isNotNull(dynamic value) => value != null;
  bool _isValidString(String? value, [int min = 2]) =>
      (value != null && value.isNotEmpty && value.length >= min);

  bool _countryMobileValidator(String? value) => _isValidString(value);
  bool _emailValidator(String value) =>
      (_isValidString(value) && AppRegex.emailRegex.hasMatch(value));
  bool _mobileNumberValidator(String value) => _isValidString(value, 9);
  bool _passwordValidator(String value) => _isValidString(value, 6);
  bool _pictureProfileValidator(File? value) =>
      (_isNotNull(value) && value!.path.isNotEmpty);
  bool _userNameValidator(String value) => _isValidString(value);
  bool _formValidator() => (registerRequestData.countryMobileCode.isNotEmpty &&
          registerRequestData.mobileNumber.isNotEmpty &&
          registerRequestData.email.isNotEmpty &&
          registerRequestData.password.isNotEmpty &&
          registerRequestData.userName.isNotEmpty
      // registerRequestData.profilePicture.isNotEmpty &&
      );
}

abstract class _RegistrationViewModelInput {
  Sink<String> get _emailStreamSink;
  Sink<String> get _userNameStreamSink;
  Sink<String> get _passwordStreamSink;
  Sink<String> get _mobileNumberStreamSink;
  Sink<String> get _countryMobileCodeStreamSink;
  Sink<bool> get _formValidityStreamSink;
  Sink<File> get _pictureProfileStreamSink;

  void setEmail(String email);
  void setUserName(String userName);
  void setPassword(String password);
  void setMobileNumber(String mobileNumber);
  void setProfilePicture(File? profilePicture);
  void setCountryMobileCode(String? countryMobileCode);

  void register();
}

abstract class _RegistrationViewModelOutput {
  Stream<bool> get emailValidityStream;
  Stream<bool> get userNameValidityStream;
  Stream<bool> get passwordValidityStream;
  Stream<bool> get mobileNumberValidityStream;
  Stream<bool> get countryMobileCodeValidityStream;
  Stream<bool> get formValidityValidityStream;
  Stream<File> get pictureProfileStream;
}
