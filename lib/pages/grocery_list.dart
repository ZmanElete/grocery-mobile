import 'package:flutter/material.dart';

class GroceryListPage extends StatefulWidget {
  GroceryListPage({Key key}) : super(key: key);

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  @override
  Widget build(BuildContext context) {
    Scaffold.of(context);
    return Container(
      child: Column(
        children: [
          RaisedButton(
            child: Text('Heyyo'),
            onPressed: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Yo'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
