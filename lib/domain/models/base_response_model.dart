class BaseResponseModel {
  final int status;
  final String message;

  BaseResponseModel({
    required this.status,
    required this.message,
  });
}
