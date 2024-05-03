import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/services/mixins/grocery_api_mixin.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';

class ItemListApiService extends ModelRestService<ItemList> with GroceryApiMixin {  
  static StateKey<ItemListApiService> key = StateKey(() => ItemListApiService());


  ItemListApiService() : super('list');

  @override
  ItemList modelFromMap(Map<String, dynamic> m) {
    return ItemList.fromJson(m);
  }
}
