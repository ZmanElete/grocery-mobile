import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_list/models/api_model.dart';

import '../hive_boxes.dart';
import 'auth_api_service.dart';

enum RestMethods {
  get,
  list,
  create,
  update,
  patch,
  delete,
}

abstract class RestService<T extends ApiModel> {
  final Dio dio = GetIt.instance.get<Dio>();

  String resource;
  List<RestMethods> authenticatedActions = RestMethods.values;
  ApiModel modelInstance;
  Function checkForRefresh = GetIt.instance.get<AuthApiService>().checkForRefresh;

  /// [resource] The name of the resource, used in URLS (ex `users`)
  /// [modelInstance] An instance of T, needed to create new instances with clone
  RestService(this.resource, this.modelInstance, {this.authenticatedActions = RestMethods.values});

  /// POST /resource/
  /// If successful [response.data] is T
  Future<Response> create(T model) async {
    try {
      Response response = await dio.post(
        '/$resource/',
        data: model.toMap(),
        options: options(RestMethods.create),
      );
      model.loadMap(Map<String, dynamic>.from(response.data));
      return response;
    } on DioError catch (e) {
      if (await checkForRefresh(e)) return await create(model);
      return e.response;
    }
  }

  /// PUT /resource/
  /// If successful [respones.data] is T
  Future<Response> update(T model) async {
    try {
      Response response = await dio.put(
        '$resource/${model.pk}/',
        data: model.toMap(),
        options: options(RestMethods.update),
      );
      model.loadMap(Map<String, dynamic>.from(response.data));
      return response;
    } on DioError catch (e) {
      if (await checkForRefresh(e)) return await update(model);
      return e.response;
    }
  }

  /// PATCH /resource/
  /// If successful [respones.data] is T
  Future<Response> patch(T m, Map<String, dynamic> fields) async {
    try {
      Response response = await dio.patch(
        '/$resource/${m.pk}/',
        data: fields,
        options: options(RestMethods.patch),
      );
      m.loadMap(Map<String, dynamic>.from(response.data));
      return response;
    } on DioError catch (e) {
      if (await checkForRefresh(e)) return await patch(m, fields);
      return e.response;
    }
  }

  /// DELETE /resource/
  Future<Response> delete(T model) async {
    try {
      Response response = await dio.delete(
        '/$resource/${model.pk}/',
        options: options(RestMethods.delete),
      );
      return response;
    } on DioError catch (e) {
      if (await checkForRefresh(e)) return await delete(model);
      return e.response;
    }
  }

  /// GET /resource/:id
  /// If successful [response.data] is T
  Future<Response> get(dynamic id) async {
    try {
      Response response = await dio.get(
        '/$resource/$id/',
        options: options(RestMethods.get),
      );
      response.data = newModel(data: response.data);
      return response;
    } on DioError catch (e) {
      if (await checkForRefresh(e)) return await get(id);
      return e.response;
    }
  }

  /// GET /resource/
  /// If successful [response.data] is List<T>
  Future<Response> list({Map<String, dynamic> queryParameters}) async {
    try {
      Response response =
          await dio.get('/$resource/', options: options(RestMethods.list), queryParameters: queryParameters);
      response.data = response.data.map((m) => newModel(data: m)).toList();
      return response;
    } on DioError catch (e) {
      if (await checkForRefresh(e)) return await list();
      return e.response;
    }
  }

  Options options(RestMethods method) {
    var options = Options();
    if (this.authenticatedActions.contains(method)) {
      options.headers = {
        "Authorization": "Bearer " + GetIt.instance.get<HiveBoxes>().settings.get("access"),
      };
    }
    return options;
  }

  /// Uses modelInstance.clone hack to get around dart's lack of reflection
  T newModel({data: dynamic}) {
    var clone = modelInstance.clone();
    if (data != null) clone.loadMap(Map<String, dynamic>.from(data));
    return clone;
  }
}
