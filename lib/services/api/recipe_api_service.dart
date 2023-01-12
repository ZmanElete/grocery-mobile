import 'package:grocery_list/models/recipe.dart';
import 'package:grocery_list/services/api/rest_methods.dart';
import 'package:grocery_list/services/api/model_rest_service.dart';

class RecipeApiService extends GenericRestService<Recipe>
    with
        ListModelMixin,
        DeleteModelMixin,
        CreateModelMixin,
        UpdateModelMixin,
        PatchModelMixin,
        GetModelMixin {

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
