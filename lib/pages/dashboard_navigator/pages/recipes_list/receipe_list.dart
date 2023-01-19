import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/recipe_manager.dart';
import 'package:grocery_genie/models/recipe.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipe_detail/recipe_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipes_list/widgets/recipe_item.dart';
import 'package:grocery_genie/services/api/recipe_api_service.dart';

class RecipeListPage extends StatefulWidget {
  static const String route = 'recipe-list';
  const RecipeListPage({Key? key}) : super(key: key);

  @override
  RecipeListPageState createState() => RecipeListPageState();
}

class RecipeListPageState extends State<RecipeListPage> {
  @override
  void initState() {
    RecipeManager.instance.getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Recipe>?>(
      valueListenable: RecipeManager.instance.recipes,
      builder: (context, recipes, _) {
        if (recipes == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (recipes.isEmpty) {
          return const Center(
            child: Text('No Recipes'),
          );
        }
        return Scaffold(
          floatingActionButton: floatingActionButton(),
          body: ListView.separated(
            itemCount: recipes.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return RecipeItem(recipe: recipes[index]);
            },
          ),
        );
      },
    );
  }

  Widget floatingActionButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'add-fab',
          onPressed: () async {
            final Recipe recipe = await RecipeApiService.instance.create(Recipe.empty());
            RecipeManager.instance.getRecipes();
            if (mounted) {
              await Navigator.of(context).pushNamed(
                RecipeDetailPage.route,
                arguments: RecipeDetailPageArgs(
                  recipe: recipe,
                  editing: true,
                ),
              );
              if (mounted) setState(() {});
            }
          },
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        // FloatingActionButton(
        //   heroTag: 'confirm-fab',
        //   onPressed: () {},
        //   child: const Icon(
        //     Icons.check,
        //     size: 35,
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }
}
