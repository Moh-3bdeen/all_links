abstract class AppException implements Exception {
  final String message;

  AppException(this.message);

}

class ServerException extends AppException {
  ServerException([message]) : super(message);
}

class WrongPasswordOrEmailException extends AppException {
  WrongPasswordOrEmailException([message]) : super(message);
}

class NoInternetException extends AppException {
  NoInternetException([message])
      : super(message);
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message);
}