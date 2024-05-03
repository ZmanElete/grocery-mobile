import 'package:flutter/material.dart';
import 'package:guru_flutter_rest/django/api_model.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_flutter_rest/django/rest_methods.dart';

abstract class BaseListManager<T extends ApiModel, U extends GenericRestService<T>> {
  U get apiService;
  String get contentEmpty;

  ValueNotifier<List<T>?> list = ValueNotifier(null);

  Future<void> refresh();
}

abstract class ListManager<T extends ApiModel, U extends ListModelMixin<T>>
    extends BaseListManager<T, U> with ListMixin<T, U> {
  @override
  Future<void> refresh() => getList();
}

mixin ListMixin<T extends ApiModel, U extends ListModelMixin<T>> on BaseListManager<T, U> {
  Future<void> getList({String? search}) async {
    Map<String, dynamic>? queryParams;
    if (search != null) {
      queryParams = {
        'search': search,
      };
    }
    list.value = await apiService.list(queryParameters: queryParams);
    if (T is Comparable) {
      list.value!.sort();
    }
  }
}

mixin DeleteListManagerMixin<T extends ApiModel, U extends DeleteModelMixin<T>>
    on BaseListManager<T, U> {
  Future<void> deleteItem(T item) async {
    await apiService.delete(item);
    await refresh();
  }
}
