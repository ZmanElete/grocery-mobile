import 'package:grocery_genie/models/api_model.dart';

class Tag extends ApiModel {
  int? id;
  String title;
  String onType;

  Tag({
    required this.title,
    this.onType = '',
    this.id,
  });

  Tag.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        onType = map['on_type'];

  @override
  Tag clone() {
    return Tag(
      id: id,
      title: title,
      onType: onType,
    );
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    onType = map['on_type'];
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'on_type': onType,
    };
  }
}
