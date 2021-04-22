import 'package:flutter/material.dart';

import 'package:grocery_list/models/item_list.dart';

class GroceryListItem extends StatefulWidget {
  final ItemList list;
  final bool isDetail;
  GroceryListItem({
    Key? key,
    required this.list,
    this.isDetail = false,
  }) : super(key: key);

  @override
  _GroceryListItemState createState() => _GroceryListItemState(list, isDetail);
}

class _GroceryListItemState extends State<GroceryListItem> {
  final ItemList list;
  final bool isDetail;
  _GroceryListItemState(this.list, this.isDetail) : super();

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
