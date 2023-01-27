import 'package:grocery_genie/managers/list_manager.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/services/api/list_api_service.dart';

class GroceryListManager extends ListManager<ItemList, ItemListApiService> {
  static GroceryListManager instance = GroceryListManager();

  @override
  String get contentEmpty => "No Grocery Lists";

  @override
  ItemListApiService get apiService => ItemListApiService.instance;
}
