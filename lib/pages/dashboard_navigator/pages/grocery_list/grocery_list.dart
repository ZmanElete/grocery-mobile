import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/grocery_list_manager.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/add_grocery_list/add_grocery_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/grocery_list/widgets/grocery_list_item.dart';
import 'package:grocery_genie/widget/model_list_view.dart';

class GroceryListPage extends StatefulWidget {
  static const String route = 'grocery-list';
  const GroceryListPage({Key? key}) : super(key: key);

  @override
  GroceryListPageState createState() => GroceryListPageState();
}

class GroceryListPageState extends State<GroceryListPage> {
  @override
  void initState() {
    GroceryListManager.instance.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModelListView<ItemList, GroceryListManager>(
      listManager: GroceryListManager.instance,
      floatingActionButton: floatingActionButton(context),
      itemBuilder: (context, list) => GroceryListItem(list: list)
    );
  }

  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add-fab',
      onPressed: () async {
        await Navigator.of(context).pushNamed(AddGroceryListPage.route);
        await GroceryListManager.instance.getList();
      },
      child: const Icon(
        Icons.add,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
