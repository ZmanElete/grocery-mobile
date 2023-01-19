import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/item.dart';

class ItemList extends ApiModel {
  int? id;
  String title;
  String household;
  bool active;
  List<Item> items;

  ItemList({
    this.id,
    required this.title,
    required this.household,
    this.active = true,
    this.items = const [],
  });

  factory ItemList.empty() => ItemList(
    title: 'New List',
    household: '',
    active: true,
    items: [],
  );

  ItemList.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title']!,
        household = map['household'],
        active = map['active']!,
        items = List<Item>.from(map['item_set']?.map(Item.fromMap).toList() ?? []);

  static ItemList createFromMap(Map<String, dynamic> map) {
    return ItemList.fromMap(map);
  }

  @override
  ItemList clone() {
    return ItemList(
      id: id,
      title: title,
      household: household,
      active: active,
      items: items.map((item) => item.clone()).toList(),
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
      'active': active,
      'item_set': items.map((item) => item.toMap()).toList(),
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title']!;
    household = map['household']!;
    active = map['active']!;
    items = map['item_set']?.map(Item.fromMap).toList() ?? [];
  }
}
