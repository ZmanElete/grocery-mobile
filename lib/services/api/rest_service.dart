import 'dart:convert';

import 'package:grocery_list/helpers/http_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_api_service.dart';
import 'package:grocery_list/models/config.dart';
import 'package:grocery_list/services/service_locator.dart';
import 'package:grocery_list/models/api_model.dart';

enum RestMethods {
  get,
  list,
  create,
  update,
  patch,
  delete,
}

abstract class RestService<T extends ApiModel> {
  final AuthApiService authApiService = AuthApiService.instance;
  final SharedPreferences prefs = ServiceLocator.prefs;
  final Config config = Config.instance;

  String resource;
  List<RestMethods> authenticatedActions = RestMethods.values;
  T Function(Map<String, dynamic>) apiModelCreator;

  /// [resource] The name of the resource, used in URLS (ex `users`)
  /// [modelInstance] An instance of T, needed to create new instances with clone
  RestService({
    this.authenticatedActions = RestMethods.values,
    required this.apiModelCreator,
    required this.resource,
  });

  /// POST /resource/
  /// If successful [response.data] is T
  Future<Response> create(T model, {allowRefresh = true}) async {
    try {
      Response response = await http.post(
        Uri.parse('${config.apiUrl}/$resource/'),
        body: model.toMap(),
        headers: headers(RestMethods.create),
      );
      HttpHelpers.checkError(response);
      var map = jsonDecode(response.body);
      model.loadMap(Map<String, dynamic>.from(map));
      return response;
    } on HttpNotAuthorized catch (e) {
      if (allowRefresh) {
        authApiService.refreshAccessToken();
        return create(model, allowRefresh: false);
      } else {
        throw e;
      }
    }
  }

  /// PUT /resource/
  /// If successful [respones.data] is T
  Future<Response> update(T model, {allowRefresh = true}) async {
    try {
      Response response = await http.put(
        Uri.parse('${config.apiUrl}/$resource/${model.pk}/'),
        body: model.toMap(),
        headers: headers(RestMethods.update),
      );
      HttpHelpers.checkError(response);
      var map = jsonDecode(response.body);
      model.loadMap(Map<String, dynamic>.from(map));
      return response;
    } on HttpNotAuthorized catch (e) {
      if (allowRefresh) {
        authApiService.refreshAccessToken();
        return update(model, allowRefresh: false);
      } else {
        throw e;
      }
    }
  }

  /// PATCH /resource/
  /// If successful [respones.data] is T
  Future<Response> patch(
    T model,
    Map<String, dynamic> fields, {
    allowRefresh = true,
  }) async {
    try {
      Response response = await http.patch(
        Uri.parse('${config.apiUrl}/$resource/${model.pk}/'),
        body: fields,
        headers: headers(RestMethods.patch),
      );
      HttpHelpers.checkError(response);
      var map = jsonDecode(response.body);
      model.loadMap(Map<String, dynamic>.from(map));
      return response;
    } on HttpNotAuthorized catch (e) {
      if (allowRefresh) {
        authApiService.refreshAccessToken();
        return patch(model, fields, allowRefresh: false);
      } else {
        throw e;
      }
    }
  }

  /// DELETE /resource/
  Future<Response> delete(T model, {allowRefresh = true}) async {
    try {
      Response response = await http.delete(
        Uri.parse('${config.apiUrl}/$resource/${model.pk}/'),
        headers: headers(RestMethods.delete),
      );
      HttpHelpers.checkError(response);
      return response;
    } on HttpNotAuthorized catch (e) {
      if (allowRefresh) {
        authApiService.refreshAccessToken();
        return delete(model, allowRefresh: false);
      } else {
        throw e;
      }
    }
  }

  /// GET /resource/:id
  /// If successful [response.data] is T
  Future<T?> get(dynamic id, {allowRefresh = true}) async {
    try {
      Response response = await http.get(
        Uri.parse('${config.apiUrl}/$resource/$id/'),
        headers: headers(RestMethods.get),
      );
      HttpHelpers.checkError(response);
      var map = Map<String, dynamic>.from(jsonDecode(response.body));
      return apiModelCreator(map);
    } on HttpNotAuthorized catch (e) {
      if (allowRefresh) {
        authApiService.refreshAccessToken();
        return get(id, allowRefresh: false);
      } else {
        throw e;
      }
    }
  }

  /// GET /resource/
  /// If successful [response.data] is List<T>
  Future<List<T>> list({bool allowRefresh = true}) async {
    try {
      Response response = await http.get(
        Uri.parse('${config.apiUrl}/$resource/'),
        headers: headers(RestMethods.list),
      );
      HttpHelpers.checkError(response);
      var data = jsonDecode(response.body);
      if (data is List) {
        return List<T>.from(data.map((m) => apiModelCreator(m)));
      }
      return <T>[];
    } on HttpNotAuthorized catch (e) {
      if (allowRefresh) {
        authApiService.refreshAccessToken();
        return list(allowRefresh: false);
      } else {
        throw e;
      }
    }
  }

  Map<String, String> headers(RestMethods method) {
    Map<String, String> headers = {};
    if (this.authenticatedActions.contains(method)) {
      headers.addAll({
        "Authorization": "JWT ${prefs.getString(AuthApiService.ACCESS_TOKEN_KEY)}",
      });
    }
    return headers;
  }
}
