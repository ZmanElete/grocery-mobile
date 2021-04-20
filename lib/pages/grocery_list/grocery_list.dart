import 'package:flutter/material.dart';
import 'package:grocery_list/models/item_list.dart';
import 'package:grocery_list/pages/grocery_list/widgets/grocery_list_item.dart';
import 'package:grocery_list/services/api/list_api_service.dart';

class GroceryListPage extends StatefulWidget {
  GroceryListPage({Key? key}) : super(key: key);

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
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
    var screenWidth = MediaQuery.of(context).size.width;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: initializing
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : lists.isEmpty
              ? Card()
              : ListView.builder(
                  itemCount: lists.length,
                  itemBuilder: (_, index) {
                    var list = lists[index];
                    return Hero(
                      tag: '${list.id}GroceryList',
                      child: GroceryListItem(
                        list: list,
                        isDetail: false,
                      ),
                    );
                  },
                ),
    );
  }
}
