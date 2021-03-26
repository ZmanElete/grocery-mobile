import 'dart:convert';

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
  SharedPreferences prefs = ServiceLocator.prefs;
  Config config = Config.instance;

  String resource;
  List<RestMethods> authenticatedActions = RestMethods.values;
  ApiModel modelInstance;
  Function checkForRefresh = AuthApiService.instance.checkForRefresh;

  /// [resource] The name of the resource, used in URLS (ex `users`)
  /// [modelInstance] An instance of T, needed to create new instances with clone
  RestService(this.resource, this.modelInstance,
      {this.authenticatedActions = RestMethods.values});

  /// POST /resource/
  /// If successful [response.data] is T
  Future<Response> create(T model, {allowRefresh = true}) async {
    try {
      Response response = await http.post(
        Uri.parse('${config.apiUrl}/$resource/'),
        body: model.toMap(),
        headers: await headers(RestMethods.create),
      );
      checkError(response);
      var map = jsonDecode(response.body);
      model.loadMap(Map<String, dynamic>.from(map));
      return response;
    } catch (e) {
      if (allowRefresh && await checkForRefresh(e))
        return await create(model, allowRefresh: false);
      throw e;
    }
  }

  /// PUT /resource/
  /// If successful [respones.data] is T
  Future<Response> update(T model, {allowRefresh = true}) async {
    try {
      Response response = await http.put(
        Uri.parse('${config.apiUrl}/$resource/${model.pk}/'),
        body: model.toMap(),
        headers: await headers(RestMethods.update),
      );
      checkError(response);
      var map = jsonDecode(response.body);
      model.loadMap(Map<String, dynamic>.from(map));
      return response;
    } catch (e) {
      if (allowRefresh && await checkForRefresh(e))
        return await create(model, allowRefresh: false);
      throw e;
    }
  }

  /// PATCH /resource/
  /// If successful [respones.data] is T
  Future<Response> patch(T m, Map<String, dynamic> fields,
      {allowRefresh = true}) async {
    try {
      Response response = await http.patch(
        Uri.parse('${config.apiUrl}/$resource/${m.pk}/'),
        body: fields,
        headers: await headers(RestMethods.patch),
      );
      checkError(response);
      var map = jsonDecode(response.body);
      m.loadMap(Map<String, dynamic>.from(map));
      return response;
    } catch (e) {
      if (allowRefresh && await checkForRefresh(e))
        return await patch(m, fields, allowRefresh: false);
      throw e;
    }
  }

  /// DELETE /resource/
  Future<Response> delete(T model, {allowRefresh = true}) async {
    try {
      Response response = await http.delete(
        Uri.parse('${config.apiUrl}/$resource/${model.pk}/'),
        headers: await headers(RestMethods.delete),
      );
      checkError(response);
      return response;
    } catch (e) {
      if (allowRefresh && await checkForRefresh(e))
        return await delete(model, allowRefresh: false);
      throw e;
    }
  }

  /// GET /resource/:id
  /// If successful [response.data] is T
  Future<T?> get(dynamic id, {allowRefresh = true}) async {
    try {
      Response response = await http.get(
        Uri.parse('${config.apiUrl}/$resource/$id/'),
        headers: await headers(RestMethods.get),
      );
      checkError(response);
      var map = jsonDecode(response.body);
      return newModel(data: map);
    } catch (e) {
      if (allowRefresh && await checkForRefresh(e))
        return await get(id, allowRefresh: false);
      throw e;
    }
  }

  /// GET /resource/
  /// If successful [response.data] is List<T>
  Future<List<T>> list({bool allowRefresh = true}) async {
    try {
      Response response = await http.get(
        Uri.parse('${config.apiUrl}/$resource/'),
        headers: await headers(RestMethods.list),
      );
      checkError(response);
      var list = jsonDecode(response.body);
      return list.map((m) => newModel(data: m)).toList();
    } catch (e) {
      if (allowRefresh && await checkForRefresh(e))
        return await list(allowRefresh: false);
      throw e;
    }
  }

  Future<Map<String, String>> headers(RestMethods method) async {
    Map<String, String> headers = {};
    if (this.authenticatedActions.contains(method)) {
      headers.addAll({
        "Authorization": "Bearer ${(prefs).getString("access")}",
      });
    }
    return headers;
  }

  /// Uses modelInstance.clone hack to get around dart's lack of reflection
  T newModel({data: dynamic}) {
    var clone = modelInstance.clone();
    if (data != null) clone.loadMap(Map<String, dynamic>.from(data));
    return clone;
  }

  ///Impliment errors as needed
  void checkError(Response response) {
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
  abstract final Response response;
  const HttpErrorBase();
}

class HttpNotAuthorized extends HttpErrorBase {
  final Response response;
  const HttpNotAuthorized(this.response);
}

class HttpNotFound implements HttpErrorBase {
  final Response response;
  const HttpNotFound(this.response) : super();
}

class HttpTimeout implements HttpErrorBase {
  final Response response;
  const HttpTimeout(this.response) : super();
}

class HttpServerError implements HttpErrorBase {
  final Response response;
  const HttpServerError(this.response) : super();
}

class HttpBadRequest implements HttpErrorBase {
  final Response response;
  const HttpBadRequest(this.response) : super();
}

class HttpUnknownError implements HttpErrorBase {
  final Response response;
  const HttpUnknownError(this.response) : super();
}
