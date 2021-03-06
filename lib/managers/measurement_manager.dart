import 'package:grocery_list/models/measurement.dart';
import 'package:grocery_list/services/api/measurement_api_service.dart';

class MeasurementManager {
  static MeasurementManager instance = MeasurementManager();

  List<Measurement> measurements = [];
  bool initialized = false;

  Future<void> init() async {
    if (initialized) return;
    initialized = true;
    refreshMeasurements();
  }

  Future<void> refreshMeasurements() async {
    measurements = await MeasurementApiService.instance.list();
  }
}
