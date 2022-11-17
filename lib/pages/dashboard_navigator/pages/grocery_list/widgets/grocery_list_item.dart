import 'package:flutter/material.dart';

import 'package:grocery_list/models/item_list.dart';

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
      child: InkWell(
        onLongPress: _onLongPress,
        onTap: () => setState(() => expanded = !expanded),
        child: AnimatedSize(
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
                        value: false,
                        onChanged: (value) {},
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
    );
  }

  /// Callback when mouse clicked on `Listener` wrapped widget.
  Future<void> _onLongPress() async {
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
    if(mounted) {
      switch (menuItem) {
        case 1:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Copy clicked'),
            behavior: SnackBarBehavior.floating,
          ));
          break;
        case 2:
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Cut clicked'), behavior: SnackBarBehavior.floating));
          break;
        default:
      }
    }
  }
}
