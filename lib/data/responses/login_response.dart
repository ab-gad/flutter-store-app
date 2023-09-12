import 'package:flutter_store_app/data/responses/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse {
  final CustomerResponse? customer;
  final ContactsResponse? contacts;

  LoginResponse({
    required super.status,
    required super.message,
    required this.customer,
    required this.contacts,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class CustomerResponse {
  final String? id;
  final String? name;
  @JsonKey(name: 'numOfNotification')
  final int? numberOfNotifications;

  CustomerResponse({
    required this.id,
    required this.name,
    required this.numberOfNotifications,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  final String? email;
  final String? password;
  final String? link;

  ContactsResponse({
    required this.email,
    required this.password,
    required this.link,
  });

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}
