import 'package:flutter/material.dart';
import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/services/api/model_rest_service.dart';

abstract class ListManager<T extends ApiModel, U extends ModelRestService<T>> {
  U get apiService;
  String get contentEmpty;

  ValueNotifier<List<T>?> list = ValueNotifier(null);

  Future<void> getList() async {
    list.value = await apiService.list();
  }

  Future<void> deleteItem(T item) async {
    await apiService.delete(item);
    await getList();
  }
}
