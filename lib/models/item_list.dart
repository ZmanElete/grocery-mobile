import 'package:guru_flutter_rest/django/api_model.dart';
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

  ItemList.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title']!,
        household = map['household'],
        active = map['active']!,
        // ignore: unnecessary_lambdas
        items = List<Item>.from((map['item_set'] as List?)?.map((m) => Item.fromJson(m)).toList() ?? []),
        // ignore: unnecessary_lambdas
        tags = List<Tag>.from((map['tags'] as List?)?.map((m) => Tag.fromJson(m)).toList() ?? []);

  static ItemList createFromJson(Map<String, dynamic> map) {
    return ItemList.fromJson(map);
  }

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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'household': household,
      'active': active,
      'item_set': items.map((item) => item.toJson()).toList(),
      'tags': tags.map((tag) => tag.toJson()).toList(),
    };
  }

  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title']!;
    household = map['household']!;
    active = map['active']!;
    items = List<Item>.from((map['item_set'] as List?)?.map((map) => Item.fromJson(map)).toList() ?? []);
    tags = List<Tag>.from((map['tags'] as List?)?.map((map) => Tag.fromJson(map)).toList() ?? []);
  }
}
