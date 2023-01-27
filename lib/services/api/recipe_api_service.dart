import 'package:grocery_genie/models/recipe.dart';
import 'package:grocery_genie/services/api/model_rest_service.dart';

class RecipeApiService extends ModelRestService<Recipe> {
  static RecipeApiService get instance => _instance != null ? _instance! : RecipeApiService();
  static RecipeApiService? _instance;

  RecipeApiService() : super('recipe') {
    _instance = this;
  }

  @override
  Recipe modelFromMap(Map<String, dynamic> m) {
    return Recipe.fromMap(m);
  }
}
