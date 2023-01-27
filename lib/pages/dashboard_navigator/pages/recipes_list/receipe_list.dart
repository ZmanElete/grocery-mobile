import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/recipe_manager.dart';
import 'package:grocery_genie/models/recipe.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipe_detail/recipe_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipes_list/widgets/recipe_item.dart';
import 'package:grocery_genie/services/api/recipe_api_service.dart';
import 'package:grocery_genie/widget/model_list_view.dart';

class RecipeListPage extends StatefulWidget {
  static const String route = 'recipe-list';
  const RecipeListPage({Key? key}) : super(key: key);

  @override
  RecipeListPageState createState() => RecipeListPageState();
}

class RecipeListPageState extends State<RecipeListPage> {
  @override
  void initState() {
    RecipeListManager.instance.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModelListView<Recipe, RecipeListManager>(
      listManager: RecipeListManager.instance,
      floatingActionButton: floatingActionButton(context),
      itemBuilder: (context, recipe) => RecipeItem(recipe: recipe)
    );
  }

  Widget floatingActionButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'add-fab',
          onPressed: () async {
            final Recipe recipe = await RecipeApiService.instance.create(Recipe.empty());
            RecipeListManager.instance.getList();
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
