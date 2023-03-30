import 'package:grocery_genie/models/item.dart';
import 'package:grocery_genie/services/api/model_rest_service.dart';
import 'package:grocery_genie/services/api/rest_methods.dart';

class ItemApiService extends GenericRestService<Item> //
    with
        DeleteModelMixin,
        CreateModelMixin,
        UpdateModelMixin,
        PatchModelMixin,
        GetModelMixin {
  static ItemApiService get instance => _instance != null ? _instance! : ItemApiService();
  static ItemApiService? _instance;

  ItemApiService() : super('item');

  @override
  Item modelFromMap(Map<String, dynamic> m) => Item.fromMap(m);
}
