import 'dart:async';

import 'package:dio/dio.dart';
import 'package:grocery_genie/helpers/http_helpers.dart';
import 'package:grocery_genie/models/user.dart';
import 'package:grocery_genie/services/auth_api_service.dart';
import 'package:grocery_genie/services/mixins/grocery_api_mixin.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_flutter_rest/django/rest_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class UserApiService extends GenericRestService<User> with GroceryApiMixin {
  static StateKey<UserApiService> key = StateKey(() => UserApiService());

  UserApiService() : super('user');

  Future<User> current({allowRefresh = true}) async {
    try {
      final Response response = await dio.get(
        '/$resource/current/',
        options: await options(RestMethods.get),
      );
      HttpHelpers.checkError(response);
      final map = response.data;
      return modelFromMap(map);
    } on HttpNotAuthorized {
      if (allowRefresh) {
        await Repository.instance.read(AuthApiService.key).refreshAccessToken();
        return current(allowRefresh: false);
      } else {
        rethrow;
      }
    }
  }

  @override
  User modelFromMap(Map<String, dynamic> m) {
    return User.fromJson(m);
  }
}
