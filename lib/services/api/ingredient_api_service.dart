import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/services/api/model_rest_service.dart';

class IngredientApiService extends ModelRestService<Ingredient> {
  static IngredientApiService get instance => _instance != null //
      ? _instance!
      : IngredientApiService();
  static IngredientApiService? _instance;

  IngredientApiService() : super('ingredient') {
    _instance = this;
  }

  @override
  Ingredient modelFromMap(Map<String, dynamic> m) {
    return Ingredient.fromMap(m);
  }
}
