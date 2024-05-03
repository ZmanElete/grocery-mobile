import 'package:grocery_genie/models/item.dart';
import 'package:grocery_genie/services/mixins/grocery_api_mixin.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_flutter_rest/django/rest_methods.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';

class ItemApiService extends GenericRestService<Item> //
    with
        DeleteModelMixin,
        CreateModelMixin,
        UpdateModelMixin,
        PatchModelMixin,
        GetModelMixin,
        GroceryApiMixin {
  static StateKey<ItemApiService> key = StateKey(() => ItemApiService());

  ItemApiService() : super('item');

  @override
  Item modelFromMap(Map<String, dynamic> m) => Item.fromJson(m);
}
