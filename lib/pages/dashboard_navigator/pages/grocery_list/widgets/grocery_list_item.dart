import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:grocery_genie/managers/grocery_list_manager.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/add_grocery_list/grocery_list_detail.dart';
import 'package:grocery_genie/services/item_api_service.dart';
import 'package:grocery_genie/widget/confirm_delete_dialog.dart';
import 'package:guru_provider/guru_provider/repository.dart';

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
    return InkWell(
      onTap: () {
        expanded = !expanded;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: AnimatedSize(
          duration: Duration(milliseconds: 50 * widget.list.items.length + 1),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.list.title,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showMenu(context),
                    icon: const Icon(Icons.more_vert_rounded),
                  )
                ],
              ),
              if (expanded)
                if (widget.list.items.isNotEmpty)
                  for (var item in widget.list.items)
                    Row(
                      children: [
                        Checkbox(
                          value: item.checked,
                          onChanged: (value) async {
                            final fields = FormData.fromMap({"checked": !item.checked});
                            item.checked = !item.checked;
                            setState(() {});
                            Repository.instance.read(ItemApiService.key).patch(item, data: fields);
                          },
                        ),
                        Expanded(
                          child: Text(item.toString()),
                        ),
                      ],
                    )
                else
                  const Text('Not Items in this list')
            ],
          ),
        ),
      ),
    );
  }

  /// Callback when mouse clicked on `Listener` wrapped widget.
  Future<void> _showMenu(BuildContext context) async {
    final RenderBox thisObjectBox = context.findRenderObject()! as RenderBox;
    // Check if right mouse button clicked
    final overlayBox = Overlay.of(context).context.findRenderObject()! as RenderBox;
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
        const PopupMenuItem(
          value: 2,
          child: Text('Delete'),
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
          await GoRouter.of(context).pushNamed(
            GroceryDetailListPage.route.name,
            pathParameters: {"id": widget.list.id!.toString()},
            extra: widget.list,
          );
          setState(() {});
          break;
        case 2:
          final result = await showDialog(
            context: context,
            builder: (context) => ConfirmDeleteDialog(
              targetTitle: 'the list "${widget.list.title}"',
            ),
          );
          if (result == true) {
            await Repository.instance.read(GroceryListManager.key).deleteItem(widget.list);
          }
          setState(() {});
          break;
        default:
      }
    }
  }
}
