import 'package:flutter/material.dart';
import 'package:grocery_list/pages/dashboard_navigator/pages/add_grocery_list/add_grocery_list.dart';

import '/services/api/list_api_service.dart';
import '/models/item_list.dart';
import '/pages/dashboard_navigator/pages/grocery_list/widgets/grocery_list_item.dart';

class GroceryListPage extends StatefulWidget {
  static const String route = 'grocery-list';
  const GroceryListPage({Key? key}) : super(key: key);

  @override
  GroceryListPageState createState() => GroceryListPageState();
}

class GroceryListPageState extends State<GroceryListPage> {
  final listService = ItemListApiService.instance;

  bool initializing = true;
  List<ItemList> lists = [];

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    try {
      lists = await listService.list();
    } finally {
      initializing = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: Builder(builder: (context) {
        Widget content;
        if (initializing) {
          content = const Center(child: CircularProgressIndicator());
        } else if (lists.isEmpty) {
          content = const Center(child: Text("Looks like you don't have any Lists"));
        } else {
          content = ListView.builder(
            itemCount: lists.length,
            itemBuilder: (_, index) {
              var list = lists[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Hero(
                  tag: '${list.id}GroceryList',
                  child: GroceryListItem(
                    list: list,
                  ),
                ),
              );
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
