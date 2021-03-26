import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/user.dart';

class Household extends ApiModel {
  String? id;
  String title;
  List<User> users;

  Household({this.id, required this.title, this.users = const []});
  Household.fromMap(Map<String, dynamic> map)
      : id = map['id']!,
        title = map['title']!,
        users = map['user_set']?.map((u) => User.fromMap(u)).toList() ?? [];

  String? get pk => this.id;

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "user_set": this.users.map((user) => user.toMap()),
    };
  }

  Household clone() {
    return Household(
      id: this.id,
      title: this.title,
      users: this.users.map((user) => user.clone()).toList(),
    );
  }

  @override
  void loadMap(Map<String, dynamic> map) {
    id = map['id']!;
    title = map['title']!;
    users = map['user_set']?.map((u) => User.fromMap(u)).toList() ?? [];
  }
}
