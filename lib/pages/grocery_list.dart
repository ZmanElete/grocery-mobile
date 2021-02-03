import 'package:flutter/material.dart';
import 'package:grocery_list/widget/scaffold.dart';

class GroceryListPage extends StatefulWidget {
  static const route = 'grocery_list';
  GroceryListPage({Key key}) : super(key: key);

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackButton: false,
      showBottomNav: true,
      body: Builder(
        builder: (context) => Container(
          child: Column(
            children: [
              RaisedButton(
                child: Text('Heyyo'),
                onPressed: () => Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Yo'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
