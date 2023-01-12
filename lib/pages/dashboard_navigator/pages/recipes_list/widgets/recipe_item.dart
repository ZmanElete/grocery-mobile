import 'package:flutter/material.dart';
import 'package:grocery_list/managers/recipe_manager.dart';

import 'package:grocery_list/models/recipe.dart';
import 'package:grocery_list/pages/dashboard_navigator/pages/recipe_detail/recipe_detail.dart';
import 'package:grocery_list/widget/confirm_delete_dialog.dart';

class RecipeItem extends StatefulWidget {
  final Recipe recipe;
  RecipeItem({required this.recipe, Key? key}) : super(key: key ?? ValueKey('Recipe-${recipe.id}'));

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          RecipeDetailPage.route,
          arguments: RecipeDetailPageArgs(recipe: widget.recipe),
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
                    widget.recipe.title,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.people_alt_rounded),
                    const SizedBox(width: 5),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(widget.recipe.standardServing.toString()),
                    ),
                  ],
                )
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
            RecipeDetailPage.route,
            arguments: RecipeDetailPageArgs(recipe: widget.recipe),
          );
          setState(() {});
          break;
        case 2:
          final result = await showDialog(
            context: context,
            builder: (context) => ConfirmDeleteDialog(
              targetTitle: 'the recipe "${widget.recipe.title}"',
            ),
          );
          if (result == true) {
            await RecipeManager.instance.deleteList(widget.recipe);
          }
          setState(() {});
          break;
        default:
          break;
      }
    }
  }
}
