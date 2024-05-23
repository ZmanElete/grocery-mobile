import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_genie/managers/grocery_list_manager.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/grocery_list/widgets/grocery_list_item.dart';
import 'package:grocery_genie/router.dart';
import 'package:grocery_genie/widget/model_list_view.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class GroceryListPage extends StatefulWidget {
  static const AppRoute route = AppRoute.groceryListPage;
  const GroceryListPage({Key? key}) : super(key: key);

  @override
  GroceryListPageState createState() => GroceryListPageState();
}

class GroceryListPageState extends State<GroceryListPage> {
  @override
  void initState() {
    Repository.instance.read(GroceryListManager.key).getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModelListView<ItemList, GroceryListManager>(
      listManager: Repository.instance.read(GroceryListManager.key),
      floatingActionButton: floatingActionButton(context),
      itemBuilder: (context, list) => GroceryListItem(list: list),
    );
  }

  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add-fab',
      onPressed: () async {
        await GoRouter.of(context).pushNamed(
          AppRoute.groceryListDetail.name,
          pathParameters: {"id": "new"},
        );
        await Repository.instance.read(GroceryListManager.key).getList();
      },
      child: const Icon(
        Icons.add,
        size: 35,
      ),
    );
  }
}
