import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/item.dart';
import 'package:grocery_genie/models/tag.dart';

class ItemList extends ApiModel {
  int? id;
  String title;
  String household;
  bool active;
  List<Item> items;
  List<Tag> tags;

  ItemList({
    this.id,
    required this.title,
    required this.household,
    this.active = true,
    this.items = const [],
    this.tags = const [],
  });

  factory ItemList.empty() => ItemList(
        title: 'New List',
        household: '',
        active: true,
        items: [],
        tags: [],
      );

  ItemList.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title']!,
        household = map['household'],
        active = map['active']!,
        // ignore: unnecessary_lambdas
        items = List<Item>.from((map['item_set'] as List<Map<String, dynamic>>?)?.map((m) => Item.fromMap(m)).toList() ?? []),
        // ignore: unnecessary_lambdas
        tags = List<Tag>.from((map['tags'] as List<Map<String, dynamic>>?)?.map((m) => Tag.fromMap(m)).toList() ?? []);

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
      'active': active,
      'item_set': items.map((item) => item.toMap()).toList(),
      'tags': tags.map((tag) => tag.toMap()).toList(),
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title']!;
    household = map['household']!;
    active = map['active']!;
    items = (map['item_set'] as List<Map<String, dynamic>>?)?.map(Item.fromMap).toList() ?? [];
    tags = (map['tags'] as List<Map<String, dynamic>>?)?.map(Tag.fromMap).toList() ?? [];
  }
}
