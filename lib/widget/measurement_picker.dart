import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/measurement_manager.dart';
import 'package:grocery_genie/models/measurement.dart';

class MeasurementPicker extends StatefulWidget {
  final String title;
  final Measurement? measurement;
  final void Function(Measurement?) onChange;
  const MeasurementPicker({
    required this.onChange,
    this.title = 'Measurement',
    this.measurement,
    super.key,
  });

  @override
  State<MeasurementPicker> createState() => _MeasurementPickerState();
}

class _MeasurementPickerState extends State<MeasurementPicker> {
  final measurementController = TextEditingController();

  Measurement? measurement;

  @override
  void initState() {
    final widgetMeasurement = widget.measurement;
    if (widgetMeasurement != null) {
      measurement = widgetMeasurement;
    } else {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(widget.title),
      value: measurement,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.square_foot),
        contentPadding: EdgeInsets.only(left: 25),
        suffixIcon: Icon(Icons.expand_more),
      ),
      icon: const SizedBox.shrink(),
      validator: (Measurement? measurement) {
        if (measurement == null) {
          return 'Cannot be empty';
        }
        return null;
      },
      onChanged: (Measurement? value) {
        measurement = value;
        widget.onChange(measurement);
        setState(() {});
      },
      items: [
        for (var m in MeasurementListManager.instance.list.value!)
          DropdownMenuItem(
            value: m,
            child: Text(m.title),
          )
      ],
    );
  }
}
