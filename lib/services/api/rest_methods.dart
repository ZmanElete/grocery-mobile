import 'package:dio/dio.dart';
import 'package:grocery_genie/services/service_locator.dart';

import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/services/api/model_rest_service.dart';
import 'package:grocery_genie/services/api/rest_service.dart';

/// POST /resource/
mixin CreateModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// POST /resource/
  Future<T> create(T model) async {
    final dio = ServiceLocator.dio;
    try {
      final Response response = await dio.post(
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
mixin UpdateModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// PUT /resource/
  Future<T> update(T model) async {
    final dio = ServiceLocator.dio;
    try {
      final Response response = await dio.put(
        '/$resource/${model.pk}/',
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
mixin PartialUpdateListModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// PATCH /resource/
  Future<T> partialUpdateList(List<Map<String, dynamic>> records) async {
    final dio = ServiceLocator.dio;
    try {
      final Response response = await dio.patch(
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
mixin PatchModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// PATCH /resource/
  Future<T> patch(T m, FormData fields, {bool loadOnResponse = true}) async {
    final dio = ServiceLocator.dio;
    try {
      final Response response = await dio.patch(
        '/$resource/${m.pk}/',
        data: fields,
        options: options(RestMethods.patch),
      );
      if (loadOnResponse) {
        m.loadMap(Map<String, dynamic>.from(response.data));
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
    final dio = ServiceLocator.dio;
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
mixin GetModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// GET /resource/:id
  Future<T> get(id, {Map<String, dynamic>? params}) async {
    final dio = ServiceLocator.dio;
    try {
      final Response response = await dio.get(
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
mixin ListModelMixin<T extends ApiModel> on GenericRestService<T> {
  /// GET /resource/
  Future<List<T>> list([Map<String, dynamic>? queryParameters]) async {
    final dio = ServiceLocator.dio;
    try {
      final options = this.options(RestMethods.list);
      final Response response = await dio.get(
        '/$resource/',
        options: options,
        queryParameters: queryParameters,
      );

      final data = response.data;

      if (data is Map<String, dynamic>) {
        // We lose pagination data, but we don't really need it with page pagination
        // (other than we don't know if there is a next page):P
        // Just doing this to get things to work. We can rework later if we need.
        response.data = data['results'];
      }

      return [for (var n in response.data) modelFromMap(n)];
    } on DioError catch (e) {
      checkError(e.response);
      rethrow;
    }
  }
}
