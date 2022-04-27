class RedWolfHttpException implements Exception {
  String message;
  /// object of type `Response` or `StreamedResponse`
  dynamic response;
  RedWolfHttpException(this.response, {this.message=''});

  @override
  String toString() {
    return message;
  }
}

class RedirectionException extends RedWolfHttpException {
  String message;
  /// object of type `Response` or `StreamedResponse`
  dynamic response;
  RedirectionException(this.response, {this.message=''}) : super(response, message: message);
}

class BadRequestException extends RedWolfHttpException {
  String message;
  /// object of type `Response` or `StreamedResponse`
  dynamic response;
  BadRequestException(this.response, {this.message=''}) : super(response, message: message);
}

class UnauthorizedException extends RedWolfHttpException {
  String message;
  /// object of type `Response` or `StreamedResponse`
  dynamic response;
  UnauthorizedException(this.response, {this.message=''}) : super(response, message: message);
}

class ForbiddenException extends RedWolfHttpException {
  String message;
  /// object of type `Response` or `StreamedResponse`
  dynamic response;
  ForbiddenException(this.response, {this.message=''}) : super(response, message: message);
}

class NotFoundException extends RedWolfHttpException {
  String message;
  /// object of type `Response` or `StreamedResponse`
  dynamic response;
  NotFoundException(this.response, {this.message=''}) : super(response, message: message);
}

class MethodNotAllowedException extends RedWolfHttpException {
  String message;
  /// object of type `Response` or `StreamedResponse`
  dynamic response;
  MethodNotAllowedException(this.response, {this.message=''}) : super(response, message: message);
}

class InternalServerErrorException extends RedWolfHttpException {
  String message;
  /// object of type `Response` or `StreamedResponse`
  dynamic response;
  InternalServerErrorException(this.response, {this.message=''}) : super(response, message: message);
}
