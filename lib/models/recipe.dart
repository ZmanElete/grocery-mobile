import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/household.dart';
import 'package:grocery_list/models/list_section.dart';

class Recipe extends ApiModel {
  int? id;
  String title;
  Household household;
  String instructions;
  int standardServing;
  List<ListSection> listSection;

  Recipe({
    this.id,
    required this.title,
    required this.household,
    required this.instructions,
    required this.standardServing,
    this.listSection = const [],
  });
  Recipe.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        household = Household.fromMap(map['household']),
        instructions = map['instructions'],
        standardServing = map['standardServing'],
        listSection =
            map['listSection']?.map((ls) => ListSection.fromMap(ls)) ?? [];

  @override
  ApiModel clone() {
    return Recipe(
      id: id,
      title: title,
      household: household,
      instructions: instructions,
      standardServing: standardServing,
      listSection: listSection,
    );
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'household': household.toMap(),
      'instructions': instructions,
      'standard_serving': standardServing,
      'list_section_set': listSection.map((ls) => ls.toMap()),
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title']!;
    household = Household.fromMap(map['household']!);
    instructions = map['instructions']!;
    standardServing = map['standardServing']!;
    listSection =
        map['listSection']?.map((ls) => ListSection.fromMap(ls)) ?? [];
  }
}
