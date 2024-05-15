import 'package:grocery_genie/managers/list_manager.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/services/list_api_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class GroceryListManager extends ListManager<ItemList, ItemListApiService> with DeleteListManagerMixin {
  static StateKey<GroceryListManager> key = StateKey(() => GroceryListManager());

  @override
  String get contentEmpty => "No Grocery Lists";

  @override
  ItemListApiService get apiService => Repository.instance.read(ItemListApiService.key);
}
