import 'package:grocery_genie/models/measurement.dart';
import 'package:grocery_genie/services/mixins/grocery_api_mixin.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_flutter_rest/django/rest_methods.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';

class MeasurementApiService extends GenericRestService<Measurement>
    with //
        ListModelMixin,
        GroceryApiMixin {
  static StateKey<MeasurementApiService> key =
      StateKey(() => MeasurementApiService());

  MeasurementApiService() : super('measurement');
  @override
  Measurement modelFromMap(Map<String, dynamic> m) {
    return Measurement.fromJson(m);
  }
}
