// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:grocery_genie/managers/measurement_manager.dart';
import 'package:grocery_genie/models/measurement.dart';
import 'package:guru_provider/guru_provider/repository.dart';
import 'package:guru_provider/guru_provider/widgets/key_watcher.dart';

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
    super.initState();
    final widgetMeasurement = widget.measurement;
    if (widgetMeasurement != null) {
      measurement = widgetMeasurement;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyWatcher(
      stateKey: MeasurementListManager.measurementsKey(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error loading measurements');
        } else if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final items = snapshot.data!;
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
            for (var m in items)
              DropdownMenuItem(
                value: m,
                child: Text(m.title),
              )
          ],
        );
      },
    );
  }
}
