import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/item_list.dart';

import 'recipe.dart';

class ListSection extends ApiModel {
  int id;
  Recipe recipe;
  String title;
  int sortOrder;
  ItemList list;

  ListSection();
  ListSection.fromMap(Map<String, dynamic> map) {
    this.loadMap(map);
  }

  @override
  ApiModel clone() {
    return ListSection()
      ..id=this.id
      ..recipe=this.recipe
      ..title=this.title
      ..sortOrder=this.sortOrder
      ..list=this.list;
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.recipe = Recipe.fromMap(map['recipe']);
    this.title = map['title'];
    this.sortOrder = map['sort_order'];
    this.list = ItemList.fromMap(map['list']);
  }

  @override
  get pk => this.id;

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
}
