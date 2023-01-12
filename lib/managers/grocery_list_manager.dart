import 'package:flutter/foundation.dart';
import 'package:grocery_list/models/item_list.dart';
import 'package:grocery_list/services/api/list_api_service.dart';

class GroceryListManager {
  static GroceryListManager instance = GroceryListManager();

  ValueNotifier<List<ItemList>?> lists = ValueNotifier(null);

  Future<void> getLists() async {
    lists.value = await ItemListApiService.instance.list();
  }

  Future<void> deleteList(ItemList list) async {
    await ItemListApiService.instance.delete(list);
    await getLists();
  }
}
