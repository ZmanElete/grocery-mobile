import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/managers/list_manager.dart';
import 'package:grocery_genie/services/ingredient_api_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class IngredientListManager extends ListManager<Ingredient, IngredientApiService> with DeleteListManagerMixin {
  static StateKey<IngredientListManager> key = StateKey(() => IngredientListManager());

  @override
  String get contentEmpty => "No Ingredients";

  @override
  IngredientApiService get apiService => Repository.instance.read(IngredientApiService.key);
}
