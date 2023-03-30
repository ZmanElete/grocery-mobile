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
    response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class BadRequestException extends AppHttpException {
  BadRequestException(
    response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class UnauthorizedException extends AppHttpException {
  UnauthorizedException(
    response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class ForbiddenException extends AppHttpException {
  ForbiddenException(
    response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class NotFoundException extends AppHttpException {
  NotFoundException(
    response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class MethodNotAllowedException extends AppHttpException {
  MethodNotAllowedException(
    response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}

class InternalServerErrorException extends AppHttpException {
  InternalServerErrorException(
    response, {
    String message = '',
  }) : super(
          response,
          message: message,
        );
}
