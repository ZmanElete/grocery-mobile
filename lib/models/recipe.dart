import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/item_list.dart';
import 'package:grocery_genie/models/tag.dart';

class Recipe extends ApiModel {
  int? id;
  String title;
  String household;
  String instructions;
  int standardServing;
  ItemList list;
  List<Tag> tags;

  Recipe({
    this.id,
    required this.title,
    required this.household,
    required this.instructions,
    required this.standardServing,
    required this.list,
    this.tags = const [],
  });

  factory Recipe.empty() => Recipe(
        title: 'New Recipe',
        household: '',
        instructions: '',
        standardServing: 0,
        list: ItemList.empty(),
        tags: [],
      );

  Recipe.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        household = map['household'],
        instructions = map['instructions'],
        standardServing = map['standard_serving'],
        list = ItemList.fromMap(map['list']),
        // ignore: unnecessary_lambdas
        tags = List<Tag>.from((map['tags'] as List<Map<String, dynamic>>?)?.map((m) => Tag.fromMap(m)).toList() ?? []);

  @override
  ApiModel clone() {
    return Recipe(
      id: id,
      title: title,
      household: household,
      instructions: instructions,
      standardServing: standardServing,
      list: list,
      tags: tags.map((tag) => tag.clone()).toList(),
    );
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'household': household,
      'instructions': instructions,
      'standard_serving': standardServing,
      'list': list.toMap(),
      'tags': tags.map((tag) => tag.toMap()).toList(),
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title']!;
    household = map['household']!;
    instructions = map['instructions']!;
    standardServing = map['standard_serving']!;
    list = ItemList.fromMap(map['list']);
    tags = (map['tags'] as List<Map<String, dynamic>>?)?.map(Tag.fromMap).toList() ?? [];
  }
}
