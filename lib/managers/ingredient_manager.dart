import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/services/api/ingredient_api_service.dart';

import 'list_manager.dart';

class IngredientListManager extends ListManager<Ingredient, IngredientApiService> with DeleteListManagerMixin {
  static IngredientListManager instance = IngredientListManager();

  @override
  String get contentEmpty => "No Ingredients";

  @override
  IngredientApiService get apiService => IngredientApiService.instance;
}
