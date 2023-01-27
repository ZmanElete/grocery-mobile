import 'package:flutter/material.dart';
import 'package:grocery_genie/widget/measurement_picker.dart';

import '/models/item.dart';
import '/models/measurement.dart';

class EditItemDialog extends StatefulWidget {
  final Item? item;
  const EditItemDialog({this.item, Key? key}) : super(key: key);

  @override
  EditItemDialogState createState() => EditItemDialogState();
}

class EditItemDialogState extends State<EditItemDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final quantityController = TextEditingController(text: '1');

  Measurement? measurement;

  final double outsidePadding = 16;

  @override
  void initState() {
    if (widget.item != null) {
      titleController.text = widget.item!.title;
      quantityController.text = widget.item!.quantity.toString();
      measurement = widget.item!.measurement;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.all(15),
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
      contentPadding: EdgeInsets.fromLTRB(outsidePadding, 5, outsidePadding, outsidePadding),
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
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: "Title",
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Quantity",
              prefixIcon: Icon(Icons.numbers),
              isDense: true,
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
          const SizedBox(height: 20),
          MeasurementPicker(
            measurement: measurement,
            onChange: (Measurement? measurement) {
              this.measurement = measurement;
            },
          ),
          const SizedBox(height: 20),
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

  void _submit() {
    final valid = formKey.currentState!.validate();
    if (valid) {
      Item item;
      if (widget.item == null) {
        item = Item(
          title: titleController.text,
          measurement: measurement!,
          quantity: double.parse(quantityController.text),
          sequence: 9999,
        );
      } else {
        item = widget.item!
          ..title = titleController.text
          ..measurement = measurement!
          ..quantity = double.parse(quantityController.text);
      }
      Navigator.pop(context, item);
    }
  }
}
