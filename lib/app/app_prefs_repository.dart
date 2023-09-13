import 'package:flutter_store_app/app/app_constants.dart';
import 'package:flutter_store_app/app/exceptions.dart';
import 'package:flutter_store_app/data/data_sources/local_data_source.dart';

abstract class AppPrefsRepository {
  Future<String> get appLang;
}

class AppPrefsRepositoryImpl implements AppPrefsRepository {
  final LocalDataSources _localDataSource;

  AppPrefsRepositoryImpl(this._localDataSource);

  @override
  Future<String> get appLang async {
    try {
      var lang = await _localDataSource.appLang;
      return lang;
    } on CashException {
      return AppConstants.defaultLangCode;
    }
  }
}
