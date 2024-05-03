import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/services/mixins/grocery_api_mixin.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';

class IngredientApiService extends ModelRestService<Ingredient> with GroceryApiMixin {
  static StateKey<IngredientApiService> key = StateKey(() => IngredientApiService());

  IngredientApiService() : super('ingredient');

  @override
  Ingredient modelFromMap(Map<String, dynamic> m) {
    return Ingredient.fromJson(m);
  }
}
