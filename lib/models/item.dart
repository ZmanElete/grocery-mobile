import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/ingredient.dart';
import 'package:grocery_genie/models/measurement.dart';
import 'package:grocery_genie/models/tag.dart';

class Item extends ApiModel implements Comparable {
  int? id;
  String title;
  Measurement measurement;
  double quantity;
  int? list;
  bool checked = false;
  List<Tag> tags;
  Ingredient? ingredient;
  int sequence;

  Item({
    this.id,
    required this.title,
    required this.measurement,
    required this.quantity,
    required this.sequence,
    this.checked = false,
    this.tags = const [],
    this.ingredient,
  });

  Item.fromMap(Map<String, dynamic> map)
      : id = map["id"]!,
        title = map["title"]!,
        measurement = Measurement.fromMap(map["measurement"]),
        quantity = map["quantity"]!,
        checked = map["checked"],
        // ignore: unnecessary_lambdas
        tags = List<Tag>.from(map['tags']?.map((m) => Tag.fromMap(m)).toList() ?? []),
        ingredient = map['ingredient'] != null ? Ingredient.fromMap(map['ingredient']) : null,
        sequence = map['sequence'];

  static List<Item> fromListOfMaps(List<Map<String, dynamic>>? maps) {
    final List<Item> items = [];
    if (maps == null) {
      return items;
    }
    for (final map in maps) {
      items.add(Item.fromMap(map));
    }
    return items..sort();
  }

  @override
  Item clone() {
    return Item(
      id: id,
      title: title,
      measurement: measurement.clone(),
      quantity: quantity,
      checked: checked,
      tags: tags.map((tag) => tag.clone()).toList(),
      ingredient: ingredient?.clone(),
      sequence: sequence,
    );
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'measurement': measurement.id,
      'quantity': quantity,
      'checked': checked,
      'sequence': sequence,
      'tags': tags.map((tag) => tag.toMap()).toList(),
      'ingredient': ingredient?.toMap(),
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"]!;
    measurement = Measurement.fromMap(map["measurement"]!);
    quantity = map["quantity"]!;
    checked = map["checked"];
    sequence = map["sequence"];
    tags = map['tags']?.map(Tag.fromMap).toList() ?? [];
    ingredient = map['ingredient'] != null ? Ingredient.fromMap(map['ingredient']) : null;
  }

  @override
  String toString() {
    return '$quantity $measurement - $title';
  }

  @override
  int compareTo(other) {
    return sequence.compareTo(other.sequence);
  }
}
