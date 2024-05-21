import 'package:guru_flutter_rest/django/api_model.dart';
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

  Item.fromJson(Map<String, dynamic> map)
      : id = map["id"]!,
        title = map["title"]!,
        measurement = Measurement.fromDynamic(map["measurement"]),
        quantity = map["quantity"]!,
        checked = map["checked"],
        // ignore: unnecessary_lambdas
        tags = List<Tag>.from((map['tags'] as List?)?.map((m) => Tag.fromJson(m)).toList() ?? []),
        ingredient = map['ingredient'] != null ? Ingredient.fromJson(map['ingredient']) : null,
        sequence = map['sequence'];

  static List<Item> fromListOfMaps(List<Map<String, dynamic>>? maps) {
    final List<Item> items = [];
    if (maps == null) {
      return items;
    }
    for (final map in maps) {
      items.add(Item.fromJson(map));
    }
    return items..sort();
  }

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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'measurement': measurement.id,
      'quantity': quantity,
      'checked': checked,
      'sequence': sequence,
      'tags': tags.map((tag) => tag.toJson()).toList(),
      'ingredient': ingredient?.toJson(),
    };
  }

  void loadMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"]!;
    measurement = Measurement.fromJson(map["measurement"]!);
    quantity = map["quantity"]!;
    checked = map["checked"];
    sequence = map["sequence"];
    tags = List<Tag>.from((map['tags'] as List?)?.map((map) => Tag.fromJson(map)).toList() ?? []);
    ingredient = map['ingredient'] != null ? Ingredient.fromJson(map['ingredient']) : null;
  }

  @override
  String toString() {
    return '$quantity $measurement - $title';
  }

  @override
  int compareTo(other) {
    if (other is Item) {
      return sequence.compareTo(other.sequence);
    }
    throw Exception("Can't compare item to type ${other.runtimeType}");
  }
}
