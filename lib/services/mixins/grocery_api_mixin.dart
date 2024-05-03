import 'dart:async';

import 'package:dio/dio.dart';
import 'package:grocery_genie/services/dio.dart';
import 'package:guru_flutter_rest/django/rest_service.dart';
import 'package:guru_provider/guru_provider/repository.dart';


mixin GroceryApiMixin on RestService {
  Dio get dio => Repository.instance.read(dioKey);

  @override
  FutureOr<Options> options(RestMethods method) {
    return options(method);
  }
}