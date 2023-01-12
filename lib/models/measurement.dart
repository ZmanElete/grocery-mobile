import 'package:grocery_list/models/api_model.dart';

class Measurement extends ApiModel {
  int id;
  String title;
  List<String> symbol;
  double conversion;
  bool convertible;
  bool isFraction;

  Measurement({
    required this.id,
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
      id: id,
      title: title,
      symbol: symbol,
      conversion: conversion,
      convertible: convertible,
      isFraction: isFraction,
    );
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'symbol': symbol,
      'conversion': conversion,
      'convertible': convertible,
      'is_fraction': isFraction,
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

  @override
  String toString() {
    return symbol.isNotEmpty ? symbol.first : title;
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        id,
        title,
      );

  @override
  bool operator ==(Object other) {
    return other is Measurement &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.title == title;
  }
}
