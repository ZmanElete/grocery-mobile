import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/services/api/model_rest_service.dart';

class ItemListApiService extends ModelRestService<ItemList> {
  static ItemListApiService get instance => _instance != null ? _instance! : ItemListApiService();
  static ItemListApiService? _instance;

  ItemListApiService() : super('list') {
    _instance = this;
  }

  @override
  ItemList modelFromMap(Map<String, dynamic> m) {
    return ItemList.fromMap(m);
  }
}
