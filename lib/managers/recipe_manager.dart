import 'package:flutter/material.dart';
import 'package:grocery_list/models/recipe.dart';
import 'package:grocery_list/services/api/recipe_api_service.dart';

class RecipeManager {
  static RecipeManager instance = RecipeManager();

  final ValueNotifier<List<Recipe>?> recipes = ValueNotifier<List<Recipe>?>(null);

  Future<void> getRecipes() async {
    recipes.value = await RecipeApiService.instance.list();
  }

  Future<void> deleteList(Recipe recipe) async {
    await RecipeApiService.instance.delete(recipe);
    await getRecipes();
  }
}
