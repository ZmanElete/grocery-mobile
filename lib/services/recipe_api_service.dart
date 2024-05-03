import 'package:grocery_genie/models/recipe.dart';
import 'package:grocery_genie/services/mixins/grocery_api_mixin.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';

class RecipeApiService extends ModelRestService<Recipe> with GroceryApiMixin {
  static StateKey<RecipeApiService> key = StateKey(() => RecipeApiService());

  RecipeApiService() : super('recipe');

  @override
  Recipe modelFromMap(Map<String, dynamic> m) {
    return Recipe.fromJson(m);
  }
}
