import 'package:grocery_genie/models/api_model.dart';

class Tag extends ApiModel {
  int? id;
  String title;

  Tag({
    required this.title,
    this.id,
  });

  Tag.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'];

  @override
  Tag clone() {
    return Tag(
      id: id,
      title: title,
    );
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
