import 'package:grocery_genie/managers/list_manager.dart';
import 'package:grocery_genie/models/tag.dart';
import 'package:grocery_genie/services/api/tag_api_service.dart';
import 'package:logging/logging.dart';

final logger = Logger('TagsManager');

class TagsManager extends ListManager<Tag, TagApiService> {
  static TagsManager instance = TagsManager();

  @override
  TagApiService get apiService => TagApiService.instance;

  @override
  String get contentEmpty => 'No Tags found';
}
