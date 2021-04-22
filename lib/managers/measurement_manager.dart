import 'dart:async';

import 'package:grocery_list/models/measurement.dart';
import 'package:grocery_list/services/api/measurement_api_service.dart';

class MeasurementManager {
  static MeasurementManager instance = MeasurementManager();

  final measurementApiService = MeasurementApiService.instance;

  StreamController<List<Measurement>> _measurementsStreamController = StreamController.broadcast();
  Stream<List<Measurement>> get measurements => _measurementsStreamController.stream;

  MeasurementManager() {
    _measurementsStreamController.add([]);
    asyncInit();
  }

  asyncInit() async {
    List<Measurement> measurements = await measurementApiService.list();
    _measurementsStreamController.add(measurements);
  }

  dispose() {
    _measurementsStreamController.close();
  }
}
