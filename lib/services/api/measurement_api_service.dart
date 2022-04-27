import 'package:grocery_list/services/api/rest_methods.dart';

import '../../models/measurement.dart';
import 'model_rest_service.dart';

class MeasurementApiService extends GenericRestService<Measurement> with ListModelMixin {
  static MeasurementApiService get instance => _instance != null ? _instance! : MeasurementApiService();
  static MeasurementApiService? _instance;

  MeasurementApiService()
      : super(
          'measurement',
        ) {
    _instance = this;
  }

  @override
  Measurement modelFromMap(Map<String, dynamic> m) {
    return Measurement.fromMap(m);
  }
}
