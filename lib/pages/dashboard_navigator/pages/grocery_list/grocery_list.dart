import 'package:flutter/material.dart';



import '/services/api/list_api_service.dart';
import '/models/item_list.dart';
import '/pages/dashboard_navigator/pages/grocery_list/widgets/grocery_list_item.dart';
import '../../routes.dart';

class GroceryListPage extends StatefulWidget {
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
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: initializing
            ? Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
            : lists.isEmpty
                ? Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: screenSize.width * .9,
                      height: screenSize.height * .2,
                      child: const Card(
                        child: Center(
                          child: Text("Looks like you don't have any Lists"),
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: lists.length,
                    itemBuilder: (_, index) {
                      var list = lists[index];
                      return Hero(
                        tag: '${list.id}GroceryList',
                        child: GroceryListItem(
                          list: list,
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(DashboardRoutes.ADD_GROCERY_LIST);
      },
      child: const Icon(
        Icons.add,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
