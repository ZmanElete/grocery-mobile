import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/session_manager.dart';
import 'package:grocery_genie/models/item.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/add_grocery_list/widgets/add_item_dialog.dart';
import 'package:grocery_genie/services/api/item_api_service.dart';
import 'package:grocery_genie/services/api/list_api_service.dart';

class AddGroceryListPageArguments {
  final ItemList? itemList;
  const AddGroceryListPageArguments(this.itemList);
}

class AddGroceryListPage extends StatefulWidget {
  static const String route = 'add-grocery-list-page';
  final ItemList? itemList;
  const AddGroceryListPage({this.itemList, Key? key}) : super(key: key);

  @override
  AddGroceryListPageState createState() => AddGroceryListPageState();
}

class AddGroceryListPageState extends State<AddGroceryListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    items.addAll(widget.itemList?.items ?? []);
    _titleController = TextEditingController(text: widget.itemList?.title ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      appBar: AppBar(
        leading: BackButton(
          color: theme.textTheme.bodyMedium!.color,
        ),
        backgroundColor: theme.canvasColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Create a List",
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                onChanged: (value) => value.isNotEmpty ? _formKey.currentState?.validate() : null,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Title is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Title",
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (Item item in items) ...[
                      Row(
                        children: [
                          StatefulBuilder(builder: (context, setState) {
                            return Checkbox(
                              value: item.checked,
                              onChanged: (value) async {
                                final fields = FormData.fromMap({"checked": !item.checked});
                                item.checked = !item.checked;
                                setState(() {});
                                if (item.id != null) {
                                  ItemApiService.instance.patch(item, fields);
                                }
                              },
                            );
                          }),
                          Expanded(
                            child: Text(item.toString()),
                          ),
                          IconButton(
                            onPressed: () => showEditItemDialog(item),
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                      // const Divider(),
                    ]
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
          heroTag: 'add-fab',
          onPressed: showEditItemDialog,
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          heroTag: 'confirm-fab',
          onPressed: _submit,
          child: const Icon(
            Icons.check,
            size: 35,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> showEditItemDialog([Item? item]) async {
    final response = await showDialog(
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

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      ItemList list;
      if (widget.itemList != null) {
        list = widget.itemList!
        ..title = _titleController.text
        ..active = true
        ..items = items;
        list = await ItemListApiService.instance.update(list);
      } else {
        list = ItemList(
          household: SessionManager.instance.user!.household.id!,
          title: _titleController.text,
          active: true,
          items: items,
        );
        list = await ItemListApiService.instance.create(list);
      }
      if (mounted) Navigator.pop(context, list);
    }
  }
}
