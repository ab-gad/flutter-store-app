// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeStoreDetailsResponse _$HomeStoreDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    HomeStoreDetailsResponse(
      details: json['details'] as String?,
      services: json['services'] as String?,
      about: json['about'] as String?,
      status: json['status'] as int?,
      message: json['msg'] as String?,
    );

Map<String, dynamic> _$HomeStoreDetailsResponseToJson(
        HomeStoreDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.message,
      'details': instance.details,
      'services': instance.services,
      'about': instance.about,
    };
