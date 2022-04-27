import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:grocery_list/helpers/http_helpers.dart';
import 'package:grocery_list/models/user.dart';
import 'package:grocery_list/services/api/model_rest_service.dart';
import 'package:grocery_list/services/api/rest_service.dart';

import '../service_locator.dart';
import 'auth_api_service.dart';

class UserApiService extends GenericRestService<User> {
  static UserApiService get instance =>
      _instance != null ? _instance! : UserApiService();
  static UserApiService? _instance;

  UserApiService()
      : super('user') {
    _instance = this;
  }

  Future<User> current({allowRefresh = true}) async {
    try {
      Response response = await ServiceLocator.dio.get(
        '/$resource/current/',
        options: options(RestMethods.get),
      );
      HttpHelpers.checkError(response);
      var map = response.data;
      return modelFromMap(map);
    } on HttpNotAuthorized catch (e) {
      if (allowRefresh) {
        AuthApiService.instance.refreshAccessToken();
        return current(allowRefresh: false);
      } else {
        throw e;
      }
    }
  }

  @override
  User modelFromMap(Map<String, dynamic> m) {
    return User.fromMap(m);
  }
  //Only super users can user the delete function
  //All 'user' endpoints are filtered down to only the user that is accessing them.
}
