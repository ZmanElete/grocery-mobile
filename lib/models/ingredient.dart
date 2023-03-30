import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/measurement.dart';
import 'package:grocery_genie/models/tag.dart';


class Ingredient extends ApiModel {
  int? id;
  String title;
  double? purchasingQuantity;
  Measurement purchasingMeasurement;
  List<Tag> tags;

  Ingredient({
    this.id,
    required this.title,
    required this.purchasingQuantity,
    required this.purchasingMeasurement,
    required this.tags,
  });

  Ingredient.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        purchasingQuantity = map['purchasing_quantity'],
        purchasingMeasurement = Measurement.fromDynamic(map['purchasing_measurement']),
        // ignore: unnecessary_lambdas
        tags = List<Tag>.from((map['tags'] as List<Map<String, dynamic>>?)?.map((m) => Tag.fromDynamic(m)).toList() ?? []);

  @override
  Ingredient clone() {
    return Ingredient(
      title: title,
      purchasingQuantity: purchasingQuantity,
      purchasingMeasurement: purchasingMeasurement,
      tags: tags.map((t) => t.clone()).toList(),
    );
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    purchasingQuantity = map['purchasing_quantity'];
    purchasingMeasurement = map['purchasing_measurement'];
    tags = (map['tags'] as List<Map<String, dynamic>>?)?.map(Tag.fromMap).toList() ?? [];
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'purchasing_quantity': purchasingQuantity,
      'purchasing_measurement': purchasingMeasurement.id,
      'tags': tags.map((t) => t.toMap()).toList(),
    };
  }
}
