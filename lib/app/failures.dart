class Failure {
  final String message;

  Failure({required this.message});
}

class NetworkFailure extends Failure {
  final int code;

  NetworkFailure({required super.message, required this.code});
}

class CashFailure extends Failure {
  CashFailure({required super.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({required super.message});
}

class NoConnectionFailure extends Failure {
  NoConnectionFailure({required super.message});
}
