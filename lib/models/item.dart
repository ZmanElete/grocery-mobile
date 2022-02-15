import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/measurement.dart';

class Item extends ApiModel {
  int? id;
  String title;
  // ItemList list; // items are appart of lists, lists are not appart of items?
  Measurement measurement;
  double quantity;

  Item({
    this.id,
    required this.title,
    // required this.list,
    required this.measurement,
    required this.quantity,
  });
  Item.fromMap(Map<String, dynamic> map)
      : id = map["id"]!,
        title = map["title"]!,
        // list = ItemList.fromMap(map["list"]),
        measurement = Measurement.fromMap(map["measurement"]),
        quantity = map["quantity"]!;

  @override
  Item clone() {
    return Item(
      id: this.id,
      title: this.title,
      // list: this.list.clone(),
      measurement: this.measurement.clone(),
      quantity: this.quantity,
    );
  }

  @override
  int? get pk => this.id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      // 'list': this.list.toMap(),
      'measurement': this.measurement.toMap(),
      'quantity': this.quantity,
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"]!;
    // list = ItemList.fromMap(map["list"]!);
    measurement = Measurement.fromMap(map["measurement"]!);
    quantity = map["quantity"]!;
  }
}
