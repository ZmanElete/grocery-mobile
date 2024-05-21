import 'package:grocery_genie/models/user.dart';
import 'package:guru_flutter_rest/django/api_model.dart';

class Household extends ApiModel {
  String? id;
  String title;
  List<User> users;

  Household({this.id, required this.title, this.users = const []});
  Household.fromJson(Map<String, dynamic> map)
      : id = map['id']!,
        title = map['title']!,
        users = List<User>.from((map['user_set'] as List?)?.map((map) => User.fromJson(map)).toList() ?? []);

  @override
  String? get pk => id;

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "user_set": users.map((user) => user.toJson()),
    };
  }

  Household clone() {
    return Household(
      id: id,
      title: title,
      users: users.map((user) => user.clone()).toList(),
    );
  }
}
