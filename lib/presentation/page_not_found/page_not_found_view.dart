import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../generated/locale_keys.g.dart';

class PageNotFoundView extends StatelessWidget {
  const PageNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.pageNotFound.tr()),
        centerTitle: true,
      ),
      body: Center(
        child: Text(LocaleKeys.pageNotFoundMsg.tr()),
      ),
    );
  }
}
