import 'dart:convert';

import 'package:grocery_list/helpers/http_helpers.dart';
import 'package:grocery_list/models/user.dart';
import 'package:grocery_list/services/api/rest_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserApiService extends RestService<User> {
  static UserApiService get instance =>
      _instance != null ? _instance! : UserApiService();
  static UserApiService? _instance;

  UserApiService()
      : super(
          apiModelCreator: (map) => User.fromMap(map),
          resource: 'user',
        ) {
    _instance = this;
  }

  Future<User> current({allowRefresh = true}) async {
    try {
      Response response = await http.get(
        Uri.parse('${config.apiUrl}/$resource/current/'),
        headers: headers(RestMethods.get),
      );
      HttpHelpers.checkError(response);
      var map = Map<String, dynamic>.from(jsonDecode(response.body));
      return apiModelCreator(map);
    } on HttpNotAuthorized catch (e) {
      if (allowRefresh) {
        authApiService.refreshAccessToken();
        return current(allowRefresh: false);
      } else {
        throw e;
      }
    }
  }
  //Only super users can user the delete function
  //All 'user' endpoints are filtered down to only the user that is accessing them.
}
