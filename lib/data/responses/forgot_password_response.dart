import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/data/responses/base_response.dart';
import 'package:flutter_store_app/domain/enums/response_status_enum.dart';
import 'package:flutter_store_app/domain/models/forgot_password_response_moder.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  final String support;

  ForgotPasswordResponse({
    required this.support,
    required super.status,
    required super.message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

  ForgotPasswordResponseModel toDomain() {
    return ForgotPasswordResponseModel(
        message: message.orEmpty(),
        support: support.orEmpty(),
        status: status.orZero() == ResponseStatusEnum.failure.statusCode
            ? ResponseStatusEnum.failure
            : ResponseStatusEnum.success);
  }
}
