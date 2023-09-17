import 'package:flutter_store_app/domain/models/base_response_model.dart';

class ForgotPasswordResponseModel extends BaseResponseModel {
  final String support;

  ForgotPasswordResponseModel({
    required super.status,
    required super.message,
    required this.support,
  });
}
