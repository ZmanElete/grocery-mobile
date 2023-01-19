import 'package:dio/dio.dart';
import 'package:grocery_genie/helpers/http_helpers.dart';
import 'package:grocery_genie/models/user.dart';
import 'package:grocery_genie/services/api/model_rest_service.dart';
import 'package:grocery_genie/services/api/rest_service.dart';

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
      final Response response = await ServiceLocator.dio.get(
        '/$resource/current/',
        options: options(RestMethods.get),
      );
      HttpHelpers.checkError(response);
      final map = response.data;
      return modelFromMap(map);
    } on HttpNotAuthorized {
      if (allowRefresh) {
        AuthApiService.instance.refreshAccessToken();
        return current(allowRefresh: false);
      } else {
        rethrow;
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
