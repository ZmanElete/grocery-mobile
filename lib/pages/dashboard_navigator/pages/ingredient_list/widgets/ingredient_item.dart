import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/ingredient_manager.dart';
import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/pages/dashboard_navigator/pages/ingredient_detail/ingredient_detail.dart';

import 'package:grocery_genie/widget/confirm_delete_dialog.dart';

class IngredientItem extends StatefulWidget {
  final Ingredient ingredient;
  IngredientItem({required this.ingredient, Key? key})
      : super(key: key ?? ValueKey('Ingredient-${ingredient.id}'));

  @override
  State<IngredientItem> createState() => _IngredientItemState();
}

class _IngredientItemState extends State<IngredientItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          IngredientDetailPage.route,
          arguments: IngredientDetailPageArgs(
            ingredient: widget.ingredient,
            editing: null,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    widget.ingredient.title,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                // const SizedBox(height: 10),
              ],
            ),
            IconButton(
              onPressed: () => _showMenu(context),
              icon: const Icon(Icons.more_vert_rounded),
            )
          ],
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
          await Navigator.of(context).pushNamed(
            IngredientDetailPage.route,
            arguments: IngredientDetailPageArgs(ingredient: widget.ingredient),
          );
          setState(() {});
          break;
        case 2:
          final result = await showDialog(
            context: context,
            builder: (context) => ConfirmDeleteDialog(
              targetTitle: 'the Ingredient "${widget.ingredient.title}"',
            ),
          );
          if (result == true) {
            await IngredientListManager.instance.deleteItem(widget.ingredient);
          }
          setState(() {});
          break;
        default:
          break;
      }
    }
  }
}
