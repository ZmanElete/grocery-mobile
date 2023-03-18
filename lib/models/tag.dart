import 'package:grocery_genie/models/api_model.dart';

class Tag extends ApiModel implements Comparable {
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

  factory Tag.fromDynamic(info) {
    if (info is Tag) {
      return info;
    } else if (info is Map<String, dynamic>) {
      return Tag.fromMap(info);
    }
    throw Exception("Type ${info.runtimeType} is not of type [Map<String, dynamic>] or [Tag]");
  }

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

  @override
  int compareTo(other) {
    if (other is Tag) {
      return title.compareTo(other.title);
    }
    throw Exception('Tags can only be compared to other tags');
  }

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Tag) {
      return title == other.title && onType == other.onType;
    }
    return super == other;
  }
}
