import 'package:grocery_genie/models/tag.dart';
import 'package:grocery_genie/services/api/model_rest_service.dart';
import 'package:grocery_genie/services/api/rest_methods.dart';

class TagApiService extends GenericRestService<Tag>
    with //
        ListModelMixin,
        DeleteModelMixin {
  static TagApiService get instance => _instance != null //
      ? _instance!
      : TagApiService();
  static TagApiService? _instance;

  TagApiService() : super('tag') {
    _instance = this;
  }

  @override
  Tag modelFromMap(Map<String, dynamic> m) {
    return Tag.fromMap(m);
  }
}
