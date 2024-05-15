import 'package:grocery_genie/managers/list_manager.dart';
import 'package:grocery_genie/models/tag.dart';
import 'package:grocery_genie/services/tag_api_service.dart';
import 'package:guru_provider/guru_provider/keys/state_key.dart';
import 'package:guru_provider/guru_provider/repository.dart';
import 'package:logging/logging.dart';

final logger = Logger('TagsManager');

class TagsManager extends ListManager<Tag, TagApiService> {
  static StateKey<TagsManager> key = StateKey(() => TagsManager());

  @override
  TagApiService get apiService => Repository.instance.read(TagApiService.key);

  @override
  String get contentEmpty => 'No Tags found';
}
