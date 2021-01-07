import 'package:grocery_list/models/api_model.dart';

class Measurement extends ApiModel {
  int id;
  String title;
  String symbol;
  double conversion;
  bool convertable;
  bool isFraction;

  Measurement();
  Measurement.fromMap(Map<String, dynamic> map) {
    this.loadMap(map);
  }

  @override
  ApiModel clone() {
    return Measurement()
      ..id = this.id
      ..title = this.title
      ..symbol = this.symbol
      ..conversion = this.conversion
      ..convertable = this.convertable
      ..isFraction = this.isFraction;
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.symbol = map['symbol'];
    this.conversion = map['conversion'];
    this.convertable = map['convertable'];
    this.isFraction = map['is_fraction'];
  }

  @override
  int get pk => this.id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'symbol': this.symbol,
      'conversion': this.conversion,
      'convertable': this.convertable,
      'is_fraction': this.isFraction,
    };
  }
}
