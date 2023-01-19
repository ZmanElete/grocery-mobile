import 'package:grocery_genie/models/api_model.dart';
import 'package:grocery_genie/models/user.dart';

class Household extends ApiModel {
  String? id;
  String title;
  List<User> users;

  Household({this.id, required this.title, this.users = const []});
  Household.fromMap(Map<String, dynamic> map)
      : id = map['id']!,
        title = map['title']!,
        users = map['user_set']?.map(User.fromMap).toList() ?? [];

  @override
  String? get pk => id;

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "user_set": users.map((user) => user.toMap()),
    };
  }

  @override
  Household clone() {
    return Household(
      id: id,
      title: title,
      users: users.map((user) => user.clone()).toList(),
    );
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id']!;
    title = map['title']!;
    users = map['user_set']?.map(User.fromMap).toList() ?? [];
  }
}
