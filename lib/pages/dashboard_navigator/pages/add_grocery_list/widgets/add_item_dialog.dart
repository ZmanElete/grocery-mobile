import 'package:flutter/material.dart';

import '../../../../../managers/measurement_manager.dart';
import '../../../../../models/item.dart';
import '../../../../../models/measurement.dart';

class EditItemDialog extends StatefulWidget {
  final Item? item;
  const EditItemDialog({this.item, Key? key}) : super(key: key);

  @override
  EditItemDialogState createState() => EditItemDialogState();
}

class EditItemDialogState extends State<EditItemDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final measurementController = TextEditingController();
  final quantityController = TextEditingController(text: '1');

  Measurement? measurement;

  final double outsidePadding = 16;

  @override
  initState() {
    if (widget.item != null) {
      titleController.text = widget.item!.title;
      quantityController.text = widget.item!.quantity.toString();
      measurement = widget.item!.measurement;
    } else {
      final wholeMeasurement = MeasurementManager.instance.measurements.where((element) => element.title == 'Whole');
      if (wholeMeasurement.isNotEmpty) {
        measurement = wholeMeasurement.first;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.fromLTRB(outsidePadding, outsidePadding, outsidePadding, 0),
      title: Row(
        children: [
          const Expanded(child: Text('Add Item')),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(outsidePadding, 0, outsidePadding, outsidePadding),
      children: [
        _form(context),
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Quantity",
                    ),
                    validator: (String? input) {
                      if (input == null) {
                        return 'Cannot be empty';
                      } else if (double.tryParse(input) == null) {
                        return 'Must be a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: DropdownButtonFormField(
                    hint: const Text("Measurement"),
                    value: measurement,
                    items: [
                      for (var m in MeasurementManager.instance.measurements)
                        DropdownMenuItem(
                          value: m,
                          child: Text(m.title),
                        )
                    ],
                    validator: (Measurement? measurement) {
                      if (measurement == null) {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (Measurement? value) {
                      measurement = value;
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Add Item"),
                ),
              ),
              // Expanded(),
            ],
          ),
        ],
      ),
    );
  }

  _submit() {
    var valid = formKey.currentState!.validate();
    if (valid) {
      Item item;
      if (widget.item == null) {
        item = Item(
          title: titleController.text,
          measurement: measurement!,
          quantity: double.parse(quantityController.text),
        );
      } else {
        item = widget.item!;
        item.title = titleController.text;
        item.measurement = measurement!;
        item.quantity = double.parse(quantityController.text);
      }
      Navigator.pop(context, item);
    }
  }
}
