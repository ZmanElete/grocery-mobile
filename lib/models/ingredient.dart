import 'package:grocery_genie/models/measurement.dart';
import 'package:grocery_genie/models/tag.dart';
import 'package:guru_flutter_rest/django/api_model.dart';


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

  Ingredient.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        purchasingQuantity = map['purchasing_quantity'],
        purchasingMeasurement = Measurement.fromDynamic(map['purchasing_measurement']),
        // ignore: unnecessary_lambdas
        tags = List<Tag>.from((map['tags'] as List?)?.map((m) => Tag.fromDynamic(m)).toList() ?? []);

  Ingredient clone() {
    return Ingredient(
      title: title,
      purchasingQuantity: purchasingQuantity,
      purchasingMeasurement: purchasingMeasurement,
      tags: tags.map((t) => t.clone()).toList(),
    );
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'purchasing_quantity': purchasingQuantity,
      'purchasing_measurement': purchasingMeasurement.id,
      'tags': tags.map((t) => t.toJson()).toList(),
    };
  }
}
