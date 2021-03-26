import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/item_list.dart';

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
      id: this.id,
      recipe: this.recipe,
      title: this.title,
      sortOrder: this.sortOrder,
      list: this.list,
    );
  }

  @override
  int? get pk => this.id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'recipe': this.recipe.toMap(),
      'title': this.title,
      'sort_order': this.sortOrder,
      'list': this.list.toMap(),
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
