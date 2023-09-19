import 'package:flutter_store_app/data/responses/base_response.dart';
import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_data_response.g.dart';

@JsonSerializable()
class HomeDataGetResponse extends BaseResponse {
  factory HomeDataGetResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataGetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataGetResponseToJson(this);

  final HomeDataResponse? data;

  HomeDataGetResponse({
    required this.data,
    required super.status,
    required super.message,
  });

  HomeDataModel toDomain() {
    List<BannerModel> banners = (data?.banners?.isNotEmpty ?? false)
        ? data!.banners!
            .map((banner) => BannerModel(
                  id: banner.id ?? '',
                  title: banner.title ?? '',
                  image: banner.image ?? '',
                  link: banner.link ?? "",
                ))
            .toList()
        : [];
    List<HomeDataModelItem> services = (data?.banners?.isNotEmpty ?? false)
        ? data!.banners!
            .map((banner) => HomeDataModelItem(
                  id: banner.id ?? '',
                  title: banner.title ?? '',
                  image: banner.image ?? '',
                ))
            .toList()
        : [];
    List<HomeDataModelItem> stores = (data?.banners?.isNotEmpty ?? false)
        ? data!.banners!
            .map((banner) => HomeDataModelItem(
                  id: banner.id ?? '',
                  title: banner.title ?? '',
                  image: banner.image ?? '',
                ))
            .toList()
        : [];

    return HomeDataModel(banners: banners, services: services, stores: stores);
  }
}

@JsonSerializable()
class HomeDataResponse {
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  final List<BannerResponse>? banners;
  final List<HomeDataResponseItem>? services;
  final List<HomeDataResponseItem>? stores;

  HomeDataResponse({
    required this.banners,
    required this.services,
    required this.stores,
  });
}

@JsonSerializable()
class HomeDataResponseItem {
  factory HomeDataResponseItem.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseItemFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataResponseItemToJson(this);

  final String? id;
  final String? title;
  final String? image;

  HomeDataResponseItem({
    required this.id,
    required this.title,
    required this.image,
  });
}

@JsonSerializable()
class BannerResponse extends HomeDataResponseItem {
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);

  final String? link;

  BannerResponse({
    required super.id,
    required super.title,
    required super.image,
    required this.link,
  });
}
