// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataGetResponse _$HomeDataGetResponseFromJson(Map<String, dynamic> json) =>
    HomeDataGetResponse(
      data: json['data'] == null
          ? null
          : HomeDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['msg'] as String?,
    );

Map<String, dynamic> _$HomeDataGetResponseToJson(
        HomeDataGetResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.message,
      'data': instance.data,
    };

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) =>
    HomeDataResponse(
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => BannerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => HomeDataResponseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => HomeDataResponseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDataResponseToJson(HomeDataResponse instance) =>
    <String, dynamic>{
      'banners': instance.banners,
      'services': instance.services,
      'stores': instance.stores,
    };

HomeDataResponseItem _$HomeDataResponseItemFromJson(
        Map<String, dynamic> json) =>
    HomeDataResponseItem(
      id: json['id'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$HomeDataResponseItemToJson(
        HomeDataResponseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
    };

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      id: json['id'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$BannerResponseToJson(BannerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'link': instance.link,
    };
