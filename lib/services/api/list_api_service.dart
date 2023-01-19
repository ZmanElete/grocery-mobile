import 'package:grocery_genie/services/api/rest_methods.dart';

import '../../models/item_list.dart';
import 'model_rest_service.dart';

class ItemListApiService extends GenericRestService<ItemList>
    with
        ListModelMixin,
        DeleteModelMixin,
        CreateModelMixin,
        UpdateModelMixin,
        PartialUpdateListModelMixin,
        GetModelMixin {

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
