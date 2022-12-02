import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:grocery_list/models/item_list.dart';
import 'package:grocery_list/pages/dashboard_navigator/pages/add_grocery_list/add_grocery_list.dart';
import 'package:grocery_list/services/api/item_api_service.dart';

class GroceryListItem extends StatefulWidget {
  final ItemList list;
  const GroceryListItem({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  GroceryListItemState createState() => GroceryListItemState();
}

class GroceryListItemState extends State<GroceryListItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onLongPress: _showMenu,
        onTap: () => setState(() => expanded = !expanded),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AnimatedSize(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 250),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.list.title,
                        style: theme.textTheme.headline6,
                      ),
                    ),
                    Icon(expanded ? Icons.expand_less : Icons.expand_more),
                  ],
                ),
                if (expanded)
                  for (var item in widget.list.items)
                    Row(
                      children: [
                        Checkbox(
                          value: item.checked,
                          onChanged: (value) async {
                            final fields = FormData.fromMap({"checked": !item.checked});
                            item.checked = !item.checked;
                            setState(() {});
                            ItemApiService.instance.patch(item, fields);
                          },
                        ),
                        Expanded(
                          child: Text(item.toString()),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Callback when mouse clicked on `Listener` wrapped widget.
  Future<void> _showMenu() async {
    RenderBox thisObjectBox = context.findRenderObject() as RenderBox;
    // Check if right mouse button clicked
    final overlayBox = Overlay.of(context)?.context.findRenderObject() as RenderBox;
    final overlayLocalPosition = overlayBox.globalToLocal(
      thisObjectBox.localToGlobal(
        Offset(thisObjectBox.constraints.maxWidth, 0),
      ),
    );
    final menuItem = await showMenu<int>(
      context: context,
      items: [
        const PopupMenuItem(
          value: 1,
          child: Text('Edit'),
        ),
        // const PopupMenuItem(child: Text('Cut'), value: 2),
      ],
      position: RelativeRect.fromRect(
        overlayLocalPosition & Size.zero,
        Offset.zero & overlayBox.size,
      ),
    );

    // Check if menu item clicked
    if (mounted) {
      switch (menuItem) {
        case 1:
          await Navigator.of(context).pushNamed(
            AddGroceryListPage.route,
            arguments: AddGroceryListPageArguments(widget.list),
          );
          setState(() {});
          break;
        default:
      }
    }
  }
}
