import 'package:grocery_list/models/api_model.dart';
import 'package:grocery_list/models/user.dart';

class Household extends ApiModel {
  String id;
  String title;
  List<User> users;

  Household();
  Household.fromMap(Map<String, dynamic> map) {
    this.loadMap(map);
  }

  String get pk => this.id;

  void loadMap(Map<String,dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.users = [];
    for(Map<String, dynamic> user in map['user_set']){
      this.users.add(User.fromMap(user));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "user_set": this.users.map((user) => user.toMap()),
    };
  }

  clone() {
    return Household()
      ..id = this.id
      ..title = this.title
      ..users = this.users.map((user) => user.clone());
  }
}
