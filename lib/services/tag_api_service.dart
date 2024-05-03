import 'package:grocery_genie/models/tag.dart';
import 'package:grocery_genie/services/mixins/grocery_api_mixin.dart';
import 'package:guru_flutter_rest/django/model_rest_service.dart';
import 'package:guru_flutter_rest/django/rest_methods.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';

class TagApiService extends GenericRestService<Tag>
    with //
        ListModelMixin,
        DeleteModelMixin,
        GroceryApiMixin {
  static StateKey<TagApiService> key = StateKey(() => TagApiService());

  TagApiService() : super('tag');

  @override
  Tag modelFromMap(Map<String, dynamic> m) {
    return Tag.fromJson(m);
  }
}
