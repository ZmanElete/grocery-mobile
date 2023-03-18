import 'package:flutter/material.dart';
import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/models/measurement.dart';
import 'package:grocery_genie/models/tag.dart';
import 'package:grocery_genie/services/api/ingredient_api_service.dart';
import 'package:grocery_genie/widget/editable_text_field.dart';
import 'package:grocery_genie/widget/editable_text_form.dart';
import 'package:grocery_genie/widget/exploading_fab.dart';
import 'package:grocery_genie/widget/measurement_picker.dart';
import 'package:grocery_genie/widget/tags_field.dart';
import 'package:logging/logging.dart';

final logger = Logger('IngredientDetailPage');

class IngredientDetailPageArgs {
  final Ingredient? ingredient;
  final bool? editing;

  IngredientDetailPageArgs({
    this.ingredient,
    bool? editing,
  }) : editing = editing ?? false;
}

class IngredientDetailPage extends StatefulWidget {
  static const String route = 'ingredient-detail';

  final Ingredient? ingredient;
  final bool editing;
  const IngredientDetailPage({
    this.ingredient,
    bool? editing,
    super.key,
  }) : editing = editing ?? false;

  @override
  State<IngredientDetailPage> createState() => _IngredientDetailPageState();
}

class _IngredientDetailPageState extends State<IngredientDetailPage> {
  Ingredient? ingredient;
  late EditableController controller;
  Map<String, dynamic> creatingMap = {};

  @override
  void initState() {
    bool editing;
    editing = widget.editing || ingredient == null;
    ingredient = widget.ingredient;
    creatingMap['tags'] = <Tag>[];
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

  Future<void> persistIngredient() async {
    try {
      ingredient ??= Ingredient.fromMap(creatingMap);
      if (ingredient != null) {
        if (ingredient!.id == null) {
          ingredient = await IngredientApiService.instance.create(ingredient!);
        } else {
          await IngredientApiService.instance.update(ingredient!);
        }
      }
    } catch (e, stack) {
      logger
        ..severe(e)
        ..severe(stack);
    }
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
            initialText: ingredient?.title,
            style: theme.textTheme.titleLarge,
            onValueConfirmed: (String text) {
              if (ingredient != null) {
                ingredient!.title = text;
              } else {
                creatingMap['title'] = text;
              }
              persistIngredient();
            },
          ),
          const SizedBox(height: 5),
          EditableTextField(
            hint: 'Purchasing Quantity',
            initialText: widget.ingredient?.purchasingQuantity.toString(),
            keyboardType: TextInputType.number,
            style: theme.textTheme.bodyLarge,
            prefixIcon: const Icon(
              Icons.numbers,
            ),
            onValueConfirmed: (String text) {
              final double number = double.parse(text);
              if (ingredient != null) {
                ingredient!.purchasingQuantity = number;
              } else {
                creatingMap['purchasing_quantity'] = number;
              }
              persistIngredient();
            },
          ),
          const SizedBox(height: 5),
          MeasurementPicker(
            title: 'Purchasing Measurement',
            measurement: ingredient?.purchasingMeasurement,
            onChange: (Measurement? measurement) {
              if (ingredient != null && measurement != null) {
                ingredient!.purchasingMeasurement = measurement;
              } else {
                creatingMap['purchasing_measurement'] = measurement;
              }
              persistIngredient();
            },
          ),
          const SizedBox(height: 12),
          TagsField(
            onChange: persistIngredient,
            tags: ingredient?.tags ?? creatingMap['tags'],
          ),
        ],
      ),
    );
  }
}
