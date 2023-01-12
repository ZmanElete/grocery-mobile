import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:grocery_list/models/item.dart';
import 'package:grocery_list/models/recipe.dart';
import 'package:grocery_list/pages/dashboard_navigator/pages/add_grocery_list/widgets/add_item_dialog.dart';
import 'package:grocery_list/services/api/recipe_api_service.dart';
import 'package:grocery_list/widget/editable_text_field.dart';
import 'package:grocery_list/widget/editable_text_form.dart';
import 'package:grocery_list/widget/exploading_fab.dart';

class RecipeDetailPageArgs {
  final Recipe recipe;
  final bool editing;

  const RecipeDetailPageArgs({required this.recipe, this.editing = false});
}

class RecipeDetailPage extends StatefulWidget {
  static const route = 'recipe-detail';

  final Recipe recipe;
  final bool editing;
  const RecipeDetailPage({required this.recipe, this.editing = false, super.key});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Recipe recipe;
  late EditableController controller;

  @override
  void initState() {
    bool editing;
    editing = widget.editing;
    recipe = widget.recipe;
    controller = EditableController(
      editable: editing,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: _buildContent(context),
    );
  }

  Future<void> persistRecipe() async {
    await RecipeApiService.instance.update(recipe);
  }

  Widget floatingActionButton() {
    return ValueListenableBuilder<bool>(
        valueListenable: controller.editable,
        builder: (context, editable, _) {
          return ExplodingActionButton(
            overrideMainButtonWidget: editable
                ? FloatingActionButton(
                    onPressed: () {
                      controller.editable.value = false;
                    },
                    child: const Icon(Icons.check),
                  )
                : null,
            type: SpreadType.third,
            children: [
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                ),
              ),
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                ),
              ),
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                ),
              ),
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                ),
              ),
              FloatingActionButton(
                onPressed: editable ? null : () => controller.editable.value = true,
                child: const Icon(
                  Icons.edit,
                ),
              ),
            ],
          );
        });
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    return EditableForm(
      controller: controller,
      builder: (context) => ListView(
        padding: const EdgeInsets.all(15),
        children: [
          EditableTextField(
            hint: 'Title',
            initialText: recipe.title,
            style: theme.textTheme.titleLarge,
            onValueConfirmed: (String text) {
              recipe.title = text;
              persistRecipe();
            },
          ),
          EditableTextField(
            hint: 'Serving Size',
            initialText: widget.recipe.standardServing.toString(),
            keyboardType: TextInputType.number,
            style: theme.textTheme.bodyLarge,
            prefixIcon: const Icon(
              Icons.group,
            ),
            onValueConfirmed: (String text) {},
          ),
          const SizedBox(height: 5),
          Padding(
            padding: theme.inputDecorationTheme.contentPadding ?? EdgeInsets.zero,
            child: Text(
              'Ingredients',
              style: theme.textTheme.labelLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in recipe.list.items)
                  _ingredientItem(
                    context: context,
                    item: item,
                  ),
                if (controller.editable.value) //
                  _addItemButton(context),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // Padding(
          //   padding: theme.inputDecorationTheme.contentPadding ?? EdgeInsets.zero,
          //   child: Text(
          //     'Instructions',
          //     style: theme.textTheme.labelLarge,
          //   ),
          // ),
          EditableTextField(
            hint: 'Instructions',
            initialText: recipe.instructions,
            keyboardType: TextInputType.multiline,
            minLines: 15,
            onValueConfirmed: (String text) {
              recipe.instructions = text;
            },
          ),
        ],
      ),
    );
  }

  Widget _ingredientItem({
    required BuildContext context,
    required Item item,
  }) {
    return Row(
      children: [
        Expanded(child: Text(item.toString())),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: controller.editable.value,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => editItem(item: item),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.edit,
              ),
            ),
          ),
        ),
        if (controller.editable.value)
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => removeItem(item),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.remove,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Widget _addItemButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => editItem(),
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> editItem({Item? item}) async {
    bool creating = item == null;
    item = await showDialog(
      context: context,
      builder: (context) => EditItemDialog(item: item),
    );
    if (item is Item) {
      if (creating) {
        recipe.list.items.add(item);
      }
      persistRecipe();
      setState(() {});
    }
  }

  Future<void> removeItem(Item item) async {
    recipe.list.items.remove(item);
    persistRecipe();
    setState(() {});
  }
}
