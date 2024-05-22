import 'package:flutter/material.dart';
import 'package:grocery_genie/utils/logging.dart';
import 'package:guru_flutter_rest/django/api_model.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_flutter_rest/django/rest_methods.dart';
import 'package:guru_provider/guru_provider/keys/family_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';

abstract class BaseListManager<T extends ApiModel, U extends GenericRestService<T>> with Logging {
  U get apiService;
  String get contentEmpty;

  ValueNotifier<List<T>?> list = ValueNotifier(null);

  Future<void> refresh();
}

abstract class ListManager<T extends ApiModel, U extends ListModelMixin<T>>
    extends BaseListManager<T, U> with ListMixin<T, U> {
  late FamilyKey<AsyncSnapshot<List<T>>, String?> listKey = FamilyKey((search) {
    refresh(search: search);
    return AsyncSnapshot<List<T>>.waiting();
  });

  Future<void> refresh({String? search}) async {
    final _future = getList(search: search);
    _future.then<void>((List<T> data) {
      Repository.instance.set(
        listKey(search),
        AsyncSnapshot<List<T>>.withData(ConnectionState.done, data),
      );
    }, onError: (Object error, StackTrace stackTrace) {
      log('Error In List Manager ${runtimeType}: $error',
          stackTrace: stackTrace, level: LogLevel.severe);
      Repository.instance.set(
        listKey(search),
        AsyncSnapshot<T>.withError(ConnectionState.done, error, stackTrace),
      );

      assert(() {
        if (FutureBuilder.debugRethrowError) {
          Future<Object>.error(error, stackTrace);
        }
        return true;
      }());
    });

    await _future;
  }
}

mixin ListMixin<T extends ApiModel, U extends ListModelMixin<T>> on BaseListManager<T, U> {
  Future<List<T>> getList({String? search}) async {
    Map<String, dynamic>? queryParams;
    if (search != null) {
      queryParams = {
        'search': search,
      };
    }
    final list = await apiService.list(queryParameters: queryParams);
    if (T is Comparable) {
      list.sort();
    }
    return list;
  }
}

mixin DeleteListManagerMixin<T extends ApiModel, U extends DeleteModelMixin<T>>
    on BaseListManager<T, U> {
  Future<void> deleteItem(T item) async {
    await apiService.delete(item.pk);
    await refresh();
  }
}
