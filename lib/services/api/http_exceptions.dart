class AppHttpException implements Exception {
  final String message;

  /// object of type `Response` or `StreamedResponse`
  final dynamic response;
  const AppHttpException(
    this.response, {
    this.message = '',
  });

  @override
  String toString() {
    return message;
  }
}

class RedirectionException extends AppHttpException {
  RedirectionException(
    dynamic response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class BadRequestException extends AppHttpException {
  BadRequestException(
    dynamic response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class UnauthorizedException extends AppHttpException {
  UnauthorizedException(
    dynamic response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class ForbiddenException extends AppHttpException {
  ForbiddenException(
    dynamic response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class NotFoundException extends AppHttpException {
  NotFoundException(
    dynamic response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class MethodNotAllowedException extends AppHttpException {
  MethodNotAllowedException(
    dynamic response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class InternalServerErrorException extends AppHttpException {
  InternalServerErrorException(
    dynamic response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}
