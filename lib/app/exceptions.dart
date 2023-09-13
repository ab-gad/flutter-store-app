class CustomException implements Exception {
  String message;

  CustomException([this.message = 'Unknown Error']);
}

class CashException extends CustomException {}

class NetworkException extends CustomException {}

class UnknownException extends CustomException {}
