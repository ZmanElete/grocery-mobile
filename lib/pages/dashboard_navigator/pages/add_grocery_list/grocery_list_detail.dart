import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/session_manager.dart';
import 'package:grocery_genie/models/item.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/add_grocery_list/widgets/add_item_dialog.dart';
import 'package:grocery_genie/router.dart';
import 'package:grocery_genie/services/item_api_service.dart';
import 'package:grocery_genie/services/list_api_service.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class GroceryDetailListPage extends StatefulWidget {
  static const AppRoute route = AppRoute.groceryListDetail;
  final int? id;
  final ItemList? itemList;
  const GroceryDetailListPage({
    this.id,
    this.itemList,
    Key? key,
  }) : super(key: key);

  @override
  GroceryDetailListPageState createState() => GroceryDetailListPageState();
}

class GroceryDetailListPageState extends State<GroceryDetailListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  ItemList? _itemList;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    if (widget.itemList != null) {
      _itemList = widget.itemList;
    } else if (widget.id != null) {
      _itemList = await Repository.instance.read(ItemListApiService.key).get(widget.id!);
      setState(() {});
    } else {
      _itemList = ItemList(
        household: Repository.instance.read(SessionManager.userKey)!.household.id!,
        items: [],
        title: '',
      );
    }
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
      body: switch (_itemList) {
        null => Center(child: CircularProgressIndicator()),
        _ => Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: _titleController,
                    onChanged: (value) =>
                        value.isNotEmpty ? _formKey.currentState?.validate() : null,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Title is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Title",
                      // prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (Item item in _itemList!.items) ...[
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
                                Repository.instance
                                    .read(ItemApiService.key)
                                    .patch(item, data: fields);
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
            ),
          ),
      },
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
        _itemList!.items.add(response);
      }
      setState(() {});
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      ItemList list;
      if (widget.id != null) {
        list = widget.itemList!
          ..title = _titleController.text
          ..active = true;
        list = await Repository.instance.read(ItemListApiService.key).update(list);
      } else {
        list = widget.itemList!
          ..title = _titleController.text
          ..active = true;
        list = await Repository.instance.read(ItemListApiService.key).create(list);
      }
      if (mounted) Navigator.pop(context, list);
    }
  }
}
