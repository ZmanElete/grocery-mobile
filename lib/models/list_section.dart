import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/item_list.dart';

import 'recipe.dart';

class ListSection extends ApiModel {
  int? id;
  Recipe recipe;
  String title;
  int sortOrder;
  ItemList list;

  ListSection({
    this.id,
    required this.recipe,
    required this.title,
    required this.sortOrder,
    required this.list,
  });
  ListSection.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        recipe = Recipe.fromMap(map['recipe']),
        title = map['title'],
        sortOrder = map['sortOrder'],
        list = ItemList.fromMap(map['list']);

  @override
  ApiModel clone() {
    return ListSection(
      id: id,
      recipe: recipe,
      title: title,
      sortOrder: sortOrder,
      list: list,
    );
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipe': recipe.toMap(),
      'title': title,
      'sort_order': sortOrder,
      'list': list.toMap(),
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    recipe = Recipe.fromMap(map['recipe']!);
    title = map['title']!;
    sortOrder = map['sortOrder']!;
    list = ItemList.fromMap(map['list']!);
  }
}
