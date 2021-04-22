import 'package:flutter/material.dart';
import 'package:grocery_list/models/item.dart';

class AddGroceryListPage extends StatefulWidget {
  AddGroceryListPage({Key? key}) : super(key: key);

  @override
  _AddGroceryListPageState createState() => _AddGroceryListPageState();
}

class _AddGroceryListPageState extends State<AddGroceryListPage> {
  final titleController = TextEditingController();
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      appBar: AppBar(
        leading: BackButton(
          color: theme.textTheme.bodyText1!.color,
        ),
        backgroundColor: theme.canvasColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Create a List",
          style: theme.textTheme.subtitle1,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: titleController,
              )
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                child: Container(
                  color: Colors.red,
                  width: double.infinity,
                  height: double.infinity,
                  child:Text("heelo")
                ),
              );
            });
      },
      child: Icon(
        Icons.add,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
