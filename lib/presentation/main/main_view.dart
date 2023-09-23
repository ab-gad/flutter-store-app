import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/presentation/main/pages/home/view/home_page.dart';
import 'package:flutter_store_app/presentation/main/pages/notification/notification_page.dart';
import 'package:flutter_store_app/presentation/main/pages/search/search_page.dart';
import 'package:flutter_store_app/presentation/main/pages/settings/view/settings_page.dart';
import 'package:flutter_store_app/resources/color_manager.dart';
import 'package:flutter_store_app/resources/values_manager.dart';

import '../../generated/locale_keys.g.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  _MainViewPages _activePage = _MainViewPages.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_activePage.title.tr()),
      ),
      body: _activePage.page,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            spreadRadius: AppValues.v4,
            blurRadius: AppValues.v10,
            offset: Offset(AppValues.v0, AppValues.v10),
          ),
        ]),
        child: BottomNavigationBar(
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.darkGrey,
            onTap: (newPageIndex) {
              setState(() {
                _activePage = _MainViewPages.values[newPageIndex];
              });
            },
            currentIndex: _activePage.index,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: LocaleKeys.home.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: LocaleKeys.search.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                label: LocaleKeys.notification.tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: LocaleKeys.settings.tr(),
              ),
            ]),
      ),
    );
  }
}

enum _MainViewPages {
  home(page: HomePage(), title: LocaleKeys.home),
  search(page: SearchPage(), title: LocaleKeys.search),
  notification(page: NotificationPage(), title: LocaleKeys.notification),
  settings(page: SettingsPage(), title: LocaleKeys.settings);

  final Widget page;
  final String title;

  const _MainViewPages({required this.page, required this.title});
}
