import 'package:grocery_list/models/api_model.dart';

class Measurement extends ApiModel {
  int? id;
  String title;
  String symbol;
  double conversion;
  bool convertable;
  bool isFraction;

  Measurement({
    this.id,
    required this.title,
    required this.symbol,
    required this.conversion,
    required this.convertable,
    required this.isFraction,
  });
  Measurement.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map['title'],
        symbol = map['symbol'],
        conversion = map['conversion'],
        convertable = map['convertable'],
        isFraction = map['isFraction'];

  @override
  Measurement clone() {
    return Measurement(
      id: this.id,
      title: this.title,
      symbol: this.symbol,
      conversion: this.conversion,
      convertable: this.convertable,
      isFraction: this.isFraction,
    );
  }

  @override
  int? get pk => this.id;

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

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map['title']!;
    symbol = map['symbol']!;
    conversion = map['conversion']!;
    convertable = map['convertable']!;
    isFraction = map['isFraction']!;
  }
}
