import 'dart:async';

import 'package:dio/dio.dart';
import 'package:grocery_genie/services/auth_api_service.dart';
import 'package:grocery_genie/services/dio.dart';
import 'package:grocery_genie/services/prefs.dart';
import 'package:guru_flutter_rest/django/rest_service.dart';
import 'package:guru_provider/guru_provider/repository.dart';

mixin GroceryApiMixin on RestService {
  Dio get dio => Repository.instance.read(dioKey);

  @override
  FutureOr<Options> options(RestMethods method) async {
    final prefs = await Repository.instance.read(prefsKey);
    return Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${prefs.getString(AuthApiService.ACCESS_TOKEN_KEY)}',
      },
    );
  }
}
