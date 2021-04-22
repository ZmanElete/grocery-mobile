import '../../models/measurement.dart';
import 'rest_service.dart';

class MeasurementApiService extends RestService<Measurement> {
  static MeasurementApiService get instance =>
      _instance != null ? _instance! : MeasurementApiService();
  static MeasurementApiService? _instance;

  MeasurementApiService()
      : super(
          resource: 'list',
          apiModelCreator: (map) => Measurement.fromMap(map),
        ) {
    _instance = this;
  }
}
