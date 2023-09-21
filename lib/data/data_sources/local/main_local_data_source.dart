import 'package:flutter_store_app/app/exceptions.dart';

import '../../responses/home_data_response.dart';
import '../../responses/home_store_details_response.dart';

enum _MainLocalDataSourceKey { homeData, storesData }

abstract class MainLocalDataSource {
  Future<HomeDataGetResponse> getHomeData();
  Future<HomeStoreDetailsResponse> getHomeStoreDetails(int storeId);

  void setHomeData(HomeDataGetResponse homeData);
  void setHomeStoreDetails(
      int storeId, HomeStoreDetailsResponse homeStoreDetails);

  void clear();
  void removeHomeData();
  void removeAllStoresData();
  void removeStoreData(int storeId);
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

  @override
  Future<HomeStoreDetailsResponse> getHomeStoreDetails(int storeId) {
    final cashedStoresData = _cashMap[_MainLocalDataSourceKey.storesData]
        as _CashedItem<Map<int, _CashedItem<HomeStoreDetailsResponse>?>>?;
    if (cashedStoresData == null) throw CashException();
    final targetStoreData = cashedStoresData.data[storeId];
    if (targetStoreData == null || targetStoreData.isNotValid()) {
      throw CashException();
    } else {
      return Future.value(targetStoreData.data);
    }
  }

  @override
  void setHomeStoreDetails(
      int storeId, HomeStoreDetailsResponse homeStoreDetails) {
    if (_cashMap[_MainLocalDataSourceKey.storesData] == null) {
      _cashMap[_MainLocalDataSourceKey.storesData] =
          _CashedItem<Map<int, _CashedItem<HomeStoreDetailsResponse>>>(
              data: {});
    }

    final cashedStoresData = _cashMap[_MainLocalDataSourceKey.storesData]
        as _CashedItem<Map<int, _CashedItem<HomeStoreDetailsResponse>?>>;
    cashedStoresData.data[storeId] =
        _CashedItem<HomeStoreDetailsResponse>(data: homeStoreDetails);
  }

  @override
  void removeAllStoresData() {
    _cashMap.remove(_MainLocalDataSourceKey.storesData);
  }

  @override
  void removeStoreData(int storeId) {
    final cashedStoresData = _cashMap[_MainLocalDataSourceKey.storesData]
        as _CashedItem<Map<int, _CashedItem<HomeStoreDetailsResponse>?>>?;
    if (cashedStoresData == null || cashedStoresData.data[storeId] == null) {
      return;
    }
    cashedStoresData.data.remove(storeId);
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
