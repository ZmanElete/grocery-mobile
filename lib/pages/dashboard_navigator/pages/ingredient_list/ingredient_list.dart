import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_genie/managers/ingredient_manager.dart';
import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/ingredient_detail/ingredient_detail.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/ingredient_list/widgets/ingredient_item.dart';
import 'package:grocery_genie/router.dart';
import 'package:grocery_genie/widget/model_list_view.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class IngredientListPage extends StatefulWidget {
  static const AppRoute route = AppRoute.ingredientListPage;
  const IngredientListPage({Key? key}) : super(key: key);

  @override
  IngredientListPageState createState() => IngredientListPageState();
}

class IngredientListPageState extends State<IngredientListPage> {
  @override
  void initState() {
    Repository.instance.read(IngredientListManager.key).getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModelListView<Ingredient, IngredientListManager>(
      listManager: Repository.instance.read(IngredientListManager.key),
      floatingActionButton: floatingActionButton(context),
      itemBuilder: (context, ingredient) => IngredientItem(ingredient: ingredient),
    );
  }

  Widget floatingActionButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'add-fab',
          onPressed: () async {
            await GoRouter.of(context).pushNamed(
              IngredientDetailPage.route.name,
            );
            if (mounted) {
              await Repository.instance.read(IngredientListManager.key).getList();
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
