import 'package:flutter/material.dart';
import 'package:grocery_list/models/item.dart';
import 'package:grocery_list/models/measurement.dart';

class AddItemDialog extends StatefulWidget {
  AddItemDialog({Key? key}) : super(key: key);

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final measurementController = TextEditingController();
  final quantityController = TextEditingController();

  Measurement? measurement;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              icon: Icon(Icons.close),
              color: theme.textTheme.bodyText1!.color,
            ),
            backgroundColor: theme.canvasColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Create an Item",
              style: theme.textTheme.subtitle1,
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
              child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: null,
                  onPressed: () {
                    var valid = formKey.currentState!.validate();
                    if (valid) {
                      var item = Item(
                        title: titleController.text,
                        measurement: measurement!,
                        quantity: double.parse(quantityController.text),
                      );
                      Navigator.pop(context, item);
                    }
                  },
                ),
              ),
              // Expanded(),
            ],
          )),
        ),
      ),
    );
  }
}