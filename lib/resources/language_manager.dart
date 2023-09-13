import 'package:flutter_store_app/app/app_constants.dart';

enum AppLanguages {
  arabic(AppConstants.arabicCode),
  english(AppConstants.englishCode);

  const AppLanguages(this.code);
  final String code;
}
