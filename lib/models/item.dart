import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/measurement.dart';

class Item extends ApiModel {
  int? id;
  String title;
  Measurement measurement;
  double quantity;
  int? list;
  bool checked = false;

  Item({
    this.id,
    required this.title,
    required this.measurement,
    required this.quantity,
    this.checked = false,
  });

  Item.fromMap(Map<String, dynamic> map)
      : id = map["id"]!,
        title = map["title"]!,
        measurement = Measurement.fromMap(map["measurement"]),
        quantity = map["quantity"]!,
        checked = map["checked"];

  @override
  Item clone() {
    return Item(
      id: id,
      title: title,
      measurement: measurement.clone(),
      quantity: quantity,
      checked: checked,
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
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"]!;
    measurement = Measurement.fromMap(map["measurement"]!);
    quantity = map["quantity"]!;
    checked = map["checked"];
  }

  @override
  String toString() {
    return '$quantity $measurement - $title';
  }
}
