import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grocery_list/services/service_locator.dart';

import '../../models/api_model.dart';
import 'model_rest_service.dart';
import 'rest_service.dart';

/// POST /resource/
// If successful [response.data] is T
mixin CreateModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// POST /resource/
  /// If successful [response.data] is T
  Future<T> create(T model) async {
    var dio = ServiceLocator.dio;
    try {
      Response response = await dio.post(
        '/$resource/',
        data: model.toMap(),
        options: options(RestMethods.create),
      );
      return modelFromMap(Map<String, dynamic>.from(response.data));
    } on DioError catch (e) {
      checkError(e.response);
      rethrow;
    }
  }
}

/// PUT /resource/
/// If successful [response.data] is T
mixin UpdateModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// PUT /resource/
  /// If successful [response.data] is T
  Future<T> update(T model) async {
    var dio = ServiceLocator.dio;
    try {
      Response response = await dio.put(
        '$resource/${model.pk}/',
        data: model.toMap(),
        options: options(RestMethods.update),
      );
      return modelFromMap(Map<String, dynamic>.from(response.data));
    } on DioError catch (e) {
      checkError(e.response);
      rethrow;
    }
  }
}

/// PATCH /resource/
/// If successful [response.data] is T
mixin PartialUpdateListModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// PATCH /resource/
  /// If successful [response.data] is T
  Future<T> partialUpdateList(List<Map<String, dynamic>> records) async {
    var dio = ServiceLocator.dio;
    try {
      Response response = await dio.patch(
        '/$resource/batch/',
        data: records,
        options: options(RestMethods.patch),
      );
      return modelFromMap(Map<String, dynamic>.from(response.data));
    } on DioError catch (e) {
      checkError(e.response);
      rethrow;
    }
  }
}

/// PATCH /resource/
/// If successful [response.data] is T
mixin PatchModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// PATCH /resource/
  /// If successful [response.data] is T
  Future<T> patch(T m, FormData fields, [bool loadOnResponse = true]) async {
    var dio = ServiceLocator.dio;
    try {
      Response response = await dio.patch(
        '/$resource/${m.pk}/',
        data: fields,
        options: options(RestMethods.patch),
      );
      if (loadOnResponse) {
        m = modelFromMap(Map<String, dynamic>.from(response.data));
      }
      return m;
    } on DioError catch (e) {
      checkError(e.response);
      rethrow;
    }
  }
}

/// DELETE /resource/
mixin DeleteModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// DELETE /resource/
  Future<void> delete(T model) async {
    var dio = ServiceLocator.dio;
    try {
      await dio.delete(
        '/$resource/${model.pk}/',
        options: options(RestMethods.delete),
      );
    } on DioError catch (e) {
      checkError(e.response);
      rethrow;
    }
  }
}

/// GET /resource/:id
/// If successful [response.data] is T
mixin GetModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// GET /resource/:id
  /// If successful [response.data] is T
  Future<T> get(dynamic id, {Map<String, dynamic>? params}) async {
    var dio = ServiceLocator.dio;
    try {
      Response response = await dio.get(
        '/$resource/$id/',
        options: options(RestMethods.get),
        queryParameters: params ?? {},
      );

      return modelFromMap(Map<String, dynamic>.from(response.data));
    } on DioError catch (e) {
      checkError(e.response);
      rethrow;
    }
  }
}

/// GET /resource/
/// If successful [response.data] is List<T>
mixin ListModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// GET /resource/
  /// If successful [response.data] is List<T>
  Future<List<T>> list({Map<String, dynamic>? queryParameters}) async {
    var dio = ServiceLocator.dio;
    try {
      Response response = await dio.get(
        '/$resource/',
        options: options(RestMethods.list),
        queryParameters: queryParameters,
      );

      if (response.data is Map) {
        // We lose pagination data, but we don't really need it with page pagination
        // (other than we don't know if there is a next page):P
        // Just doing this to get things to work. We can rework later if we need.
        response.data = response.data['results'];
      }

      return [for (var n in response.data) modelFromMap(n)];
    } on DioError catch (e) {
      checkError(e.response);
      rethrow;
    }
  }
}
