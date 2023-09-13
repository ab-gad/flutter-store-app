import '../enums/response_status_enum.dart';

class BaseResponseModel {
  final ResponseStatusEnum status;
  final String message;

  BaseResponseModel({
    required this.status,
    required this.message,
  });
}
