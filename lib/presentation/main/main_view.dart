import 'package:flutter/material.dart';
import 'package:flutter_store_app/presentation/main/pages/home/view/home_page.dart';
import 'package:flutter_store_app/presentation/main/pages/notification/notification_page.dart';
import 'package:flutter_store_app/presentation/main/pages/search/search_page.dart';
import 'package:flutter_store_app/presentation/main/pages/settings/settings_page.dart';
import 'package:flutter_store_app/resources/color_manager.dart';
import 'package:flutter_store_app/resources/string_manager.dart';
import 'package:flutter_store_app/resources/values_manager.dart';

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
        title: Text(_activePage.title),
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: StringManager.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: StringManager.search,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                label: StringManager.notification,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: StringManager.settings,
              ),
            ]),
      ),
    );
  }
}

enum _MainViewPages {
  home(page: HomePage(), title: StringManager.home),
  search(page: SearchPage(), title: StringManager.search),
  notification(page: NotificationPage(), title: StringManager.notification),
  settings(page: SettingsPage(), title: StringManager.settings);

  final Widget page;
  final String title;

  const _MainViewPages({required this.page, required this.title});
}
