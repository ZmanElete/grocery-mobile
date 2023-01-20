import 'package:flutter/material.dart';
import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/services/api/ingredient_api_service.dart';

class IngredientManager {
  static IngredientManager instance = IngredientManager();

  ValueNotifier<List<Ingredient>?> lists = ValueNotifier(null);

  Future<void> getLists() async {
    lists.value = await IngredientApiService.instance.list();
  }

  Future<void> deleteList(Ingredient list) async {
    await IngredientApiService.instance.delete(list);
    await getLists();
  }

}
