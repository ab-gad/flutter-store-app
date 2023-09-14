import 'package:flutter_store_app/app/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const langKey = 'language';

abstract class LocalDataSources {
  Future<String> getAppLang();
}

// Shared-preferences package implementor
class LocalDataSourcesImpl implements LocalDataSources {
  final SharedPreferences _prefs;

  LocalDataSourcesImpl(this._prefs);

  @override
  Future<String> getAppLang() {
    var lang = _prefs.getString(langKey);
    if (lang != null) {
      return Future.value(lang);
    } else {
      throw CashException()..message = "Key not found";
    }
  }
}
