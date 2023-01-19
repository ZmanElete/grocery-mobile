import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/item_list.dart';

class Recipe extends ApiModel {
  int? id;
  String title;
  String household;
  String instructions;
  int standardServing;
  ItemList list;

  Recipe({
    this.id,
    required this.title,
    required this.household,
    required this.instructions,
    required this.standardServing,
    required this.list,
  });

  factory Recipe.empty() => Recipe(
        title: 'New Recipe',
        household: '',
        instructions: '',
        standardServing: 0,
        list: ItemList.empty(),
      );

  Recipe.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        household = map['household'],
        instructions = map['instructions'],
        standardServing = map['standard_serving'],
        list = ItemList.fromMap(map['list']);

  @override
  ApiModel clone() {
    return Recipe(
      id: id,
      title: title,
      household: household,
      instructions: instructions,
      standardServing: standardServing,
      list: list,
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
  }
}
