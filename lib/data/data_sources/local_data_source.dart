import 'package:flutter_store_app/app/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const langKey = 'language';
const isOnboardingViewedKey = 'isOnboardingViewed';

enum _CashKeys {
  language,
  isOnboardingViewed,
  isUserLoggedIn,
}

enum _CashTypes {
  string,
  number,
  boolean,
}

abstract class LocalDataSources {
  Future<String> get appLang;
  Future<bool> get isOnboardingViewed;
  Future<bool> get isUserLoggedIn;

  Future<void> setIsOnboardingViewed(bool isOnboardingViewed);
  Future<void> setIsUserLoggedIn(bool isLoggedIn);
}

// Shared-preferences package implementor
class LocalDataSourcesImpl implements LocalDataSources {
  final SharedPreferences _prefs;

  LocalDataSourcesImpl(this._prefs);

  @override
  Future<String> get appLang =>
      _getCashedValue<String>(_CashKeys.language, _CashTypes.string);

  @override
  Future<bool> get isOnboardingViewed =>
      _getCashedValue<bool>(_CashKeys.isOnboardingViewed, _CashTypes.boolean);

  @override
  Future<bool> get isUserLoggedIn =>
      _getCashedValue<bool>(_CashKeys.isUserLoggedIn, _CashTypes.boolean);

  @override
  Future<void> setIsOnboardingViewed(bool isOnboardingViewed) {
    return _setCashedValue(
        _CashKeys.isOnboardingViewed, _CashTypes.boolean, isOnboardingViewed);
  }

  @override
  Future<void> setIsUserLoggedIn(bool isLoggedIn) {
    return _setCashedValue(
        _CashKeys.isUserLoggedIn, _CashTypes.boolean, isLoggedIn);
  }

  Future<T> _getCashedValue<T>(_CashKeys key, _CashTypes cashValueType) {
    final val = switch (cashValueType) {
      _CashTypes.string => _prefs.getString(key.name),
      _CashTypes.number => _prefs.getInt(key.name),
      _CashTypes.boolean => _prefs.getBool(key.name),
    };
    if (val != null) {
      return Future.value(val as T);
    } else {
      throw CashException();
    }
  }

  Future<void> _setCashedValue(
      _CashKeys key, _CashTypes cashValueType, dynamic value) async {
    final val = await switch (cashValueType) {
      _CashTypes.string => _prefs.setString(key.name, value),
      _CashTypes.number => _prefs.setInt(key.name, value),
      _CashTypes.boolean => _prefs.setBool(key.name, value),
    };
    if (val != true) {
      throw CashException();
    }
  }

  Future<bool> reset() {
    return _prefs.clear();
  }
}
