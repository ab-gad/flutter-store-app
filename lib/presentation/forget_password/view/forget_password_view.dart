import 'package:flutter/material.dart';
import 'package:flutter_store_app/app/service_locator.dart';
import 'package:flutter_store_app/presentation/common/widgets/state_renderer_stream.dart';
import 'package:flutter_store_app/presentation/forget_password/view_model/forgot_password_view_model.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _emailCtrl = TextEditingController();
  final _forgetPasswordViewModel = sl<ForgotPasswordViewModel>();

  @override
  void initState() {
    _forgetPasswordViewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _forgetPasswordViewModel.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateRendererStream(
      stateRendererStream: _forgetPasswordViewModel.stateRendererStream,
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
              Column(
                children: [
                  StreamBuilder(
                    stream: _forgetPasswordViewModel.emailValidatorStream,
                    builder: ((context, snapshot) {
                      return Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              _forgetPasswordViewModel.setEmail(value);
                            },
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              label: const Text(StringManager.emailLabel),
                              hintText: StringManager.emailHint,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : StringManager.emailErr,
                            ),
                          ),
                          const SizedBox(
                            height: AppValues.v20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: AppValues.v50,
                            child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? _forgetPasswordViewModel.forgetPassword
                                  : null,
                              child: const Text(StringManager.resetPassword),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: ColorManager.primary,
                ),
                onPressed: () {},
                child: Text(
                  StringManager.didNotReceiveEmail,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
