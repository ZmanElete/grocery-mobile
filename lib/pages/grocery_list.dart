import 'package:flutter/material.dart';

class GroceryListPage extends StatefulWidget {
  GroceryListPage({Key? key}) : super(key: key);

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => [
          Card(
            elevation: 5,
            color: Colors.yellow,
            child: Align(
              heightFactor: 0,
              child: Container(
                height: 100,
                color: Colors.purple,
              ),
            ),
          ),
          Card(
            elevation: 5,
            child: Align(
              heightFactor: 5,
              child: Container(
                height: 100,
                color: Colors.red,
              ),
            ),
          ),
        ][index],
      ),
    );
  }
}
