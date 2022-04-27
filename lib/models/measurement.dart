import 'package:grocery_list/models/api_model.dart';

class Measurement extends ApiModel {
  int? id;
  String title;
  List<String> symbol;
  double conversion;
  bool convertible;
  bool isFraction;

  Measurement({
    this.id,
    required this.title,
    required this.symbol,
    required this.conversion,
    required this.convertible,
    required this.isFraction,
  });
  Measurement.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map['title'],
        symbol = List<String>.from(map['symbol_set']),
        conversion = map['conversion'],
        convertible = map['convertible'],
        isFraction = map['is_fraction'];

  @override
  Measurement clone() {
    return Measurement(
      id: this.id,
      title: this.title,
      symbol: this.symbol,
      conversion: this.conversion,
      convertible: this.convertible,
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
      'convertible': this.convertible,
      'is_fraction': this.isFraction,
    };
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map['title']!;
    symbol = map['symbol']!;
    conversion = map['conversion']!;
    convertible = map['convertible']!;
    isFraction = map['isFraction']!;
  }
}
