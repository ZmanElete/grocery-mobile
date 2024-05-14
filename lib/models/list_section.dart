import 'package:guru_flutter_rest/django/api_model.dart';
import 'package:grocery_genie/models/item_list.dart';

import 'package:grocery_genie/models/recipe.dart';

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
  ListSection.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        recipe = Recipe.fromJson(map['recipe']),
        title = map['title'],
        sortOrder = map['sortOrder'],
        list = ItemList.fromJson(map['list']);

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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipe': recipe.toJson(),
      'title': title,
      'sort_order': sortOrder,
      'list': list.toJson(),
    };
  }

  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    recipe = Recipe.fromJson(map['recipe']!);
    title = map['title']!;
    sortOrder = map['sortOrder']!;
    list = ItemList.fromJson(map['list']!);
  }
}
