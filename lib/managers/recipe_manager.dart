import 'package:grocery_genie/managers/list_manager.dart';
import 'package:grocery_genie/models/recipe.dart';
import 'package:grocery_genie/services/api/recipe_api_service.dart';

class RecipeListManager extends ListManager<Recipe, RecipeApiService> with DeleteListManagerMixin {
  static RecipeListManager instance = RecipeListManager();

  @override
  String get contentEmpty => "No Recipes";

  @override
  RecipeApiService get apiService => RecipeApiService.instance;
}
