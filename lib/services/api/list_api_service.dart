import '../../models/item_list.dart';
import 'rest_service.dart';

class ItemListApiService extends RestService<ItemList> {
  ItemListApiService() : super('list', ItemList());
}
