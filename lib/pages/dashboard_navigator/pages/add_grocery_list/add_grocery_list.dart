import 'package:flutter/material.dart';
import 'package:grocery_list/managers/session_manager.dart';
import 'package:grocery_list/models/item.dart';
import 'package:grocery_list/pages/dashboard_navigator/pages/add_grocery_list/widgets/add_item_dialog.dart';
import 'package:grocery_list/services/api/list_api_service.dart';

import '../../../../models/item_list.dart';

class AddGroceryListPage extends StatefulWidget {
  final ItemList? itemList;
  const AddGroceryListPage({this.itemList, Key? key}) : super(key: key);

  @override
  AddGroceryListPageState createState() => AddGroceryListPageState();
}

class AddGroceryListPageState extends State<AddGroceryListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Title is required';
                  }
                  return null;
                },
                onChanged: (value) => value.isNotEmpty ? _formKey.currentState?.validate() : null,
                controller: titleController,
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView(
                  children: [
                    for (Item item in items)
                      Card(
                        child: Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {},
                            ),
                            Expanded(
                              child: Text(item.toString()),
                            ),
                            IconButton(
                              onPressed: () => showEditItemDialog(item),
                              icon: const Icon(Icons.edit),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget floatingActionButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () => showEditItemDialog(),
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10,),
        FloatingActionButton(
          onPressed: () => _submit(),
          child: const Icon(
            Icons.check,
            size: 35,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void showEditItemDialog([Item? item]) async {
    var response = await showDialog(
      context: context,
      builder: (_) => EditItemDialog(
        item: item,
      ),
    );
    if (response is Item) {
      if (item == null) {
        items.add(response);
      }
      setState(() {});
    }
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      ItemList list;
      if (widget.itemList != null) {
        list = widget.itemList!;
        list.title = titleController.text;
        list.active = true;
        list.items = items;
        list = await ItemListApiService.instance.update(list);
      } else {
        list = ItemList(
          household: SessionManager.instance.user!.household.id!,
          title: titleController.text,
          active: true,
          items: items,
        );
        list = await ItemListApiService.instance.create(list);
      }
      if(mounted) Navigator.pop(context, list);
    }
  }
}
