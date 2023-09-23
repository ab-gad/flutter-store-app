import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/app/service_locator.dart';
import 'package:flutter_store_app/presentation/common/widgets/state_renderer_stream.dart';
import 'package:flutter_store_app/presentation/main/pages/settings/view_model/settings_view_model.dart';
import 'package:flutter_store_app/resources/assets_manager.dart';
import 'package:flutter_store_app/resources/color_manager.dart';
import 'package:flutter_store_app/resources/values_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../generated/locale_keys.g.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _viewModel = sl<SettingsViewModel>();

  List<_SettingModel> get _settingsMenu => [
        _SettingModel(
            title: LocaleKeys.changeLang,
            iconUrl: AppImages.changeLangIcon,
            onTapCallback: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(const Locale('ar'));
              } else {
                context.setLocale(const Locale('en'));
              }
            }),
        _SettingModel(
            title: LocaleKeys.contactUs,
            iconUrl: AppImages.contactUsIcon,
            onTapCallback: () {}),
        _SettingModel(
            title: LocaleKeys.inviteFriends,
            iconUrl: AppImages.inviteFriendsIcon,
            onTapCallback: () {}),
        _SettingModel(
            title: LocaleKeys.logout,
            iconUrl: AppImages.logoutIcon,
            onTapCallback: _viewModel.logout),
      ];

  @override
  void initState() {
    _viewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateRendererStream(
      stateRendererStream: _viewModel.stateRendererStream,
      content: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(AppValues.v10),
      child: ListView(
        children: _settingsMenu.map(_buildSettingsListTile).toList(),
      ),
    );
  }

  Widget _buildSettingsListTile(_SettingModel settingData) {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset(
            settingData.iconUrl,
            width: AppValues.v20 + 5,
          ),
          title: Text(settingData.title).tr(),
          trailing: SvgPicture.asset(AppImages.settingsRightArrowIcon),
          onTap: settingData.onTapCallback,
          textColor: AppColors.darkGrey.value,
          minVerticalPadding: AppValues.v20,
          titleAlignment: ListTileTitleAlignment.center,
          subtitle: settingData.title == LocaleKeys.changeLang
              ? Text(context.locale.toString())
              : null,
        ),
        Divider(
          color: AppColors.lightGrey.value,
        )
      ],
    );
  }
}

class _SettingModel {
  final String title;
  final String iconUrl;
  final VoidCallback onTapCallback;

  _SettingModel({
    required this.title,
    required this.iconUrl,
    required this.onTapCallback,
  });
}
