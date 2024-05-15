import 'package:grocery_genie/managers/measurement_manager.dart';
import 'package:guru_flutter_rest/django/api_model.dart';
import 'package:guru_provider/guru_provider/repository.dart';

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
  Measurement.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        title = map['title'],
        symbol = List<String>.from(map['symbol_set']),
        conversion = map['conversion'],
        convertible = map['convertible'],
        isFraction = map['is_fraction'];

  /// If its a Measurement objects, returns the Measurement.clone()
  /// If its a map, runs it through the fromJson constructor
  /// If its a number looks it up the MeasurementsManager
  /// Else throws and error
  factory Measurement.fromDynamic(info) {
    if (info is Measurement) {
      return info;
    } else if (info is Map<String, dynamic>) {
      return Measurement.fromJson(info);
    } else if (info is int) {
      if (!Repository.instance.read(MeasurementListManager.key).initialized) {
        throw Exception('Measurement Manager is not intialized.');
      }
      return Repository.instance.read(MeasurementListManager.key).list.value!.firstWhere((element) => element.id == info);
    }
    throw Exception(
        "Type ${info.runtimeType} is not of type [Map<String, dynamic>], [Measurement] or [int] (as an id).");
  }

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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'symbol': symbol,
      'conversion': conversion,
      'convertible': convertible,
      'is_fraction': isFraction,
    };
  }

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
