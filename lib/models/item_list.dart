import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/household.dart';
import 'package:grocery_list/models/item.dart';

class ItemList extends ApiModel {
  int? id;
  String title;
  Household household; //might be okay to not be null
  bool active;
  List<Item> items;

  ItemList({
    this.id,
    required this.title,
    required this.household,
    this.active = true,
    this.items = const [],
  });
  ItemList.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title']!,
        household = Household.fromMap(map['household']),
        active = map['active']!,
        items = map['items']?.map((i) => Item.fromMap(i)).toList() ?? [];

  static ItemList createFromMap(Map<String, dynamic> map) {
    return ItemList.fromMap(map);
  }

  @override
  ItemList clone() {
    return ItemList(
      id: this.id,
      title: this.title,
      household: this.household.clone(),
      active: this.active,
      items: this.items.map((item) => item.clone()).toList(),
    );
  }

  @override
  int? get pk => this.id;

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

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title']!;
    household = Household.fromMap(map['household']!);
    active = map['active']!;
    items = map['items']?.map((i) => Item.fromMap(i)).toList() ?? [];
  }
}
