import '../../models/item_list.dart';
import 'rest_service.dart';

class ItemListApiService extends RestService<ItemList> {
  static ItemListApiService get instance =>
      _instance != null ? _instance! : _instance = ItemListApiService();
  static ItemListApiService? _instance;

  ItemListApiService()
      : super(
          resource: 'list',
          apiModelCreator: (map) => ItemList.fromMap(map),
        ) {
    _instance = this;
  }
}
