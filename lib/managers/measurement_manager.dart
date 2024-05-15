import 'package:grocery_genie/managers/list_manager.dart';
import 'package:grocery_genie/models/measurement.dart';
import 'package:grocery_genie/services/measurement_api_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';

class MeasurementListManager extends ListManager<Measurement, MeasurementApiService> {
  static StateKey<MeasurementListManager> key = StateKey(() => MeasurementListManager());

  bool initialized = false;

  @override
  MeasurementApiService get apiService => Repository.instance.read(MeasurementApiService.key);

  @override
  String get contentEmpty => 'No measurements found. This is likely due to an error or lack of connection.';

  Future<void> init() async {
    if (initialized) return;
    await getList();
    initialized = true;
  }
}
