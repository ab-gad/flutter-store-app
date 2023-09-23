import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/presentation/registration/view_model/registeration_view_model.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../../app/service_locator.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/values_manager.dart';
import '../../common/widgets/state_renderer_stream.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _registerViewModel = sl<RegistrationViewModel>();
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _userNameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _countryMobileCodeCtrl = TextEditingController();
  final _mobileNumberCtrl = TextEditingController();

  @override
  void initState() {
    _registerViewModel.init();
    _userNameCtrl.addListener(() {
      _registerViewModel.setUserName(_userNameCtrl.value.text);
    });
    _passwordCtrl.addListener(() {
      _registerViewModel.setPassword(_passwordCtrl.value.text);
    });
    _emailCtrl.addListener(() {
      _registerViewModel.setEmail(_emailCtrl.value.text);
    });
    _countryMobileCodeCtrl.addListener(() {
      _registerViewModel
          .setCountryMobileCode(_countryMobileCodeCtrl.value.text);
    });
    _mobileNumberCtrl.addListener(() {
      _registerViewModel.setMobileNumber(_mobileNumberCtrl.value.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _registerViewModel.dispose();
    _userNameCtrl.dispose();
    _passwordCtrl.dispose();
    _emailCtrl.dispose();
    _countryMobileCodeCtrl.dispose();
    _mobileNumberCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateRendererStream(
      stateRendererStream: _registerViewModel.stateRendererStream,
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: StreamBuilder<File>(
                        stream: _registerViewModel.pictureProfileStream,
                        builder: (context, snapshot) {
                          return snapshot.data?.path.isNotEmpty ?? false
                              ? Image.file(
                                  snapshot.data!,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AppImages.splashLogo,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                );
                        }),
                  ),
                  Positioned(
                    bottom: AppValues.v0,
                    right: AppValues.v0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        iconSize: AppValues.v40,
                        color: ColorManager.primary,
                        onPressed: () {
                          _openPhotoSelectionBottomSheet(context);
                        },
                        icon: const Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: AppValues.v20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: _registerViewModel.userNameValidityStream,
                        builder: ((context, snapshot) {
                          return TextFormField(
                            controller: _userNameCtrl,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: Text(LocaleKeys.userName.tr()),
                              hintText: LocaleKeys.userNameHint.tr(),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : LocaleKeys.userNameErr.tr(),
                            ),
                          );
                        })),
                    const SizedBox(
                      height: AppValues.v20,
                    ),
                    StreamBuilder(
                        stream: _registerViewModel.emailValidityStream,
                        builder: ((context, snapshot) {
                          return TextFormField(
                            controller: _emailCtrl,
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
                        stream: _registerViewModel.passwordValidityStream,
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
                    const SizedBox(
                      height: AppValues.v20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (code) {
                              _registerViewModel
                                  .setCountryMobileCode(code.dialCode);
                            },
                            onInit: (code) {
                              _registerViewModel
                                  .setCountryMobileCode(code?.dialCode);
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: '+20',
                            favorite: const ['EG', '+966'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: true,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: StreamBuilder(
                              stream:
                                  _registerViewModel.mobileNumberValidityStream,
                              builder: ((context, snapshot) {
                                return TextFormField(
                                  controller: _mobileNumberCtrl,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    label: Text(LocaleKeys.phoneNoLabel.tr()),
                                    hintText: LocaleKeys.phoneNoHint.tr(),
                                    errorText: (snapshot.data ?? true)
                                        ? null
                                        : LocaleKeys.phoneNoErr.tr(),
                                  ),
                                );
                              })),
                        ),
                      ],
                    ),
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
                    stream: _registerViewModel.formValidityValidityStream,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? _registerViewModel.register
                            : null,
                        child: Text(LocaleKeys.register.tr()),
                      );
                    }),
              ),
              const SizedBox(
                height: AppValues.v20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: ColorManager.primary,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.login.path,
                  );
                },
                child: Text(
                  LocaleKeys.alreadyHaveAccount.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openPhotoSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(AppValues.v20),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: Text(LocaleKeys.chooseFromGallery.tr()),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: _selectPhotoFromGallery,
                ),
                const SizedBox(
                  height: AppValues.v20,
                ),
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: Text(LocaleKeys.takeAPicture.tr()),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: _selectPhotoUsingCamera,
                ),
              ],
            ),
          ));
        });
  }

  _selectPhotoFromGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _registerViewModel.setProfilePicture(image as File?);
  }

  _selectPhotoUsingCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    _registerViewModel.setProfilePicture(File(image?.path ?? ""));
  }
}
