// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_genie/managers/recipe_manager.dart';
import 'package:grocery_genie/models/recipe.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipe_detail/recipe_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/recipes_list/widgets/recipe_item.dart';
import 'package:grocery_genie/router.dart';
import 'package:grocery_genie/services/recipe_api_service.dart';
import 'package:grocery_genie/widget/model_list_view.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class RecipeListPage extends StatefulWidget {
  static const AppRoute route = AppRoute.recipeListPage;
  const RecipeListPage({Key? key}) : super(key: key);

  @override
  RecipeListPageState createState() => RecipeListPageState();
}

class RecipeListPageState extends State<RecipeListPage> {
  @override
  void initState() {
    Repository.instance.read(RecipeListManager.key).getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModelListView<Recipe, RecipeListManager>(
        listManager: Repository.instance.read(RecipeListManager.key),
        floatingActionButton: floatingActionButton(context),
        itemBuilder: (context, recipe) => RecipeItem(recipe: recipe));
  }

  Widget floatingActionButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'add-fab',
          onPressed: () async {
            final Recipe recipe =
                await Repository.instance.read(RecipeApiService.key).create(Recipe.empty());
            Repository.instance.read(RecipeListManager.key).getList();
            if (mounted) {
              await GoRouter.of(context).pushNamed(
                RecipeDetailPage.route.name,
              );
              if (mounted) setState(() {});
            }
          },
          child: const Icon(
            Icons.add,
            size: 35,
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
