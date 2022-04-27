import 'package:dio/dio.dart';
import 'package:grocery_list/services/api/auth_api_service.dart';
import 'package:grocery_list/services/service_locator.dart';

import 'http_exceptions.dart';

enum RestMethods {
  get,
  list,
  create,
  update,
  patch,
  delete,
}

abstract class RestService {
  final List<RestMethods> authenticatedActions;

  RestService({this.authenticatedActions = RestMethods.values});

  Options options(RestMethods method) {
    var prefs = ServiceLocator.prefs;
    var token = prefs.get(AuthApiService.ACCESS_TOKEN_KEY);
    var options = Options();
    if (this.authenticatedActions.contains(method)) {
      options.headers = {"Authorization": "JWT $token"};
    }
    return options;
  }

  checkError(dynamic response) {
    if (response is Response) {
      if (response.isRedirect ?? false || (response.statusCode! >= 300 && response.statusCode! < 400)) {
        throw RedirectionException(response, message: response.statusMessage ?? 'redirect');
      }
      if (response.statusCode == 400) {
        throw BadRequestException(response, message: response.statusMessage ?? 'bad request');
      }
      if (response.statusCode == 401) {
        throw UnauthorizedException(response, message: response.statusMessage ?? 'unauthorized');
      }
      if (response.statusCode == 403) {
        throw ForbiddenException(response, message: response.statusMessage ?? 'forbidden');
      }
      if (response.statusCode == 404) {
        throw NotFoundException(response, message: response.statusMessage ?? 'not found');
      }
      if (response.statusCode == 405) {
        throw MethodNotAllowedException(response, message: response.statusMessage ?? 'method not allowed');
      }
      if (response.statusCode == 500) {
        throw InternalServerErrorException(response, message: response.statusMessage ?? 'internal server error');
      }
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        throw RedWolfHttpException(response, message: response.statusMessage ?? 'Unknown Error');
      }
    } else {
      throw Exception('HttpService::_checkError was not given a response object');
    }
  }
}
