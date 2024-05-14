import 'package:guru_flutter_rest/django/api_model.dart';

class Tag extends ApiModel implements Comparable {
  int? id;
  String title;
  String onType;

  Tag({
    required this.title,
    this.onType = '',
    this.id,
  });

  Tag.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        onType = map['on_type'];

  factory Tag.fromDynamic(info) {
    if (info is Tag) {
      return info;
    } else if (info is Map<String, dynamic>) {
      return Tag.fromJson(info);
    }
    throw Exception("Type ${info.runtimeType} is not of type [Map<String, dynamic>] or [Tag]");
  }

  Tag clone() {
    return Tag(
      id: id,
      title: title,
      onType: onType,
    );
  }

  void loadMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    onType = map['on_type'];
  }

  @override
  int? get pk => id;

  @override
  Map<String, dynamic> toJson() {
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
