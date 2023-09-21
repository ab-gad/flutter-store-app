import 'package:flutter_store_app/app/exceptions.dart';

import '../../responses/home_data_response.dart';

enum _MainLocalDataSourceKey {
  homeData,
}

abstract class MainLocalDataSource {
  Future<HomeDataGetResponse> getHomeData();
  void setHomeData(HomeDataGetResponse homeData);
  void clear();
  void removeHomeData();
}

// Run-time cashing implementor
class MainLocalDataSourceImpl implements MainLocalDataSource {
  final Map<_MainLocalDataSourceKey, _CashedItem> _cashMap = {};

  @override
  void clear() {
    _cashMap.clear();
  }

  @override
  Future<HomeDataGetResponse> getHomeData() {
    final homeData = _cashMap[_MainLocalDataSourceKey.homeData]
        as _CashedItem<HomeDataGetResponse>?;
    if (homeData == null || homeData.isNotValid()) {
      throw CashException();
    } else {
      return Future.value(homeData.data);
    }
  }

  @override
  void removeHomeData() {
    _cashMap.remove(_MainLocalDataSourceKey.homeData);
  }

  @override
  void setHomeData(HomeDataGetResponse homeData) {
    _cashMap[_MainLocalDataSourceKey.homeData] =
        _CashedItem<HomeDataGetResponse>(data: homeData);
  }
}

class _CashedItem<T> {
  final T data;
  final DateTime creationDate = DateTime.now();

  _CashedItem({required this.data});

  bool isValid([Duration validityDuration = const Duration(minutes: 1)]) {
    final currentDate = DateTime.now();
    return currentDate.difference(creationDate).inSeconds <
        validityDuration.inSeconds;
  }

  bool isNotValid([Duration validityDuration = const Duration(minutes: 1)]) {
    final currentDate = DateTime.now();
    return currentDate.difference(creationDate).inSeconds >=
        validityDuration.inSeconds;
  }
}
