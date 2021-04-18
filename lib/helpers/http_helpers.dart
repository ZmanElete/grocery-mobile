import 'package:http/http.dart';

class HttpHelpers {
  ///Impliment errors as needed
  static void checkError(Response response) {
    if (response.statusCode < 200 || response.statusCode > 299) {
      if (response.statusCode == 401)
        throw HttpNotAuthorized(response);
      else if (response.statusCode == 404)
        throw HttpNotFound(response);
      else if (response.statusCode == 408)
        throw HttpTimeout(response);
      else if (response.statusCode == 500)
        throw HttpServerError(response);
      else if (response.statusCode == 400)
        throw HttpBadRequest(response);
      else
        throw HttpUnknownError(response);
    }
  }
}

abstract class HttpErrorBase implements Exception {
  abstract final int code;
  abstract final Response response;
  const HttpErrorBase();
}

class HttpNotAuthorized implements HttpErrorBase {
  final int code = 401;
  final Response response;
  const HttpNotAuthorized(this.response);
}

class HttpNotFound implements HttpErrorBase {
  final int code = 404;
  final Response response;
  const HttpNotFound(this.response) : super();
}

class HttpTimeout implements HttpErrorBase {
  final int code = 408;
  final Response response;
  const HttpTimeout(this.response) : super();
}

class HttpServerError implements HttpErrorBase {
  final int code = 500;
  final Response response;
  const HttpServerError(this.response) : super();
}

class HttpBadRequest implements HttpErrorBase {
  final int code = 400;
  final Response response;
  const HttpBadRequest(this.response) : super();
}

class HttpUnknownError implements HttpErrorBase {
  final int code = -1;
  final Response response;
  const HttpUnknownError(this.response) : super();
}
