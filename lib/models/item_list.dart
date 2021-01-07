import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/household.dart';
import 'package:grocery_list/models/item.dart';

class ItemList extends ApiModel{
  int id;
  String title;
  Household household;
  bool active;
  List<Item> items;

  ItemList();
  ItemList.fromMap(Map<String, dynamic> map) {
    this.loadMap(map);
  }

  @override
  ApiModel clone() {
    return ItemList()
      ..id = this.id
      ..title = this.title
      ..household = this.household
      ..active = this.active
      ..items = this.items.map((item) => item.clone());
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.household = Household.fromMap(map['household']);
    this.active = map['active'];
    this.items = [];
    for(Map<String, dynamic> item in map['item_set']){
      this.items.add(Item.fromMap(item));
    }
  }

  @override
  get pk => this.id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'household': this.household.toMap(),
      'active': this.active,
      'item_set': this.items.map((item) => item.toMap()),
    };
  }
}
