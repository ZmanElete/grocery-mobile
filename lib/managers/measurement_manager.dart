import 'package:grocery_genie/managers/list_manager.dart';
import 'package:grocery_genie/models/measurement.dart';
import 'package:grocery_genie/services/api/measurement_api_service.dart';

class MeasurementListManager extends ListManager<Measurement, MeasurementApiService> {
  static MeasurementListManager instance = MeasurementListManager();
  bool initialized = false;

  @override
  MeasurementApiService get apiService => MeasurementApiService.instance;

  @override
  String get contentEmpty => 'No measurements found. This is likely due to an error or lack of connection.';

  Future<void> init() async {
    if (initialized) return;
    await getList();
    initialized = true;
  }
}
