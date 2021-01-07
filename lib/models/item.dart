import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/measurement.dart';

import 'item_list.dart';

class Item extends ApiModel{
  int id;
  String title;
  ItemList list;
  Measurement measurement;
  double quantity;

  Item();
  Item.fromMap(Map<String, dynamic> map) {
    this.loadMap(map);
  }

  @override
  ApiModel clone() {
    return Item()
      ..id = this.id
      ..title = this.title
      ..list = this.list
      ..measurement = this.measurement
      ..quantity = this.quantity;
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.list = ItemList.fromMap(map['list']);
    this.measurement = Measurement.fromMap(map['measurement']);
    this.quantity = map['quantity'];
  }

  @override
  get pk => this.id;

  @override
  Map<String, dynamic> toMap() {
     return {
      'id': this.id,
      'title': this.title,
      'list': this.list.toMap(),
      'measurement': this.measurement.toMap(),
      'quantity': this.quantity,
     };
  }
}
