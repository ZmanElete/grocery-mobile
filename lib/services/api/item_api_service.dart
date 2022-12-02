import '/models/item.dart';
import 'model_rest_service.dart';
import 'rest_methods.dart';

class ItemApiService //
    extends GenericRestService<Item> //
    with
        UpdateModelMixin,
        PatchModelMixin {
  static ItemApiService get instance => _instance != null ? _instance! : ItemApiService();
  static ItemApiService? _instance;

  ItemApiService() : super('item');

  @override
  Item modelFromMap(Map<String, dynamic> m) => Item.fromMap(m);
}
