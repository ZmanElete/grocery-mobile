// ignore_for_file: avoid_classes_with_only_static_members

import 'package:dio/dio.dart';

class HttpHelpers {
  ///Implement errors as needed
  static void checkError(Response response) {
    if (response.statusCode == null) throw HttpUnknownError(response);
    if (response.statusCode! < 200 || response.statusCode! > 299) {
      if (response.statusCode! == 401) {
        throw HttpNotAuthorized(response);
      } else if (response.statusCode! == 404) {
        throw HttpNotFound(response);
      } else if (response.statusCode! == 408) {
        throw HttpTimeout(response);
      } else if (response.statusCode! == 500) {
        throw HttpServerError(response);
      } else if (response.statusCode! == 400) {
        throw HttpBadRequest(response);
      } else {
        throw HttpUnknownError(response);
      }
    }
  }
}

abstract class HttpErrorBase implements Exception {
  final int code;
  final Response response;
  const HttpErrorBase(this.code, this.response);
}

class HttpNotAuthorized extends HttpErrorBase {
  const HttpNotAuthorized(Response response): super(401, response);
}

class HttpNotFound extends HttpErrorBase {
  const HttpNotFound(Response response): super(404, response);
}

class HttpTimeout extends HttpErrorBase {
  const HttpTimeout(Response response) : super(408, response);
}

class HttpServerError extends HttpErrorBase {
  const HttpServerError(Response response): super(500, response);
}

class HttpBadRequest extends HttpErrorBase {
  const HttpBadRequest(Response response): super(400, response);
}

class HttpUnknownError extends HttpErrorBase {
  const HttpUnknownError(Response response): super(1, response);
}
