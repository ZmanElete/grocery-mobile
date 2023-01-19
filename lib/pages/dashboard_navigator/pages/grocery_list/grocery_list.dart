import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/grocery_list_manager.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/add_grocery_list/add_grocery_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/grocery_list/widgets/grocery_list_item.dart';

class GroceryListPage extends StatefulWidget {
  static const String route = 'grocery-list';
  const GroceryListPage({Key? key}) : super(key: key);

  @override
  GroceryListPageState createState() => GroceryListPageState();
}

class GroceryListPageState extends State<GroceryListPage> {

  @override
  void initState() {
    GroceryListManager.instance.getLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: ValueListenableBuilder<List<ItemList>?>(
        valueListenable: GroceryListManager.instance.lists,
        builder: (context, lists, _) {
        Widget content;
        if (lists == null) {
          content = const Center(child: CircularProgressIndicator());
        } else if (lists.isEmpty) {
          content = const Center(child: Text("Looks like you don't have any Lists"));
        } else {
          content = ListView.separated(
            itemCount: lists.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return GroceryListItem(list: lists[index]);
            },
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: content,
        );
      }),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      heroTag: 'add-fab',
      onPressed: () {
        Navigator.of(context).pushNamed(AddGroceryListPage.route);
      },
      child: const Icon(
        Icons.add,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
