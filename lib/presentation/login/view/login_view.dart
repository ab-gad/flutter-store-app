import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/app/service_locator.dart';
import 'package:flutter_store_app/presentation/common/widgets/state_renderer_stream.dart';
import 'package:flutter_store_app/presentation/login/view_model/login_view_model.dart';
import 'package:flutter_store_app/resources/assets_manager.dart';
import 'package:flutter_store_app/resources/routes_manager.dart';
import 'package:flutter_store_app/resources/values_manager.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../resources/color_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginViewModel = sl<LoginViewModel>();

  final _formKey = GlobalKey<FormState>();
  final _userNameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void initState() {
    _loginViewModel.init();
    _userNameCtrl.addListener(() {
      _loginViewModel.setUserName(_userNameCtrl.value.text);
    });
    _passwordCtrl.addListener(() {
      _loginViewModel.setPassword(_passwordCtrl.value.text);
    });
    _userNameCtrl.value = const TextEditingValue(text: "abc@gmail.com");
    _passwordCtrl.value = const TextEditingValue(text: "123456");
    super.initState();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    _userNameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateRendererStream(
      stateRendererStream: _loginViewModel.stateRendererStream,
      content: _contentBuilder(),
    );
  }

  _contentBuilder() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppValues.v20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppValues.v100,
              ),
              Image.asset(AppImages.splashLogo),
              const SizedBox(
                height: AppValues.v20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: _loginViewModel.userNameValidity,
                        builder: ((context, snapshot) {
                          return TextFormField(
                            controller: _userNameCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              label: Text(LocaleKeys.emailLabel.tr()),
                              hintText: LocaleKeys.emailHint.tr(),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : LocaleKeys.emailErr.tr(),
                            ),
                          );
                        })),
                    const SizedBox(
                      height: AppValues.v20,
                    ),
                    StreamBuilder(
                        stream: _loginViewModel.passwordValidity,
                        builder: ((context, snapshot) {
                          return TextFormField(
                            controller: _passwordCtrl,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              label: Text(LocaleKeys.password.tr()),
                              hintText: LocaleKeys.password.tr(),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : LocaleKeys.passwordErr.tr(),
                            ),
                          );
                        })),
                  ],
                ),
              ),
              const SizedBox(
                height: AppValues.v20,
              ),
              SizedBox(
                width: double.infinity,
                height: AppValues.v50,
                child: StreamBuilder<bool>(
                    stream: _loginViewModel.formValidity,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: (snapshot.data.orFalse())
                            ? _loginViewModel.login
                            : null,
                        child: Text(LocaleKeys.login.tr()),
                      );
                    }),
              ),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: ColorManager.primary,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.forgetPassword.path,
                    );
                  },
                  child: Text(
                    LocaleKeys.forgotPassword.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: ColorManager.primary,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.registration.path,
                    );
                  },
                  child: Text(
                    LocaleKeys.notMember.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
