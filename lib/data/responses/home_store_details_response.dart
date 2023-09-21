import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/data/responses/base_response.dart';
import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_store_details_response.g.dart';

@JsonSerializable()
class HomeStoreDetailsResponse extends BaseResponse {
  final String? details;
  final String? services;
  final String? about;

  HomeStoreDetailsResponse({
    required this.details,
    required this.services,
    required this.about,
    required super.status,
    required super.message,
  });

  factory HomeStoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeStoreDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStoreDetailsResponseToJson(this);

  HomeStoreItemDetailsModel toDomain() {
    return HomeStoreItemDetailsModel(
      about: about.orEmpty(),
      services: services.orEmpty(),
      details: details.orEmpty(),
    );
  }
}
